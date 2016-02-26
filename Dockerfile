FROM ubuntu:14.04
MAINTAINER Adrian Moreno <adrian@morenomartinez.com>

RUN apt-get update &&\
  apt-get install -y wget python python-pip python-dev libssl-dev libffi-dev bash

RUN mkdir /app
WORKDIR /app

RUN wget https://github.com/jwilder/docker-gen/releases/download/0.7.0/docker-gen-linux-amd64-0.7.0.tar.gz &&\
  tar xvzf docker-gen-linux-amd64-0.7.0.tar.gz -C /usr/local/bin

RUN pip install python-etcd

ADD . /app

ENV DOCKER_HOST unix:///var/run/docker.sock

CMD docker-gen -interval 10 -watch -notify "python /tmp/register.py" etcd.tmpl /tmp/register.py
