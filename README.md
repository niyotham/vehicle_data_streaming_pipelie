# A Vehicle_data_streaming-app
A Scalable aws streaming Application for real time reporting of the movement of the cars.
THis application gather latitudes and longituttes of the moving cars, and the persist the data into AWS S3 and Redishift for data analyst to monitor cars movements and other partens.

# System Architecture

![](https://github.com/niyotham/vehicle_data_streaming_pipelie/blob/master/docs/CapstoneProject_Diagram%20(1).jpg)
The Steps to folow:
- [ ] Write a script to generale real time vehicle data
- [ ] `AWS CODECOMMIT SETUP`  Commit the local code to the AWS Codecommit: [AWS CODECOMMIT SETUP](https://github.com/niyotham/vehicle_data_streaming_pipelie/blob/master/docs/AWS%20SERVICES%20COVERED%20BY%20THIS%20PROJECT.docx)
>  Setting up AWS CodeCommit IAM User with HTTPs Git Credential for AWS CodeCommit.
> Create CodeCommit Repo `{not ecr repo!!!!!!}`
>  Copy GitHub Repo Data to AWS CodeCommit
- [ ] `AWS CODEBUILD SETUP`
1. Prepare ECR for CodeBuild.
2. Sett up CodeBuild
3.  Setup IAM roles and permissions To allow CodeBuild to push Docker images to ECR Note docker image can be pushed to dockerhub instead

      
- send data to redshift
2. create a lambda function to load data into s3 or Readshift
3. read data into a csv
4. do visualization

# python_dependancies_cloud9

1. sudo amazon-linux-extras install python3.8

2. curl -O https://bootstrap.pypa.io/get-pip.py

3. python3.8 get-pip.py --user

4. sudo python3.8 -m pip install psycopg2-binary -t python/

5. zip -r dependancies.zip python
