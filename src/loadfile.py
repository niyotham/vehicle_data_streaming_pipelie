import sys, os
from dotenv import dotenv_values, load_dotenv
import boto3
import pandas as pd
sys.path.append("../")


load_dotenv()

##get access variable to aws
# config = dotenv_values(".env")
# region_name= config['region_name']
# aws_access_key_id = config['aws_access_key_id']
# aws_secret_access_key = config['aws_secret_access_key']

region_name= os.getenv('region_name')
aws_access_key_id = os.getenv('aws_access_key_id') 
aws_secret_access_key = os.getenv('aws_secret_access_key')


def create_s3_client(region_name,aws_access_key_id,aws_secret_access_key):
    """ Function to get aws s3 client"""
    s3_client = boto3.client('s3',
    region_name= region_name,
    aws_access_key_id = aws_access_key_id ,
    aws_secret_access_key = aws_secret_access_key )
    return s3_client

def create_sns_client(region_name,aws_access_key_id,aws_secret_access_key):
    """ Function to get aws sns client"""
    sns_client = boto3.client('sns',
    region_name= region_name,
    aws_access_key_id = aws_access_key_id ,
    aws_secret_access_key = aws_secret_access_key )
    return sns_client

def firehose_client(region_name,aws_access_key_id,aws_secret_access_key):
    clientkinesis = boto3.client('kinesis',
                                 region_name=region_name,
                                aws_access_key_id=aws_access_key_id,
                                aws_secret_access_key=aws_secret_access_key
                                )
    return clientkinesis

def upload_file_to_s3(client, bucket_name, filename, key):
    try:
        client.upload_file(Bucket=bucket_name,
                # Set filename and key
                Filename=filename, 
                Key=key,
                #  ExtraArgs = {
                #     'ACL': 'public-read'}
                        )
        print(f'file uploaded successfull to {bucket_name} ')
    except Exception as e:
        print(f'File not uploaded because of the {e} error.')

def bucket_create(name):
    #create a bucket
    s3_client = create_s3_client(region_name,
                                 aws_access_key_id,
                                 aws_secret_access_key)
    response= s3_client.create_bucket(Bucket=name)
    print(f" bucket {name} Successifly created")
    bucket_list = s3_client.list_buckets()['Buckets']
    return response, bucket_list

if __name__ == "__main__":
    # s3_client = create_s3_client(region_name,aws_access_key_id,aws_secret_access_key)
    # sns_client=create_sns_client(region_name,aws_access_key_id,aws_secret_access_key)
    try:
        name= "vehicle-lat-staging"
        bucket_create(name)
        print(f" bucket {name} Successifly created")
    except Exception as e :
        print("Bucket not created", e)

    # name= "vehicle-staging"
    # bucket_create(name)