#!/usr/bin/env bash

########################################
#   COLORS
########################################
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
reset=`tput sgr0`

########################################
#   CONFIG
########################################
todate=$(date +"%Y-%m-%d")
foldername="recon-$todate_$(cat /proc/sys/kernel/random/uuid | cut -d '-' -f 1)"
path=$(pwd)
dirsearchWordlist=$path/wordlists/MEGA_DIR_DISCOVER.txt
massdnsWordlist=$path/wordlists/commonspeak2-top1000-subs.txt
subdomainThreads=10
dirsearchThreads=50

domain=

usage() { echo -e "Usage: ./$0 -d domain.com" 1>&2; exit 1; }
while getopts ":d:" o; do
    case "${o}" in
        d)
            domain=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND - 1))

if [ -z "${domain}" ]; then
   usage; exit 1;
fi

sanity_checks(){
    if [[ -z "${dirsearchWordlist}" ]] || [[ -z "${massdnsWordlist}" ]]; then 
        echo "${red}massdnsWordlist/dirsearchWordlist vars not set${reset}"
        exit 1
    fi

    if [[ ! -f "${dirsearchWordlist}" ]]; then 
        echo "${red}dirsearchWordlist file not found: $dirsearchWordlist${reset}"
        exit 1
    fi

    if [[ ! -f "${massdnsWordlist}" ]]; then 
        echo "${red}massdnsWordlist file not found: $massdnsWordlist${reset}"
        exit 1
    fi
}

logo(){
  # can't have a bash script without a cool logo :D
  echo "${red}
      ___                       ___         ___           ___           ___           ___           ___           ___     
     /\  \                     /\  \       /\__\         /\  \         /\__\         /\__\         /\  \         /\  \    
     \:\  \         ___       /::\  \     /:/ _/_       /::\  \       /:/ _/_       /:/  /        /::\  \        \:\  \   
      \:\  \       /|  |     /:/\:\__\   /:/ /\__\     /:/\:\__\     /:/ /\__\     /:/  /        /:/\:\  \        \:\  \  
  ___ /::\  \     |:|  |    /:/ /:/  /  /:/ /:/ _/_   /:/ /:/  /    /:/ /:/ _/_   /:/  /  ___   /:/  \:\  \   _____\:\  \ 
 /\  /:/\:\__\    |:|  |   /:/_/:/  /  /:/_/:/ /\__\ /:/_/:/__/___ /:/_/:/ /\__\ /:/__/  /\__\ /:/__/ \:\__\ /::::::::\__\\
 \:\/:/  \/__/  __|:|__|   \:\/:/  /   \:\/:/ /:/  / \:\/:::::/  / \:\/:/ /:/  / \:\  \ /:/  / \:\  \ /:/  / \:\~~\~~\/__/
  \::/__/      /::::\  \    \::/__/     \::/_/:/  /   \::/~~/~~~~   \::/_/:/  /   \:\  /:/  /   \:\  /:/  /   \:\  \      
   \:\  \      ~~~~\:\  \    \:\  \      \:\/:/  /     \:\~~\        \:\/:/  /     \:\/:/  /     \:\/:/  /     \:\  \    ${yellow} 
    \:\__\          \:\__\    \:\__\      \::/  /       \:\__\        \::/  /       \::/  /       \::/  /       \:\__\    
     \/__/           \/__/     \/__/       \/__/         \/__/         \/__/         \/__/         \/__/         \/__/    

${reset}                                                      "
}

print_header(){
    echo "==========================================="
    echo "domain: $domain"
    echo "scanID: $foldername"
    echo "massdnsWordlist: $massdnsWordlist"
    echo "dirsearchWordlist: $dirsearchWordlist"
    echo "==========================================="
}

init_scan(){
    if [ ! -d ./$domain ]; then
        echo "+ creating directory for target domain $domain"
        mkdir ./$domain
    fi
    echo "+ creating directories for scan $foldername"
    mkdir ./$domain/$foldername
    mkdir ./$domain/$foldername/dirsearch_results
    mkdir ./$domain/$foldername/wayback-data
}

subdomain_search(){
    echo -n "+ searching with Sublist3r..."
    python ~/tools/Sublist3r/sublist3r.py -d $domain -t 10 -v -o ./$domain/$foldername/$domain.txt > /dev/null
    echo "done!"

    echo -n "+ checking certspotter..."
    curl -s https://certspotter.com/api/v0/certs\?domain\=$domain | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $domain >> ./$domain/$foldername/$domain.txt
    echo "done!"

    echo -n "+ checking crt.sh ..."
    ~/tools/massdns/scripts/ct.py $domain 2>/dev/null > ./$domain/$foldername/crtsh_tmp.txt
    echo "done!"
}

