#!/bin/bash
#Faceți un script ce așteaptă (la nesfarsit) după un fisier pe disk sa fie creat (ce fișier doriti). După ce fișierul a fost create scriptul afișează un mesaj și iese cu succes.

# Fișierul pe care îl așteptăm
FILE="./fisier_nou.txt"
# Definim o variabilă numită FILE care conține calea completă a fișierului monitorizat

echo "Se așteaptă crearea fișierului: $FILE ..."
# Afișează un mesaj informativ în terminal; $FILE este înlocuit cu valoarea variabilei

# Buclă infinită
while true; do
    # deci bucla va rula la nesfârșit până la întâlnirea unui 'exit'

    if [ -f "$FILE" ]; then
        # Verifică dacă există un fișier obișnuit (-f) la calea specificată

        echo "Fișierul a fost creat!"
        # Afișează mesajul de succes dacă fișierul există

        exit 0
        # Oprește execuția scriptului cu cod 0 (succes)
    fi

    sleep 5
    # Așteaptă 5 secunde înainte de următoarea verificare
done


