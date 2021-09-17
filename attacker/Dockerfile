FROM debian
MAINTAINER Songjie Wang "wangso@missouri.edu"

RUN apt -y update
RUN mkdir /local
COPY local/* /local/.
WORKDIR /local
RUN bash ./attacker_preinstall.sh
RUN bash ./attacker_config.sh
