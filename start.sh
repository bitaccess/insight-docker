bitcoind -datadir='/data/bitcoin' -daemon -rpcallowip='127.0.0.1'
sleep 20
service nginx start &
INSIGHT_NETWORK=livenet BITCOIND_USER=user BITCOIND_PASS=pass INSIGHT_PUBLIC_PATH=/opt/insight/public INSIGHT_DB=/data/insight /usr/bin/forever start --sourceDir /opt/insight/ -l /var/log/forever.out.log -o /var/log/insight.out.log -e /var/log/insight.err.log
echo "Started all.."