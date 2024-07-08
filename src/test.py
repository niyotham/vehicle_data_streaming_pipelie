from loadfile import bucket_create, firehose_client
from app import start_process

try:
    name= "vehicle-lat-staging"
    response, bucket_list=bucket_create(name)
    # List the buckets in S3
    for bucket_info in bucket_list:
        # Get the bucket_name
        bucket_name = bucket_info['Name']
        # Generate bucket ARN.
        arn = "arn:aws:s3:::{}".format(bucket_name)
        # Print the ARN
        # print(arn)
except Exception as e :
    print("Bucket not created", e)

# load data to S3 using firehore
clientkinesis= firehose_client()

i=0
start_process(i, clientkinesis)

