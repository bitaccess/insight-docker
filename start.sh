bitcoind -datadir='/data/bitcoin' -daemon -rpcallowip='127.0.0.1'
sleep 60
cd /opt/insight
INSIGHT_NETWORK=livenet BITCOIND_USER=user BITCOIND_PASS=pass INSIGHT_PUBLIC_PATH=public INSIGHT_DB=/data/insight /usr/bin/forever start --sourceDir /opt/insight/ -l /var/log/forever.out.log -o /var/log/insight.out.log -e /var/log/insight.err.log -a node_modules/insight-bitcore-api/insight.js
service nginx start
