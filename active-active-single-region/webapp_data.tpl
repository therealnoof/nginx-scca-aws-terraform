#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install docker.io -y
sudo docker run -rm -p 3000:443 bkimminich/juice-shop