dns_resolution(){
    echo -n "+ resolving subdomains found on crt.sh..."
    [ -s ./$domain/$foldername/crtsh_tmp.txt ] && cat ./$domain/$foldername/crtsh_tmp.txt | \
        ~/tools/massdns/bin/massdns -r ~/tools/massdns/lists/resolvers.txt -t A -q -o S -w  ./$domain/$foldername/crtsh.txt
    echo "done!"
    
    echo -n "+ resolving subdomains found with Sublist3r+certspotter..."
    cat ./$domain/$foldername/$domain.txt | \
        ~/tools/massdns/bin/massdns -r ~/tools/massdns/lists/resolvers.txt -t A -q -o S -w  ./$domain/$foldername/domaintemp.txt
    echo "done!"
}

mass(){
    echo "+ using wordlist: $massdnsWordlist "
    echo "  ${yellow}-> $(wc -l $massdnsWordlist | awk '{print $1}') entries"
    ~/tools/massdns/scripts/subbrute.py $massdnsWordlist $domain | \
        ~/tools/massdns/bin/massdns -r ~/tools/massdns/lists/resolvers.txt -t A -q -o S | \
        grep -v 142.54.173.92 > ./$domain/$foldername/mass.txt
    echo "+ done!"
}

nsrecords(){
    echo "+ combining resolved subdomain files..."
    cat ./$domain/$foldername/mass.txt >> ./$domain/$foldername/temp.txt
    cat ./$domain/$foldername/domaintemp.txt >> ./$domain/$foldername/temp.txt
    cat ./$domain/$foldername/crtsh.txt >> ./$domain/$foldername/temp.txt

    echo "+ removing duplicate entries..."
    cat ./$domain/$foldername/temp.txt | awk '{print $3}' | sort -u | while read line; do
        wildcard=$(cat ./$domain/$foldername/temp.txt | grep -m 1 $line)
        echo "$wildcard" >> ./$domain/$foldername/cleantemp.txt
    done

    echo "+ creating a file for CNAME records..."
    cat ./$domain/$foldername/cleantemp.txt | grep CNAME >> ./$domain/$foldername/cnames.txt
    echo "+ checking for NS takeover potential..."
    cat ./$domain/$foldername/cnames.txt | sort -u | while read line; do
        hostrec=$(echo "$line" | awk '{print $1}')
        if [[ $(host $hostrec | grep NXDOMAIN) != "" ]]; then
            echo "${yellow}   -> check the following domain for NS takeover:  $line ${reset}"
            echo "$line" >> ./$domain/$foldername/pos.txt
        else
            echo -ne "working...\r"
        fi
    done
    sleep 1

    echo "+ creating a file for all discovered subdomains"
    cat ./$domain/$foldername/$domain.txt > ./$domain/$foldername/alldomains.txt
    cat ./$domain/$foldername/cleantemp.txt | awk  '{print $1}' | while read line; do
        x="$line"
        echo "${x%?}" >> ./$domain/$foldername/alldomains.txt
    done
    sleep 1
}

cleantemp(){
    echo "+ cleaning up temporary files..."
    rm ./$domain/$foldername/temp.txt
  	rm ./$domain/$foldername/crtsh_tmp.txt
    rm ./$domain/$foldername/domaintemp.txt
    rm ./$domain/$foldername/cleantemp.txt
}

http_alive(){
    echo -n "+ probing for live hosts..."
    cat ./$domain/$foldername/alldomains.txt | httprobe -c 50 -t 3000 -p https:8443 -p http:8080 -p https:8080 -p http:8888 -p https:8888 >> ./$domain/$foldername/responsive.txt
    echo "done!"

    cat ./$domain/$foldername/responsive.txt | sed 's/\http\:\/\///g' | sed 's/\https\:\/\///g' | sort -u | while read line; do
        probeurl=$(cat ./$domain/$foldername/responsive.txt | sort -u | grep -m 1 $line)
        echo "$probeurl" >> ./$domain/$foldername/urllist.txt
    done
    echo "$(cat ./$domain/$foldername/urllist.txt | sort -u)" > ./$domain/$foldername/urllist.txt
    echo  "  -> ${yellow}total of $(wc -l ./$domain/$foldername/urllist.txt | awk '{print $1}') subdomains with live HTTP servers found${reset}"
}

