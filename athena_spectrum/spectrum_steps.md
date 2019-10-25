### Spectrum Steps

Prep:
- Open your favorite SQL client
- Login to the AWS console
- Find your AWS credentials file (usually in ~/.aws/credentials)

Unload and verify the data:
- UNLOAD() our chosen table to S3

```
UNLOAD ('SELECT * FROM sbox.eligible_population')
TO 's3://mozbi-sandbox/spectrum_tutorial/<your_name_here>/'
credentials 'aws_access_key_id=<your access key>;aws_secret_access_key=<your secret access key>';
```
N.B. - AWS recommends you use an IAM role for UNLOAD, I haven't figured that out though.

- Check the AWS console
    - Are your files there?
    - What do they look like?

#### Create the data definition:
Spectrum can be setup to read from 2 catalogs: Athena or AWS Glue.
- The Athena catalog pairs an Athena DB directly to a Redshift schema (1:1). This means anything created in either location will show up in the other. Make a table in Athena? It'll be available in your Redshift Spectrum schema. 


```
CREATE EXTERNAL TABLE <your_name>_eligible_population
(
	subscription_id INT,
	user_id INT,
	account_id INT,
	start_date DATE,
	first_billing_date DATE,
	pay_start_date DATE,
	end_date DATE,
	paying_month INT,
	latest_calendar_date DATE,
	vested INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
'field.delim' = '|')
STORED AS TEXTFILE
LOCATION 's3://mozbi-sandbox/spectrum_tutorial/<your_name>/';
```  

Query the data (Redshift):
```
SELECT *
FROM spectrum.<your_name>_eligible_population
LIMIT 100;
```


#### Why switch between Athena and Spectrum/Redshift?
This is weird... Athena and Spectrum (the way I've set it up) share a data catalog (which is great!). We _should_ be able to simply CREATE TABLE within the Spectrum schema inside of Redshift. However apparently you have to be the *owner* of the schema to create a stupid table.... This makes no sense. We just get around this hiccup by creating the table in Athena, then querying it in Spectrum.

[See documentation here if you're curious](https://docs.aws.amazon.com/redshift/latest/dg/r_GRANT.html).

[Here's another poor soul complaining about this problem as well.](https://forums.aws.amazon.com/thread.jspa?messageID=799808)
