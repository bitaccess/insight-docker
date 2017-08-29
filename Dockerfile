
FROM ubuntu:16.04
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
        libzmq3-dev \
        vim \
    && rm -rf /var/lib/apt/lists/*

# Install node.js
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -yqq nodejs
RUN npm i -g npm@5


# Install Bitcore
RUN npm install --unsafe-perm -g satoshilabs/bitcore#43b2aaa39b96b2254261da4b4467c869505cc416
ADD bitcore-node.json /root/.bitcore/

# Patch insight api
RUN git clone https://github.com/bitaccess/insight-api.git && cd insight-api && git checkout f18ccea9663c1a57690a51f07631b503288be75c
RUN cp insight-api/lib/status.js /usr/lib/node_modules/bitcore/node_modules/insight-api/lib/
RUN cp insight-api/lib/transactions.js /usr/lib/node_modules/bitcore/node_modules/insight-api/lib/

# Patch insight ui
RUN rm -rf /usr/lib/node_modules/bitcore/node_modules/insight-ui
RUN git clone https://github.com/bitaccess/insight.git && cd insight && git checkout e51b172b6ba590d89cfa52964ec413b8fcbd9a12 
RUN mv insight /usr/lib/node_modules/bitcore/node_modules/insight-ui

EXPOSE 3001 8333
ENTRYPOINT "bitcored"
