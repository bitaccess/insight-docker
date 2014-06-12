bitcoind -datadir='/data/bitcoin' -daemon -rpcallowip='127.0.0.1'
sleep 60
cd /opt/insight-api/
INSIGHT_NETWORK=livenet BITCOIND_USER=user BITCOIND_PASS=pass INSIGHT_PUBLIC_PATH=public  npm start