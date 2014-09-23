#!/bin/bash
git pull
./clean_docker
sudo docker rmi insight
sudo docker build -t insight .

