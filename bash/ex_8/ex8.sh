#!/bin/bash

# Faceti un script de shell cu numele group-copy.sh ce copiaza userii dintr-un grup in altul.
# Scriptul primește 2 parametrii obligatorii și diferiți: grupul sursa și grupul destinatie (in ordinea aceasta).

# Verificare numar parametri
if [ "$#" -ne 2 ]; then
    echo "Utilizare: $0 <grup_sursa> <grup_destinatie>"
    exit 1
fi

SRC_GROUP="$1"
DST_GROUP="$2"

# Verificare daca grupurile sunt diferite
if [ "$SRC_GROUP" = "$DST_GROUP" ]; then
    echo "Eroare: Grupul sursa si grupul destinatie trebuie sa fie diferite."
    exit 1
fi

# Verificare existenta grupuri
if ! getent group "$SRC_GROUP" > /dev/null; then
    echo "Eroare: Grupul sursa nu exista."
    exit 1
fi

if ! getent group "$DST_GROUP" > /dev/null; then
    echo "Eroare: Grupul destinatie nu exista."
    exit 1
fi

# Extrage utilizatorii din grupul sursa
USERS=$(getent group "$SRC_GROUP" | cut -d: -f4 | tr ',' ' ')

for user in $USERS; do
    usermod -aG "$DST_GROUP" "$user"
    echo "Utilizatorul $user a fost adaugat in grupul $DST_GROUP"
done

exit 0 

