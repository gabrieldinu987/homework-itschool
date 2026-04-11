#!/usr/bin/env python3

"""
Faceți un modul de utils in care adaugati 2 metode:
 - una care face sha256 hash la un string 
 - alta la un fisier.
Testați aceste metode de utils dintr-un alt script de python.
"""
# utils.py
import hashlib


def sha256_string(text: str) -> str:
    """
    Calculează hash-ul SHA-256 al unui string.
    
    :param text: Textul de criptat
    :return: Hash-ul SHA-256 în format hexazecimal
    """
    return hashlib.sha256(text.encode()).hexdigest()


def sha256_file(file_path: str) -> str:
    """
    Calculează hash-ul SHA-256 al unui fișier.
    
    :param file_path: Calea către fișier
    :return: Hash-ul SHA-256 în format hexazecimal
    """
    sha256 = hashlib.sha256()

    with open(file_path, "rb") as f:
        for block in iter(lambda: f.read(4096), b""):
            sha256.update(block)

    return sha256.hexdigest()
