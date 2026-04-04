#!/bin/bash

# Faceți un script ce face log rotation la un fisier de loguri primit ca argument. Pentru simplitate log rotation-ul se face automat la un numar de secunde primit ca argument. Cand se face log rotation se copiază fișierul curent într-un nou fișier cu același nume ca fișierul original + un timestamp iar fișierul original se golește. Fisierele de log rotation se și arhivează pentru a ocupa mai puțin spațiu.

# Verificăm dacă sunt exact 2 argumente
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <log_file> <interval_seconds>"
    exit 1
fi

LOG_FILE="$1"
INTERVAL="$2"

# Verificăm dacă fișierul există
if [ ! -f "$LOG_FILE" ]; then
    echo "File does not exist!"
    exit 1
fi

while true
do
    sleep "$INTERVAL"

    # Generăm timestamp (YYYYMMDD_HHMMSS)
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

    # Numele fișierului nou
    ROTATED_FILE="${LOG_FILE}_${TIMESTAMP}"

    # Copiem fișierul
    cp "$LOG_FILE" "$ROTATED_FILE"

    # Arhivăm fișierul (gzip)
    gzip "$ROTATED_FILE"

    # Golim fișierul original
    > "$LOG_FILE"

    echo "Rotated log: ${ROTATED_FILE}.gz"
done