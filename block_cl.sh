#!/bin/bash

#download ip ranges

#AWS
echo "Add AWS ip range to black list"
echo -e "#AWS\n" > bl.txt
curl -s https://ip-ranges.amazonaws.com/ip-ranges.json | jq -r .prefixes[].ip_prefix | grep -v null | sort -u >> bl.txt

#Google
echo "Add Google ip range to black list"
echo -e "\n#Google\n" >> bl.txt
curl -s https://www.gstatic.com/ipranges/cloud.json | jq -r .prefixes[].ipv4Prefix | grep -v null | sort -u >> bl.txt

#Oracle
echo "Add Oracle ip range to black list"
echo -e "\n#Oracle\n" >> bl.txt
curl -s https://docs.oracle.com/en-us/iaas/tools/public_ip_ranges.json | jq -r .regions[].cidrs[].cidr | grep -v null | sort -u >> bl.txt

#Azure
echo -e "\n#Azure\n" >> bl.txt
echo "Add MS Azure ip range to black list"
curl -s https://download.microsoft.com/download/7/1/D/71D86715-5596-4529-9B13-DA13A5DE5B63/ServiceTags_Public_20220808.json | jq -r .values[].properties.addressPrefixes[] | grep -v : | grep -v null | sort -u >> bl.txt

echo "Add drop rules into iptables"

# Empty the chain BLCLOUD before adding rules

iptables -F BLCLOUD
[[ $? -ne 0 ]] && iptables -N BLCLOUD

# Read bl.txt and add IP into IPTables one by one
grep -v "#" bl.txt | sort | uniq | while read IP
do
    iptables -v -A BLCLOUD -s $IP -j DROP
done

iptables-save >> /etc/iptables/rules.v4


