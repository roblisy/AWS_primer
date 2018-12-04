/*
 * Disclaimer - I just found a query, I'm not picking on anyone.
 * Be nice, anyone can (and will) get caught writing sub-optimal queries. It's happened to me, it'll happen to you.
 *
 * Hunting down the people who make poor queries and confronting them or publically shaming them
 * is not cool.
 * 
 * The LAN ID associated with the table name below IS NOT the user who wrote and executed this query.
 * 
 */

/* bad query using poor practices */
/* we will NOT be running this, the DBAs would get upset... */
CREATE TEMP TABLE all_touches 
	DISTKEY (cust_key) 
	SORTKEY (view_tmstp) AS (
		SELECT
			DISTINCT
			CASE
				WHEN cc.cust_key IS NOT NULL THEN CAST (cc.cust_key as varchar (128))
				ELSE CAST (t.cust_key as varchar(128))
			END as cust_key ,
			t.cookie ,
			t.session ,
			t.view_tmstp ,
			t.view_date ,
			t.platform ,
			t.final_channel ,
			t.order_no ,
			t.order_tot_amt
		FROM
			bi_usr.c35e_mta_v2_alltouches_v2 t
		LEFT JOIN bi_prd.cookie_to_custkey cc ON
			t.cookie = cc.domain_userid);


/* let's start to make things better! */
/* first, let's use a query group*/

/* Not rhetorical question: What's a query group?? */
set query_group to 'QG_S';

/* next, get information about our tables... */
select *
from svv_table_info
where 1=1
and ("table" like '%c35e_mta_v2_alltouches_v2%' or "table" = 'cookie_to_custkey')
and ("schema" like '%bi_usr%' OR "schema" = 'bi_prd');


/* we've learned:
+---------------------------+-----------+---------------+-----------+--------+-----------+
|           Table           | DISTSTYLE |    DISTKEY    |  SORTKEY  |  SIZE  |   ROWS    |
+---------------------------+-----------+---------------+-----------+--------+-----------+
| cookie_to_custkey         | KEY       | domain_userid | [NULL]    |   5920 |  18617369 |
| c35e_mta_v2_alltouches_v2 | KEY       | CUST_KEY      | VIEW_DATE | 219571 | 305061486 |
+---------------------------+-----------+---------------+-----------+--------+-----------+
 */

/* so we're joining a BIG table (alltouches) with a smaller (but still big) table */
/* let's change this! */

/* first - we'll re-create the cookie_to_custkey mapping, using the CUST_KEY as the distribution key */
/* YES - this duplicates data, but NO, that's not a problem! Redshift is built upon the idea that storage is cheap! */
create temp TABLE tmp_cookie_to_custkey
	DISTKEY (cust_key) 
	SORTKEY (domain_userid) 
	as (select * from bi_prd.cookie_to_custkey);

/* while we're at it, we're going to add a filter to our SORTKEY value */

/* 
 * What does a sortkey do?
 * ===========================
 * A sortkey operates LIKE (but not exactly like!) an index - it allows the database to SKIP reading
 * some porion of the data. Sortkeys should not be compressed (it defeats the purpose).
 * 
 * Sort keys determine the order of the data on disk. If you use them in a WHERE clause then
 * the database knows it can SKIP certain records.
 * 
 * Sort keys don't work well with SQL functions applied to them - in fact they don't work at all.
 *
 */
	
drop table if exists all_touches; 
CREATE TEMP TABLE all_touches 
	DISTKEY (cust_key) 
	SORTKEY (view_tmstp) AS (
		SELECT
			DISTINCT
			CASE
				WHEN cc.cust_key IS NOT NULL THEN CAST (cc.cust_key as varchar (128))
				ELSE CAST (t.cust_key as varchar(128))
			END as cust_key ,
			t.cookie ,
			t.session ,
			t.view_tmstp ,
			t.view_date ,
			t.platform ,
			t.final_channel ,
			t.order_no ,
			t.order_tot_amt
		FROM
			bi_usr.c35e_mta_v2_alltouches_v2 t
		LEFT JOIN tmp_cookie_to_custkey cc ON
			t.cookie = cc.domain_userid
		where 1=1
		and view_date >= current_date - 10);
	
/* We've gone from a query which got a few folks yelled at by the DBAs to one which executes in < 1 minute */
