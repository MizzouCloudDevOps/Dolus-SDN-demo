FROM debian
MAINTAINER Songjie Wang "wangso@missouri.edu"

RUN apt -y update
RUN mkdir /local
COPY local/* /local/.
WORKDIR /local
RUN bash ./user_config.sh

 