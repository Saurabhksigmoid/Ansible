#!/bin/bash
sudo apt update 
sudo apt upgrade -y
sudo apt -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update
sudo apt install ansible -y
sudo apt install python3-argcomplete
sudo activate-global-python-argcomplete3
sudo apt install mysql-client-core-8.0 -y