waybackrecon () {
    echo "+ scraping wayback for data..."
    cat ./$domain/$foldername/urllist.txt | waybackurls > ./$domain/$foldername/wayback-data/waybackurls.txt

    # create paramlist using unfurl
    cat ./$domain/$foldername/wayback-data/waybackurls.txt  | sort -u | unfurl --unique keys > ./$domain/$foldername/wayback-data/paramlist.txt
    [ -s ./$domain/$foldername/wayback-data/paramlist.txt ] && echo "Wordlist saved to /$domain/$foldername/wayback-data/paramlist.txt"

    # filter js urls
    cat ./$domain/$foldername/wayback-data/waybackurls.txt  | sort -u | grep -P "\w+\.js(\?|$)" | sort -u > ./$domain/$foldername/wayback-data/jsurls.txt
    [ -s ./$domain/$foldername/wayback-data/jsurls.txt ] && echo "JS Urls saved to /$domain/$foldername/wayback-data/jsurls.txt"

    # filter php urls
    cat ./$domain/$foldername/wayback-data/waybackurls.txt  | sort -u | grep -P "\w+\.php(\?|$) | sort -u " > ./$domain/$foldername/wayback-data/phpurls.txt
    [ -s ./$domain/$foldername/wayback-data/phpurls.txt ] && echo "PHP Urls saved to /$domain/$foldername/wayback-data/phpurls.txt"

    # filter aspx urls
    cat ./$domain/$foldername/wayback-data/waybackurls.txt  | sort -u | grep -P "\w+\.aspx(\?|$) | sort -u " > ./$domain/$foldername/wayback-data/aspxurls.txt
    [ -s ./$domain/$foldername/wayback-data/aspxurls.txt ] && echo "ASP Urls saved to /$domain/$foldername/wayback-data/aspxurls.txt"

    # filter jsp urls
    cat ./$domain/$foldername/wayback-data/waybackurls.txt  | sort -u | grep -P "\w+\.jsp(\?|$) | sort -u " > ./$domain/$foldername/wayback-data/jspurls.txt
    [ -s ./$domain/$foldername/wayback-data/jspurls.txt ] && echo "JSP Urls saved to /$domain/$foldername/wayback-data/jspurls.txt"
}

move_dirsearch_reports(){
	cat ./$domain/$foldername/urllist.txt | sed 's/\http\:\/\///g' |  sed 's/\https\:\/\///g' | sort -u | while read line; do
        [ -d ~/tools/dirsearch/reports/$line/ ] && ls ~/tools/dirsearch/reports/$line/ | grep -v old | while read i; do
            mv ~/tools/dirsearch/reports/$line/$i ./$domain/$foldername/dirsearch_results/
        done
    done
  }

dirsearcher(){
    echo "+ starting dirsearch threads..."
    cat ./$domain/urllist.txt | xargs -P$subdomainThreads -I % sh -c \
        "python3 ~/tools/dirsearch/dirsearch.py -e php,asp,aspx,jsp,html,zip,jar -w $dirsearchWordlist -t $dirsearchThreads -u %"
}

main(){
    clear
    logo
    sanity_checks
    print_header

    echo "${red}>>> Initializing scan${reset}"
    init_scan

    echo "${red}>>> Gathering subdomains${reset}"
    subdomain_search $domain

    echo "${red}>>> Resolving discovered subdomains${reset}"
    dns_resolution $domain

    echo "${red}>>> Bruteforcing subdomains${reset}"
    mass $domain

    echo "${red}>>> Checking DNS records${reset}"
    nsrecords $domain
    cleantemp

    echo "${red}>>> Probing for live HTTP servers${reset}"
    http_alive $domain

    echo "${red}>>> Gathering wayback data${reset}"
    waybackrecon $domain

    echo
    echo "${green} Scan for $domain finished successfully${reset}"
    stty sane
    tput sgr0
}

main_test(){
    clear
    logo
    sanity_checks
    print_header
    echo "${red}>>> Initializing scan${reset}"
    echo "+ some output..."

    echo "${red}>>> Gathering subdomains${reset}"
    echo "+ some output..."

    echo "${red}>>> Resolving discovered subdomains${reset}"
    echo "+ some output..."

    echo "${red}>>> Bruteforcing subdomains${reset}"
    echo "+ some output..."

    echo "${red}>>> Checking DNS records${reset}"
    echo "+ some output..."

    echo "${red}>>> Probing for live HTTP servers${reset}"
    echo "+ some output..."

    echo
    echo "${green}Scan for $domain finished successfully${reset}"
    stty sane
    tput sgr0
    exit 0
}

main $domain
