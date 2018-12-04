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

A really useful Confluence page which Data and Services put together is here:
https://confluence.nordstrom.net/display/TDS/Performance+Tuning+Tips

##### AWS resources:
- [Chosing the best distribution style](https://docs.aws.amazon.com/redshift/latest/dg/c_best-practices-best-dist-key.html)
- [Chosing SORTKEYS](https://docs.aws.amazon.com/redshift/latest/dg/t_Sorting_data.html)


##### Compression
- useful at the column level!
- check for different recommended encodings (zstd, lzo, others)
- [get recommended compression changes here](https://docs.aws.amazon.com/redshift/latest/dg/r_ANALYZE_COMPRESSION.html) 