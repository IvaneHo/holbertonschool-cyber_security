#!/bin/bash

hash="$1"
encoded="${hash#\{xor\}}"
decoded=$(echo "$encoded" | base64 -d)

result=""
for ((i=0; i<${#decoded}; i++)); do
    char="${decoded:$i:1}"
    ascii=$(printf "%d" "'$char")
    xor_result=$((ascii ^ 95))
    result+=$(printf "\\$(printf '%o' $xor_result)")
done

echo -e "$result"
