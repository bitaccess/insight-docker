# Warning: node:argon is based off of an odd base image.
FROM node:argon
MAINTAINER Moe Adham <moe@bitaccess.co>

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        python \
        rsync \
        software-properties-common \
        git-core \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install Bitcore

RUN npm i -g npm@5
RUN npm install --unsafe-perm -g bitaccess/insight-api#993da7e317699ad80794ea02e3b3c25a8237658b
RUN npm install --unsafe-perm -g bitaccess/insight#58a2cf4629dae805da4d017bfe31f4b1f388d6f7
RUN npm install --unsafe-perm -g bitaccess/bitcore#fdfd31e47731e6fb6bedd72df0314f1e4b4a7bf9

EXPOSE 3001 8333
ENTRYPOINT "bitcored"
