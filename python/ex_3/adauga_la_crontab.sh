#!/bin/bash

# Calea către scriptul Python și fișierul monitorizat
PYTHON_SCRIPT="/home/gabriel/LAB/homework-itschool/python/ex_3/backup.py"
TARGET_FILE="/home/gabriel/LAB/homework-itschool/python/ex_3/fisier_de_modificat.txt"
PYTHON_BIN="/usr/bin/env python3"

# Linia care va fi adăugată în crontab
CRON_JOB="* * * * * $PYTHON_BIN $PYTHON_SCRIPT $TARGET_FILE >> /tmp/backup.log 2>&1"

# Verifică dacă jobul există deja
(crontab -l 2>/dev/null | grep -F "$PYTHON_SCRIPT") >/dev/null

if [ $? -eq 0 ]; then
    echo "Intrarea există deja în crontab. Nu se adaugă nimic."
else
    # Adaugă jobul în crontab
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    echo "Intrarea a fost adăugată în crontab:"
    echo "$CRON_JOB"
fi