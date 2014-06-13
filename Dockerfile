############################################################
# Dockerfile to run bitcoind, and insight behind nginx
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:precise

# File Author / Maintainer
MAINTAINER Moe Adham <moe@bitaccess.ca>

# Update the repository
RUN apt-get -qq update > /dev/null

# Install necessary tools
RUN apt-get install -y git wget dialog net-tools python-software-properties python g++

# install node
RUN apt-add-repository -y ppa:chris-lea/node.js > /dev/null
RUN apt-get -qq update > /dev/null
RUN apt-get install -y make nodejs

# Download and Install Nginx
RUN apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/
ADD ssl/cert.crt /data/ssl/
ADD ssl/cert.key /data/ssl/


# install bitcoind
RUN       wget https://bitcoin.org/bin/0.9.1/bitcoin-0.9.1-linux.tar.gz
RUN       tar xzf bitcoin-0.9.1-linux.tar.gz
RUN       cp /bitcoin-0.9.1-linux/bin/64/* /usr/bin/



# install insight
RUN        cd /opt && git clone https://github.com/bitpay/insight.git
RUN        cd /opt/insight/ && npm install
RUN        npm install -g forever
RUN        mkdir -p /data/bitcoin

ADD        start.sh start.sh

# Expose ports
EXPOSE 80
EXPOSE 443
EXPOSE 8333

# Set the default command to execute
# when creating a new container
#CMD service nginx start
