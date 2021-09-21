FROM debian
RUN apt-get -y update \
    && apt-get -y install apt-utils git automake autoconf gcc \
    uml-utilities libtool build-essential git pkg-config \
    linux-headers-amd64 iperf screen python3-pip wget
WORKDIR /
RUN wget http://openvswitch.org/releases/openvswitch-2.11.0.tar.gz \
    && tar xvfz openvswitch-2.11.0.tar.gz
WORKDIR /openvswitch-2.11.0
RUN ./boot.sh \
    && ./configure --disable-ssl --disable-libcapng \
    && make \
    && make install \
    && make modules_install \
    && modprobe openvswitch
RUN mkdir -p /usr/local/etc/openvswitch \
    && mkdir -p /usr/local/var/run/openvswitch \
    && mkdir -p /usr/local/var/log/openvswitch
RUN ovsdb-tool create /usr/local/etc/openvswitch/conf.db \
    /local/openvswitch-2.11.0/vswitchd/vswitch.ovsschema
