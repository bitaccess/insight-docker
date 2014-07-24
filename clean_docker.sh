#!/bin/bash
sudo supervisorctl stop insight.lxc
sudo docker rm `docker ps --no-trunc -a -q`

