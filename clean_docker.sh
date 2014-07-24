#!/bin/bash
sudo supervisorctl stop insight.lxc
docker rm `docker ps --no-trunc -a -q`

