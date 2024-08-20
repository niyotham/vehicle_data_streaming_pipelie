# A Vehicle data streaming data engineering application.
A Scalable aws streaming Application for real time reporting of the movement of the cars.
THis application gather latitudes and longituttes of the moving cars, and the persist the data into AWS S3 and Redishift for data analyst to monitor cars movements and other partens.

# System Architecture

![](https://github.com/niyotham/vehicle_data_streaming_pipelie/blob/master/docs/CapstoneProject_Diagram%20(1).jpg)
The Steps to folow:
- [ ] Write a script to generale real time vehicle data
- [ ]  Write a script or create a lambda function to load data into s3 
- [ ] Sending data to redshift
 ### --- external schema for kinesis ---
```sql
 CREATE EXTERNAL SCHEMA streamdataschema
FROM KINESIS
IAM_ROLE 'arn:aws:iam::533267024701:role/redshiftkinesisrole';
```
### ---- create materialized view ----
``` sql
CREATE MATERIALIZED VIEW devicedataview AS
    SELECT approximate_arrival_timestamp,
    partition_key,
    shard_id,
    sequence_number,
    json_parse(from_varbyte(kinesis_data, 'utf-8')) as payload    
    FROM streamdataschema."d2d-app-kinesis-stream";
```
	
### ---- refresh view ----
```sql
REFRESH MATERIALIZED VIEW <VIEW_NAME>;
```
### --- select data from view ----
``` sql
select * from <VIEW_NAME>
```
- [ ] `AWS CODECOMMIT SETUP`  Commit the local code to the AWS Codecommit: [AWS CODECOMMIT SETUP](https://github.com/niyotham/vehicle_data_streaming_pipelie/blob/master/docs/AWS%20SERVICES%20COVERED%20BY%20THIS%20PROJECT.docx)
1.  Setting up AWS CodeCommit IAM User with HTTPs Git Credential for AWS CodeCommit.
2.  Create CodeCommit Repo `{not ecr repo!!!!!!}`
3.  Copy GitHub Repo Data to AWS CodeCommit
- [ ] `AWS CODEBUILD SETUP` [AWS CODEBUILD SETUP](https://github.com/niyotham/vehicle_data_streaming_pipelie/blob/master/docs/AWS%20SERVICES%20COVERED%20BY%20THIS%20PROJECT.docx)
1. Prepare ECR for CodeBuild.
2. Sett up CodeBuild
3.  Setup IAM roles and permissions To allow CodeBuild to push Docker images to ECR Note docker image can be pushed to dockerhub instead
- [ ] `CODEDEPLOY` Takes docker image created in codebuild stage and deploy to ecs  [AWS CODEDEPLOY SETUP](https://github.com/niyotham/vehicle_data_streaming_pipelie/blob/master/docs/AWS%20SERVICES%20COVERED%20BY%20THIS%20PROJECT.docx)
1. Make Available ECS service infrastructure
2. Create Deploy Stage
3.  Run the Pipeline by making changes in the local repo and pushing to  CodeCommit
	

- [ ]    read data into a csv
- [ ]    do visualization

## Additional dependencies for python_dependancies_cloud9 if you want to use psycopg2

1. sudo amazon-linux-extras install python3.8

2. curl -O https://bootstrap.pypa.io/get-pip.py

3. python3.8 get-pip.py --user

4. sudo python3.8 -m pip install psycopg2-binary -t python/

5. zip -r dependancies.zip python
