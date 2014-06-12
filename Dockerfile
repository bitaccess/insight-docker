############################################################
# Dockerfile to run bitcoind, and insight behind nginx
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:precise

# File Author / Maintainer
MAINTAINER Moe Adham <moe@bitaccess.ca>

# Install Nginx

# Add application repository URL to the default sources
RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring main universe" >> /etc/apt/sources.list

# Update the repository
RUN apt-get update

# Install necessary tools
RUN apt-get install -y git wget dialog net-tools

# Download and Install Nginx
RUN apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# install bitcoind
RUN       wget https://bitcoin.org/bin/0.9.1/bitcoin-0.9.1-linux.tar.gz
RUN       tar xzf bitcoin-0.9.1-linux.tar.gz
RUN       cp /bitcoin-0.9.1-linux/bin/64/* /usr/bin/

# install node
RUN        wget http://nodejs.org/dist/v0.10.26/node-v0.10.26-linux-x64.tar.gz
RUN        tar xzf node-v0.10.26-linux-x64.tar.gz
RUN        ln -s /node-v0.10.26-linux-x64/bin/node /usr/sbin/node
RUN        ln -s /node-v0.10.26-linux-x64/bin/npm /usr/sbin/npm

# install insight
RUN        cd /opt && git clone https://github.com/bitpay/insight.git
RUN        cd /opt/insight/ && npm install
RUN        mkdir -p /data/bitcoin
RUN        cp /opt/insight/node_modules/insight-bitcore-api/etc/bitcoind/bitcoin-livenet.conf /data/bitcoin/bitcoin.conf

ADD        start.sh start.sh





# Expose ports
EXPOSE 80
EXPOSE 443
EXPOSE 8333

# Set the default command to execute
# when creating a new container
#CMD service nginx start
ENTRYPOINT [ "/bin/bash" ]
