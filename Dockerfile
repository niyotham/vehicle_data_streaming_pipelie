# FROM python:3.8-alpine
# #FROM  public.ecr.aws/docker/library/python:3.10

# Use an official Python runtime as the base image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file to the container
COPY requirements.txt . 

# Copy the rest of the application's source code to the container
COPY . .

# Install the Python dependencies
RUN apk update && apk upgrade --no-cache
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt

# RUN chmod+x ./src/*

# Expose the port on which the application will run (replace 8000 with your desired port)
EXPOSE 8000

# USER 1001
# ENV PYTHONUNBUFFERED 1

# Define the command to run your application
CMD ["python", "app.py"]