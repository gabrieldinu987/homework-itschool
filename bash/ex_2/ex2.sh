#!/bin/bash
#Faceți un script ce compara dacă 2 fișiere (primite ca argument) sunt identice ca si continut.

# Verificăm dacă numărul de argumente primite este diferit de 2.
# "$#" reprezintă numărul total de argumente transmise scriptului.
if [ "$#" -ne 2 ]; then
    # Dacă nu sunt exact 2 argumente, afișăm modul corect de utilizare.
    echo "Utilizare: $0 fisier1 fisier2"
    # $0 reprezintă numele scriptului.
    # Ieșim din script cu codul 1 (eroare).
    exit 1
fi

# Salvăm primul argument (primul fișier) într-o variabilă.
f1="$1"
# $1 reprezintă primul argument transmis scriptului.

# Salvăm al doilea argument (al doilea fișier) într-o variabilă.
f2="$2"
# $2 reprezintă al doilea argument transmis scriptului.

# Verificăm dacă primul fișier există și este fișier obișnuit.
# -f testează existența și faptul că este fișier normal.
if [ ! -f "$f1" ]; then
    # Dacă fișierul nu există, afișăm mesaj de eroare.
    echo "Eroare: fișierul '$f1' nu există."
    # Ieșim cu cod de eroare.
    exit 1
fi

# Verificăm dacă al doilea fișier există și este fișier obișnuit.
if [ ! -f "$f2" ]; then
    # Dacă fișierul nu există, afișăm mesaj de eroare.
    echo "Eroare: fișierul '$f2' nu există."
    # Ieșim cu cod de eroare.
    exit 1
fi

# Calculăm hash-ul SHA256 pentru primul fișier.
# sha256sum returnează hash-ul și numele fișierului.
# awk '{print $1}' extrage doar hash-ul (prima coloană).
hash1=$(sha256sum "$f1" | awk '{print $1}')

# Calculăm hash-ul SHA256 pentru al doilea fișier.
hash2=$(sha256sum "$f2" | awk '{print $1}')

# Comparăm cele două hash-uri folosind operatorul de egalitate pentru șiruri.
if [ "$hash1" = "$hash2" ]; then
    # Dacă sunt egale, înseamnă că fișierele au același conținut.
    echo "Fișierele sunt identice (hash SHA256 egal)."
    # Ieșim cu cod 0 (succes).
    exit 0
else
    # Dacă hash-urile diferă, conținutul fișierelor este diferit.
    echo "Fișierele sunt diferite (hash SHA256 diferit)."
    # Ieșim cu cod 1 (eroare).
    exit 1
fi
