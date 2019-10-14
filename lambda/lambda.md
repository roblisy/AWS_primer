### Lambda

##### What is it?  
Lambdas allow so called "serverless" execution of arbitrary code. They remove the need for development teams to monitor and provision servers.

Pros:
- you just write code!  
- you can trigger events off of other AWS actions / services!  
- can be deployed as an edge service (Lambda@Edge)  

Cons:
- Lambdas must run in a very small footprint   
    - 512 Mb disk
    - 50 Mb deployment package
    - 3 Gb RAM
    - 15 minutes max execution time
    - other stuff... [check the site](https://docs.aws.amazon.com/lambda/latest/dg/limits.html)  
- they cost money

#### Simple Lambda for file copy
- Create a new Lambda
- Attach an IAM role that allows CloudWatch (LambdaBasicExecution) and S3 (S3FullAccess)
- Add a trigger on an S3 bucket with a prefix
- Paste the [contents of the Python function](lambda_function.py) into the lambda function code block.
- change any strings, if necessary
- drop the test csv file to the source directory
- check the output S3 location

#### Sooooo what??
This example is super simple, but it can be quite complex. Imagine the following application:

- Users log into the site
- they upload a JPEG file with their own photograph
- they press a button in Moz Pro to initiate a site crawl
- they create and save a custom report
- they want that custom report emailed to them / a client

Which parts could have a Lambda behind them?
