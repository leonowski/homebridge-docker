FROM nodesource/xenial
#FROM nodesource/jessie:5.8.0
MAINTAINER Christian Brandlehner <christian@brandlehner.at>

##################################################
# Set environment variables                      #
##################################################

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

##################################################
# Install tools                                  #
##################################################

RUN apt-get update
RUN apt-get install -y apt-utils 
RUN apt-get install -y apt-transport-https
RUN apt-get install -y locales
RUN apt-get install -y curl wget git python build-essential make g++ libavahi-compat-libdnssd-dev libkrb5-dev vim net-tools nano
RUN alias ll='ls -alG'

# Update NPM and nodejs to .10
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN npm install npm@latest -g

##################################################
# Install homebridge                             #
##################################################

RUN npm install -g homebridge --unsafe-perm

# depending on your config.json you have to add your modules here!
RUN npm install -g homebridge-homeassistant --unsafe-perm
RUN npm install -g homebridge-ssh-garagedoor --unsafe-perm
#RUN npm install -g homebridge-mqttswitch --unsafe-perm
#RUN npm install -g homebridge-edomoticz --unsafe-perm

##################################################
# Start                                          #
##################################################

USER root
RUN mkdir -p /var/run/dbus

ADD image/run.sh /root/run.sh

EXPOSE 5353 51826
CMD ["/root/run.sh"]
