#!/bin/bash

# Check argument
if [ -z "$1" ]; then
    echo "Usage: ./0-whois.sh <domain>"
    exit 1
fi

# Run whois and pipe to awk
whois "$1" | awk -F: '
    BEGIN {
        # Set Output Field Separator to comma
        OFS=","
    }

    # Filter lines starting with Registrant, Admin, or Tech
    $1 ~ /^(Registrant|Admin|Tech) (Name|Organization|Street|City|State\/Province|Postal Code|Country|Phone|Fax|Email)/ {

        key = $1
        val = $2

        # Trim whitespace from start and end of value
        gsub(/^ */, "", val)
        gsub(/ *$/, "", val)

        # Prevent duplicates (checks if key was already seen)
        if (seen[key]++) next

        # Rule 1: Add space after Street fields
        if (key ~ /Street/) {
            val = val " "
        }

        # Rule 2: Add colon to Ext keys
        if (key ~ /Ext/) {
            key = key ":"
        }

        print key, val
    }
' > "${1}.csv"