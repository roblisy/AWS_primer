## Athena / Spectrum

**Why are we talking about 2 services?**  
   Athena and Spectrum are both AWS services which allow you to query data that lives in S3. Under the hood they are both doing very similar things - namely they use AWS's native I/O and computing power to directly work on S3 data. Athena and Spectrum do differ in a few small ways, but the underlying technology (Presto) is the same.

#### Benefits
- You don't have to move the data  
        - copying data from S3 into/out of Redshift is sometimes expensive, cost prohibitive, or annoying
- You get (almost) unlimited resources  
        - S3 is built for insane levels of I/O, redundancy, and parallelism.  
        - the compute portion of the query is handled and managed by Amazon.

#### Costs
- Each query costs $5 / Tb of *scanned* data  
        - This switches from a fixed cost model to variable costs  
        - There are ways to minimize these costs, but there is no way to avoid them entirely.

#### Spectrum Workshop Goals
- Unload a table from our Redshift cluster to S3
- Create a schema (DDL) on top of the S3 object using Glue
- Query the S3 object using Spectrum / Athena.

[The workshop instructions continue here](spectrum_steps.md)

[A good additional reference and more explanation is here.](https://github.com/aws-samples/serverless-data-analytics)