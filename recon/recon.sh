#!/usr/bin/env bash
chromiumPath=/snap/bin/chromium

if [ "$#" != 1 ]; then
    echo "usage: $0 <root_domain>"
    exit 1
fi
TARGET="$1"
ROOT=`pwd`

if [ ! -d "$TARGET" ]; then
    mkdir "$TARGET"
fi

cd $TARGET

echo "[+] Finding subdomains with amass..."
amass enum -ipv4 -noalts -o amass_"$TARGET" -d "$TARGET" > /dev/null
cat amass_"$TARGET" | cut -d " " -f 1 > amass_domains.txt
echo "Found $(wc -l subdomains.txt | cut -d " " -f 1) subdomains!"
echo "[+] Finding subdomains with findomain..."
~/tools/findomain/findomain-linux -t "$TARGET" -u fd_domains.txt 
echo "[+] Combining found subdomains and deduping..."
cat fd_domains.txt > domains.txt
cat amass_domains.txt > domains.txt
cat domains.txt | sort | uniq > u_domains.txt
rm domains.txt && mv u_domains.txt domains.txt
echo "done"

echo "[+] Finding live web hosts..."
cat domains.txt | httprobe | tee hosts.txt
echo "done"

echo "[+] Running aquatone against discovered subdomains"
cat hosts.txt | aquatone -chrome-path $chromiumPath -out ./aqua_out -threads 5 -silent
echo "Done"
echo

echo "[+] Recon complete"