#!/bin/bash
whois "$1" | awk -F': ' '
/^(Registrant|Admin|Tech) /{
    # Nettoyage
    gsub(/^ +| +$/, "", $2);

    # Street → espace obligatoire
    if($1 ~ /Street$/){ sub(/ *$/, " ", $2) }

    # Ext → normalisation
    if($1 ~ / Ext$/){ sub(/ Ext$/, " Ext:", $1) }

    # Double ":" → normalisation
    gsub(/:+$/, ":", $1)

    data[$1] = $2
}
END {
    sect[1]="Registrant"; sect[2]="Admin"; sect[3]="Tech";
    fields[1]="Name"; fields[2]="Organization"; fields[3]="Street";
    fields[4]="City"; fields[5]="State/Province"; fields[6]="Postal Code";
    fields[7]="Country"; fields[8]="Phone"; fields[9]="Phone Ext:";
    fields[10]="Fax"; fields[11]="Fax Ext:"; fields[12]="Email";

    total = 36; count = 0;

    for(s=1;s<=3;s++){
        for(i=1;i<=12;i++){
            key = sect[s]" "fields[i];
            out = key","( key in data ? data[key] : "" );
            count++;
            if(count == total)
                printf "%s", out;
            else
                print out;
        }
    }
}' > "$1.csv"
