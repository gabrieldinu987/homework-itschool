#!/usr/bin/env python3

"""
Faceți un script de python ce muta unul cate unul fisierele dintr-un director în celalat.
După fiecare mutare de fișier scriptul doarme un numar random de secunde intre 1 si 5 (pentru a simula un long running process).
Directorul sursa este primul argument al scriptului iar destinatie al doilea.
Incercati sa porniti in acelasi timp 2 instante ale scriptului și verificati ca ambele funcționează corect.
"""

import os
import sys
import time
import random
import shutil
from pathlib import Path


def move_files(source_dir, destination_dir):
    src = Path(source_dir)
    dst = Path(destination_dir)

    # Verificarea existenței directoarelor
    if not src.exists() or not src.is_dir():
        print(f"Eroare: Directorul sursă '{src}' nu există.")
        sys.exit(1)

    if not dst.exists():
        print(f"Directorul destinație '{dst}' nu există. Se creează...")
        dst.mkdir(parents=True, exist_ok=True)

    print(f"Se mută fișiere din '{src}' în '{dst}'\n")

    while True:
        # Obține lista fișierelor din directorul sursă
        files = [f for f in src.iterdir() if f.is_file()]

        if not files:
            print("Nu mai există fișiere de mutat. Proces încheiat.")
            break

        for file_path in files:
            destination_file = dst / file_path.name

            try:
                # Mutarea atomică a fișierului
                shutil.move(str(file_path), str(destination_file))
                print(f"[{os.getpid()}] Mutat: {file_path.name}")

                # Pauză aleatoare între 1 și 5 secunde
                sleep_time = random.randint(1, 5)
                print(f"[{os.getpid()}] Pauză {sleep_time} secunde...")
                time.sleep(sleep_time)

            except FileNotFoundError:
                # Fișierul a fost mutat de o altă instanță
                print(f"[{os.getpid()}] Fișier deja mutat: {file_path.name}")
            except Exception as e:
                print(f"Eroare la mutarea fișierului {file_path.name}: {e}")


def main():
    if len(sys.argv) != 3:
        print("Utilizare: python move_files.py <director_sursa> <director_destinatie>")
        sys.exit(1)

    source_dir = sys.argv[1]
    destination_dir = sys.argv[2]

    move_files(source_dir, destination_dir)


if __name__ == "__main__":
    main()