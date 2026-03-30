#!/bin/bash

#Faceți un script simplu ce printeaza la nesfarsit in loguri pentru a testa scriptul de log rotation

# Verificăm dacă avem argument (fișier log)
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE="$1"

COUNT=1

while true
do
    echo "Log entry $COUNT at $(date)" >> "$LOG_FILE"
    COUNT=$((COUNT + 1))
    sleep 1
done