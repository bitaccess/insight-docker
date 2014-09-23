#!/bin/bash
git pull
./clean_docker.sh
sudo docker rmi insight
sudo docker build -t insight .

