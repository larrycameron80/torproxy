FROM ubuntu:16.04

COPY 00-aptbug /etc/apt/apt.conf.d/
RUN ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime

RUN DEBIAN_FRONTEND=noninteractive apt-get clean
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get --yes install apt-utils locales locales-all
RUN DEBIAN_FRONTEND=noninteractive apt-get --yes upgrade
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get --yes install tor net-tools iftop pwgen
COPY torrc /etc/
COPY run_tor.sh /
RUN /bin/mkdir -p /var/run/tor/
RUN /bin/chown debian-tor /var/run/tor/
RUN chmod +x /run_tor.sh

EXPOSE 9050 9051
ENTRYPOINT /run_tor.sh
