# *insight-docker*

An Attempt at an bitcore insight node running behind nginx inside docker. Nginx hosts & forces ssl. No load-balancing (yet).

Make sure you put your SSL certs files inside /home/deploy/ssl, otherwise you have to modify the supervisor conf file.

### Basic installation guidelines

lockdown your server (fail2ban, ssh, etc)

    ufw default deny
    ufw allow 22
    ufw allow 80
    ufw allow 443
    ufw allow 8333
    ufw enable
    
    
### Bootstrap the blockchain
install rtorrent, get the blockchain bootstrap.

    apt-get install rtorrent
    rtorret
    #press enter, download :
    magnet:?xt=urn:btih:cb7caf0b4c0ee266cce5fbd8f8ba3903f5efa82e&dn=bootstrap.dat&tr=udp://tracker.openbittorrent.com:80&tr=udp://tracker.publicbt.com:80&tr=udp://tracker.ccc.de:80&tr=udp://tracker.istole.it:80
    sha1sum bootstrap.dat

Verify the sha1sum : 78a4b41ba7ed823c78cd9ca81a6de393c0ccc226

This bootstrap file will get you in sync with the blockchain a lot faster. Still no torrent for the Insight Leveldb (yet). This will take hours to sync.

    cd ~
    mkdir .bitcoin
    mv bootstrap.dat .bitcoin/
    cp bitcoin.conf .bintcoin/
    mkdir .insight/
 
### Build your dockerfile

    sudo docker build -t insight .
    sudo docker run -p 80:80 -p 443:443 -p 8333:8333 -i -t -v ~/.bitcoin:/data/bitcoin -v ~/.insight:/data/insight -v ~/ssl:/data/ssl insight /bin/bash
 
Inside the docker shell, start bitcoind for the first time, let it sync the blockchain for a bit. Otherwise, when you actually start insight it will die in annoying ways

    bitcoind -datadir='/data/bitcoin' -reindex -rpcallowip='127.0.0.1' &
    bitcoind -datadir='/data/bitcoin' getinfo


 
### Install supervisor
 
    sudo apt-get install supervisor
    #copy supervisor file
    sudo cp insight-supervisor.conf /etc/supervisor/conf.d/
    sudo service supervisor restart
    
### Example:

https://search.bitaccess.ca/
(Self signed cert for test...)
    
