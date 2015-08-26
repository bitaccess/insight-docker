############################################################
# Dockerfile to run bitcoind, and insight behind nginx
# Based on phusion/baseimage (Ubuntu)
############################################################

# Set the base image to Ubuntu
FROM phusion/baseimage:0.9.16

# File Author / Maintainer
MAINTAINER Allan Hudgins <allan@bitaccess.co>

# Update the repository
RUN apt-get -qq update > /dev/null

# Install necessary tools
RUN apt-get install -y \
  dialog \
  g++ \
  git \
  make \
  net-tools \
  nginx \
  python \
  python-software-properties \
  wget > /dev/null

# install node
RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get -qq update > /dev/null
RUN apt-get install -y nodejs

ADD bitcoin-0.11.0-linux64.tar.gz /data/
# install bitcoind and clean up, keeping image size down
RUN cp /data/bitcoin-0.11.0/bin/* /usr/bin && \
  mkdir -p /data/bitcoin

# install insight
RUN npm install -g forever
RUN echo 3
RUN cd /opt && git clone -b master https://github.com/bitaccess/insight.git
RUN cd /opt/insight/ && npm install --production

# Expose ports
EXPOSE 80
EXPOSE 443
EXPOSE 8333

# Copy nginx configuration file from the current directory
RUN rm /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/nginx.conf

ADD bitcoin.conf /data/bitcoin/bitcoin.conf
ADD sync.sh sync.sh
ADD start.sh start.sh

CMD /start.sh
