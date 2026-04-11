#!/usr/bin/env python3

"""
Faceți un script de python ce verifica dacă nivelul de ocupare al discului este mai mare de un prag (configurable printr-o variabila de mediu - implicit 90%).
În cazul în care ocuparea discului este mai mare de acest prag printeaza un mesaj de alertă în consola.
Puneti acest script sa ruleze in ~/.bashrc
"""

import os
import shutil
import sys


def get_threshold():
    """
    Obține pragul din variabila de mediu DISK_USAGE_THRESHOLD.
    Valoarea implicită este 90%.
    """
    try:
        return int(os.getenv("DISK_USAGE_THRESHOLD", "90"))
    except ValueError:
        print("Valoare invalidă pentru DISK_USAGE_THRESHOLD. Se utilizează pragul implicit de 90%.")
        return 90


def check_disk_usage(path="/"):
    """
    Verifică nivelul de ocupare al discului pentru calea specificată.
    """
    threshold = get_threshold()
    total, used, free = shutil.disk_usage(path)

    usage_percent = used / total * 100

    if usage_percent > threshold:
        print(
            f"ALERTĂ: Utilizarea discului este {usage_percent:.2f}% "
            f"(prag: {threshold}%)."
        )
    else:
        print(
            f"OK: Utilizarea discului este {usage_percent:.2f}% "
            f"(prag: {threshold}%)."
        )


if __name__ == "__main__":
    # Permite specificarea unui path ca argument
    path_to_check = sys.argv[1] if len(sys.argv) > 1 else "/"
    check_disk_usage(path_to_check)