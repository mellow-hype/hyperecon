#!/usr/bin/env bash
# Install some basic stuff
sudo apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
sudo apt-get install -y python-setuptools
sudo apt-get install -y libldns-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y nmap
sudo apt-get install -y python-pip
sudo apt-get install -y python-dnspython
sudo apt-get install -y git

# Get some more payloads
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git payloads/

# set up initial dirs
mkdir targets
