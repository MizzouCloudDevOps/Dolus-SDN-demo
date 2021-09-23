FROM mizzouceri/ovs-base:latest
MAINTAINER Songjie Wang "wangso@missouri.edu"

COPY local/* /local/
RUN apt-get --allow-releaseinfo-change update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
       debconf-utils tshark bwm-ng mariadb-server \
    && pip3 install mysql-connector-python