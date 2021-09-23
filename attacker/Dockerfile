FROM mizzouceri/ovs-base:latest
MAINTAINER Songjie Wang "wangso@missouri.edu"

COPY local/* /local/
RUN apt-get --allow-releaseinfo-change update \
    && apt-get -y install slowhttptest hydra