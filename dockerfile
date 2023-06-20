FROM python:3.8
LABEL version="latest" maintainer="Mohamed Yusuf <>"
RUN mkdir /robot-docker
WORKDIR /robot-docker
COPY . /robot-docker/

RUN pip install -r requirements.txt --proxy=http://rasan:rasan@10.142.6.110:31280
RUN pip -V
RUN pip freeze