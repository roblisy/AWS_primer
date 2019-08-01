## Athena / Spectrum

**Why are we talking about 2 services?**  
   Athena and Spectrum are both AWS services which allow you to query data that lives in S3. Under the hood they are both doing very similar things - namely they use AWS's native I/O and computing power to directly work on S3 data. Athena and Spectrum do differ in a few small ways, but the underlying technology (Presto) is the same.

#### Benefits

- You don't have to move the data  
        - copying data from S3 into/out of Redshift is sometimes expensive, cost prohibitive, or annoying
- You get (almost) unlimited resources  
        - S3 is built for insane levels of I/O, redundancy, and parallelism.
        - the compute portion of the query is handled and managed by Amazon.

#### Example

NYC Taxi cab data - 200Gb of CSVs
- [Import the data into Athena](https://github.com/aws-samples/serverless-data-analytics/tree/master/Lab1#creating-amazon-athena-database-and-table)
- Query using ANSI SQL
- Output is saved to S3 buckets!



[A good workthrough and explanation is here.](https://github.com/aws-samples/serverless-data-analytics)