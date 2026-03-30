#!/bin/bash

# Faceți un script de shell numit group-list.sh ce imi afiseaza toți userii ce se afla într-un grup separati prin spațiu.
# Scriptul primește ca argument obligatoriu numele grupului.
# Dacă nu este niciun user în grup nu afișează nimic.

# verificam daca exista argument
if [ $# -ne 1 ]; then
    exit 1
fi

group="$1"

# luam linia grupului din /etc/group
line=$(grep "^$group:" /etc/group)

# daca grupul nu exista sau nu are utilizatori
users=$(echo "$line" | cut -d: -f4)

if [ -n "$users" ]; then
    echo "$users" | tr ',' ' '
fi
