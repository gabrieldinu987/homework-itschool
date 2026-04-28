#!/usr/bin/env python3

"""
Faceti un script de python ce face backup la un fisier (doar dacă acesta a fost modificat).
Calea catre fișierul la care face backup este primita ca argument. 
Puneti scriptul de python in crontab sa ruleze automat la fiecare minut.
"""

import os
import sys
import shutil
from datetime import datetime


def backup_file(file_path):
    # Verifică dacă fișierul există
    if not os.path.isfile(file_path):
        print(f"Eroare: Fișierul '{file_path}' nu există.")
        sys.exit(1)

    # Creează directorul de backup
    backup_dir = os.path.join(os.path.dirname(file_path), "backup")
    os.makedirs(backup_dir, exist_ok=True)

    # Numele fișierului și calea către backup
    file_name = os.path.basename(file_path)
    backup_path = os.path.join(backup_dir, file_name)

    # Dacă există deja un backup, verifică data modificării
    if os.path.exists(backup_path):
        original_mtime = os.path.getmtime(file_path)
        backup_mtime = os.path.getmtime(backup_path)

        if original_mtime <= backup_mtime:
            print("Nu s-au detectat modificări. Backupul nu este necesar.")
            return

    # Creează un backup cu timestamp
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_file_name = f"{file_name}.{timestamp}.bak"
    timestamped_backup_path = os.path.join(backup_dir, backup_file_name)

    # Copiază fișierul
    shutil.copy2(file_path, timestamped_backup_path)

    # Actualizează copia curentă
    shutil.copy2(file_path, backup_path)

    print(f"Backup creat: {timestamped_backup_path}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Utilizare: python3 backup.py <cale_catre_fisier>")
        sys.exit(1)

    backup_file(sys.argv[1])