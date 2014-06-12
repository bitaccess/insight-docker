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
 
 sudo docker build -t insight .
 docker run -p 80:80 -i -t -v ~/.bitcoin:/data/bitcoin insight /bin/bash