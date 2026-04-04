#!/bin/bash

# Modificați scriptul să nu aștepte la nesfarsit ci maxim 1 minut. 
# Dar daca fisierul este create mai devreme de 1 minut scriptul trebuie sa se termine mai devreme.

# Verificăm dacă a fost furnizat un argument (calea fișierului)
if [ -z "$1" ]; then
    # -z verifică dacă șirul este gol
    echo "Utilizare: $0 <cale_fisier>"
    # $0 reprezintă numele scriptului
    exit 1
    # Ieșire cu cod 1 = eroare (argument lipsă)
fi

FILE="$1"
# Salvăm în variabila FILE calea fișierului primită ca argument

TIMEOUT=60
# Stabilim timpul maxim de așteptare (60 secunde)

INTERVAL=5
# Stabilim intervalul dintre verificări (5 secunde)

echo "Se așteaptă crearea fișierului: $FILE (maxim $TIMEOUT secunde)..."
# Afișăm mesaj informativ pentru utilizator

START=$(date +%s)
# Salvăm momentul de start în secunde (timestamp UNIX)

while true; do
    # Buclă care rulează până la îndeplinirea unei condiții de ieșire

    if [ -f "$FILE" ]; then
        # Verificăm dacă fișierul există și este fișier obișnuit (-f)

        echo "Fișierul a fost creat!"
        # Afișăm mesaj de succes

        exit 0
        # Ieșire cu cod 0 = execuție reușită
    fi

    NOW=$(date +%s)
    # Preluăm timpul curent în secunde

    ELAPSED=$((NOW - START))
    # Calculăm câte secunde au trecut de la pornirea scriptului

    if [ "$ELAPSED" -ge "$TIMEOUT" ]; then
        # Verificăm dacă timpul scurs este mai mare sau egal cu limita de 60 secunde

        echo "Timpul de așteptare a expirat. Fișierul nu a fost creat."
        # Afișăm mesaj de timeout

        exit 2
        # Ieșire cu cod 2 = timeout (fișierul nu a fost creat în intervalul permis)
    fi

    sleep "$INTERVAL"
    # Așteptăm 5 secunde înainte de următoarea verificare
done
