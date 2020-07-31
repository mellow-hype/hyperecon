#!/usr/bin/env bash
ROOT=`pwd`

# Install required dependencies and tools
sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y jq
sudo apt-get install -y ruby-full
sudo apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
sudo apt-get install -y python-setuptools
sudo apt-get install -y libldns-dev
sudo apt-get install -y python3 python3-pip
sudo apt-get install -y python-pip
sudo apt-get install -y python-requests
sudo apt-get install -y python-dnspython
sudo apt-get install -y git
sudo apt-get install -y rename
sudo apt-get install -y xargs
sudo apt-get install -y nmap

# get wordlists
if [! -d "$ROOT/wordlists" ]; then
    mkdir $ROOT/wordlists
fi

echo "Downloading Seclists"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/
echo "done"

# get more wordlists
cd $ROOT/wordlists
echo "Downloading Commonspeak2 Subdomains wordlist"
wget https://github.com/assetnote/commonspeak2-wordlists/raw/master/subdomains/subdomains.txt -O commonspeak2-all-subs.txt
head -n 1000 commonspeak2-all-subs.txt > commonspeak-top1000-subs.txt
echo "Downloading RobotsDisallowed Top 1000 directories"
wget https://github.com/danielmiessler/RobotsDisallowed/raw/master/top1000.txt -O robots-top1000dirs.txt

# Generate MEGA wordlist for directory bruteforcing
echo "Creating compiled directory bruteforce wordlist MEGA_DIR_DISCOVER.txt"
cat directories.txt >> MEGA_DIR_DISCOVER.txt
cat robots-top1000dirs.txt >> MEGA_DIR_DISCOVER.txt
cat ~/tools/SecLists/Discovery/Web-Content/api/common_paths.txt >> MEGA_DIR_DISCOVER.txt
cat ~/tools/SecLists/Discovery/Web-Content/raft-large-directories-lowercase.txt >> MEGA_DIR_DISCOVER.txt
sort MEGA_DIR_DISCOVER.txt | uniq > MEGA_DIR_DISCOVER.txt

# make a directory for tools in $HOME
if [! -d ~/tools ]; then
    mkdir ~/tools
fi
cd ~/tools

# Install Go
echo "Installing Golang"
GO_STRING="go1.14.6.linux-amd64"
wget https://dl.google.com/go/"$GO_STRING".tar.gz
sudo tar -C /usr/local -xzf "$GO_STRING".tar.gz
export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc

echo "Installing Sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
sudo pip install -r requirements.txt
cd ~/tools
echo "done"

echo "Installing dirsearch"
git clone https://github.com/maurosoria/dirsearch.git
cd ~/tools
echo "done"

echo "Installing sqlmap"
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
cd ~/tools/
echo "done"

echo "Installing JSParser"
git clone https://github.com/nahamsec/JSParser.git
cd JSParser*
sudo python setup.py install
cd ~/tools
echo "done"

echo "installing asnlookup"
git clone https://github.com/yassineaboukir/asnlookup.git
cd ~/tools/asnlookup
pip3 install -r requirements.txt
cd ~/tools/
echo "done"

echo "Installing crtndstry"
git clone https://github.com/nahamsec/crtndstry.git
echo "done"

echo "Installing knock.py"
git clone https://github.com/guelfoweb/knock.git
cd ~/tools/
echo "done"

echo "Installing httprobe"
go get -u github.com/tomnomnom/httprobe
echo "done"

echo "Installing waybackurls"
go get github.com/tomnomnom/waybackurls
echo "done"

echo "Installing unfurl"
go get -u github.com/tomnomnom/unfurl 
echo "done"

echo "Installing massdns"
git clone https://github.com/blechschmidt/massdns.git
cd ~/tools/massdns
make
cd ~/tools/
echo "done"
