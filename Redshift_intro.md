## Redshift Primer

Goal is to review good useage of Redshift, including:
- MPP concepts
- Row vs Column store
- Distribution keys
- Sort keys
- Compression
- Query Groups

##### MPP Concepts and Row vs Column store
- Team excercise involving [Kirk Gibson](https://www.baseball-reference.com/players/g/gibsoki01.shtml) data.

##### Distribution Keys, Sort Keys

- Distribution keys inform how data is spread across the cluster (i.e. which NODE your data goes to)
- Sort keys inform INTRA CLUSTER ordering of the data

##### AWS resources:
- [Chosing the best distribution style](https://docs.aws.amazon.com/redshift/latest/dg/c_best-practices-best-dist-key.html)
- [Chosing SORTKEYS](https://docs.aws.amazon.com/redshift/latest/dg/t_Sorting_data.html)


##### Compression
- useful at the column level!
- check for different recommended encodings (zstd, lzo, others)
- [get recommended compression changes here](https://docs.aws.amazon.com/redshift/latest/dg/r_ANALYZE_COMPRESSION.html) 
