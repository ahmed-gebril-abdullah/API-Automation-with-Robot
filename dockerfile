FROM python:3.8
LABEL version="latest" maintainer="******* <>"
RUN mkdir /robot-docker
WORKDIR /robot-docker
COPY . /robot-docker/

RUN pip install -r requirements.txt --proxy=http://******:*****@10.142.6.110:****
RUN pip -V
RUN pip freeze
