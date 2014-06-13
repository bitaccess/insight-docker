insight-docker
==============

An Attempt at an bitcore insight node running behind nginx inside docker


lockdown your server (fail2ban, ssh, etc)
 ufw default deny
 ufw allow 22
 ufw allow 80
 ufw allow 443
 ufw allow 8333

install rtorrent
rtorret
-press enter, download :
magnet:?xt=urn:btih:cb7caf0b4c0ee266cce5fbd8f8ba3903f5efa82e&dn=bootstrap.dat&tr=udp://tracker.openbittorrent.com:80&tr=udp://tracker.publicbt.com:80&tr=udp://tracker.ccc.de:80&tr=udp://tracker.istole.it:80
sha1sum bootstrap.dat

now you have bootstrap.dat, verify sha1sum
 cd ~
 mkdir .bitcoin
 mv bootstrap.dat .bitcoin/
 cp bitcoin.conf .bintcoin/
 mkdir .insight/
 
 sudo docker build -t insight .
 sudo docker run -p 80:80 -p 443:443 -p 8333:8333 -i -t -v ~/.bitcoin:/data/bitcoin -v ~/.insight:/data/insight -v ~/ssl:/data/ssl insight /bin/bash
 
 bitcoind -datadir='/data/bitcoin' -reindex -rpcallowip='127.0.0.1' &
 bitcoind -datadir='/data/bitcoin' getinfo
 # Let your blockchain index a bit.
  
  
 INSIGHT_NETWORK=livenet BITCOIND_USER=user BITCOIND_PASS=pass INSIGHT_PUBLIC_PATH=public  INSIGHT_DB=/data/insight npm start