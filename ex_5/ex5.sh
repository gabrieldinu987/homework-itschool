#!/bin/bash
# Creați un script ce face backup la un fișier primit ca parametru printr-o variabila de mediu cu numele  BACKUP_FILE_PATH, doar dacă fișierul a fost modificat. 
# Cerințe:

# A.	Toate backupurile sunt ținute într-un subdirector. Numele subdirectorului de backup este și el primit tot ca variabila de mediu (și are valoare implicită backup în caz că nu a fost setată).
# B.	Fiecare fișier de backup are un timestamp în nume.  
# C.	Dacă variabilă de mediu BACKUP_FILE_PATH nu a fost setată se afișează o eroare.
# D.	Dacă există deja un fișier de backup cu același conținut doar îl redenumim cu timestamp-ul curent  (nu mai facem încă un backup). 
# C. Verificăm dacă variabila BACKUP_FILE_PATH este setată


if [ -z "$BACKUP_FILE_PATH" ]; then
    echo "Eroare: variabila de mediu BACKUP_FILE_PATH nu este setată."
    exit 1
fi

# Verificăm dacă fișierul există
if [ ! -f "$BACKUP_FILE_PATH" ]; then
    echo "Eroare: fișierul $BACKUP_FILE_PATH nu există."
    exit 1
fi
push
# A. Directorul de backup (implicit 'backup')
BACKUP_DIR=${BACKUP_DIR:-backup}

mkdir -p "$BACKUP_DIR"

# Numele fișierului
FILE_NAME=$(basename "$BACKUP_FILE_PATH")

# B. Timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Hash-ul fișierului curent
CURRENT_HASH=$(sha256sum "$BACKUP_FILE_PATH" | awk '{print $1}')

# Verificăm dacă există deja un backup cu același conținut
for file in "$BACKUP_DIR"/"$FILE_NAME"_*; do
    [ -e "$file" ] || continue

    HASH=$(sha256sum "$file" | awk '{print $1}')

    if [ "$HASH" == "$CURRENT_HASH" ]; then
        # D. Dacă există același conținut, doar redenumim
        mv "$file" "$BACKUP_DIR/${FILE_NAME}_$TIMESTAMP"
        echo "Backup existent redenumit cu timestamp nou."
        exit 0
    fi
done

# Dacă nu există backup identic -> creăm unul nou
cp "$BACKUP_FILE_PATH" "$BACKUP_DIR/${FILE_NAME}_$TIMESTAMP"

echo "Backup creat: $BACKUP_DIR/${FILE_NAME}_$TIMESTAMP"

#Setam variabilele de mediu
#export BACKUP_FILE_PATH=/home/gabriel/LAB/homework-itschool/ex3.sh
#export BACKUP_DIR=/home/gabriel/LAB/homework-itschool/bck
