FROM python:3.8-alpine
#FROM  public.ecr.aws/docker/library/python:3.10

# USER root
WORKDIR /app/producer
COPY . .

RUN apk update && apk upgrade --no-cache && apk add --no-cache bash

RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt

RUN chmod +x /app/producer/*
#EXPOSE 5000

USER 1001
ENV PYTHONUNBUFFERED=1

CMD ["python3","./src/producer_local.py"]
#CMD tail -f /dev/null