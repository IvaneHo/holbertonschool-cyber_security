#!/bin/bash
whois $1 | awk -F': ' '/Registrant|Admin|Tech/ {key=$1; val=$2; if($1 ~ /Street/){val=val" "}; if($1 ~ /Ext$/){sub(/Ext$/,"Ext:",key); if(val=="")val=""}; printf("%s,%s\n",key,val)}' > "$1.csv"
