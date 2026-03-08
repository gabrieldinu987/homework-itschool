#!/bin/bash
#Faceti un script cu numele config.sh ce face load în variabilele de mediu la variabilele definite intr-un fisier config.txt ce arată în felul următor:
#DB_USER:admindb
#DB_PASS:12343dsadasdasFDTR!@13
#DB_HOSTNAME:my-db.com 
#DB_PORT:1234

CONFIG_FILE="./config.txt"

while IFS=':' read -r key value; do
    # elimină spații
    key=$(echo "$key" | xargs)
    value=$(echo "$value" | xargs)

    # setează doar dacă nu există deja (cerinta 3.)
    if [ -z "${!key}" ]; then
        export "$key=$value"
    fi
done < "$CONFIG_FILE"

#1.	Cum facem ca variabilele setate automat în script să fie disponibile și în sesiunea de shell curentă?
#source config.sh

#2.	Cum facem ca variabilele să fie disponibile de fiecare dată când deschidem un terminal nou al userului curent?
#Adăugăm scriptul în .bashrc
#source ./config.sh
