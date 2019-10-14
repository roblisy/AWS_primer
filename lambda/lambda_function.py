import json
import csv
import boto3


def lambda_handler(event, context):
    # define source and target.
    s3 = boto3.resource('s3')
    copy_source = {
        'Bucket': 'mozbi-sandbox',
        'Key': 'rob_lambda_example_file_1.csv'
    }
    copy_target = 'mozbi-lambda-output'
    copy_target_key = 'processed_file'
    
    s3.meta.client.copy(copy_source, copy_target, copy_target_key)
    return {
        'statusCode': 200,
        'body': json.dumps('File copied to' + copy_target + copy_target_key)
    }
    
