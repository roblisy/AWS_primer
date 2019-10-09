### Spectrum Steps

Prep:
- Open your favorite SQL client
- Login to the AWS console
- Find your AWS credentials file (usually in ~/.aws/credentials)

Unload and verify the data:
- UNLOAD() our chosen table to S3

```
UNLOAD ('SELECT * FROM sbox.eligible_population')
TO 's3://mozbi-sandbox/spectrum_tutorial/r<your_name_here>'
credentials 'aws_access_key_id=<your access key>;aws_secret_access_key=<your secret access key>';
```
N.B. - AWS recommends you use an IAM role for UNLOAD, I haven't figured that out though.

- Check the AWS console
    - Are your files there?
    - What do they look like?

