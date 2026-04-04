#!/bin/bash

# Faceți un script ce face backup la fiecare 5 secunde la un director (doar la fisierele ce s-au modificat din acel director).
# Scriptul primește ca argument numele directorului la care trebuie făcut backup.
# Frecvența la care se face backup este citită dintr-o variabila de mediu cu numele FRECVENTA_BACKUP (cu valoare implicită de 5 secunde). 

# Verificam daca s-a dat argument
if [ -z "$1" ]; then
    echo "Utilizare: $0 <director>"
    exit 1
fi

DIRECTOR_Sursa="$1"
DIRECTOR_BACKUP="$(pwd)/$(basename "$DIRECTOR_Sursa")_backup"

# Frecventa din variabila de mediu sau valoare implicita
FRECVENTA=${FRECVENTA_BACKUP:-5}

# Verificam daca directorul exista
if [ ! -d "$DIRECTOR_Sursa" ]; then
    echo "Directorul nu exista!"
    exit 1
fi

# Cream directorul de backup daca nu exista
mkdir -p "$DIRECTOR_BACKUP"

echo "Backup pornit pentru $DIRECTOR_Sursa la fiecare $FRECVENTA secunde..."

while true
do
    rsync -av --update "$DIRECTOR_Sursa/" "$DIRECTOR_BACKUP/"
    sleep "$FRECVENTA"
done
