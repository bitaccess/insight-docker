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
RUN npm install -g bitcore
ADD bitcore-node.json /root/.bitcore/
RUN git clone https://github.com/bitaccess/insight-api.git && cd insight-api && git checkout 294500f49315ee968fb0dfd0d79bce170ee902ee
RUN cp -rf insight-api/lib/* /usr/local/lib/node_modules/bitcore/node_modules/insight-api/lib/
RUN git clone https://github.com/bitaccess/insight.git && cd insight && git checkout 58a2cf4629dae805da4d017bfe31f4b1f388d6f7
RUN cp -rf insight/* /usr/local/lib/node_modules/bitcore/node_modules/insight-ui/
EXPOSE 3000 18333
ENTRYPOINT "bitcored"
