#!/usr/bin/env python3
# test_utils.py

from utils import sha256_string, sha256_file


def main():
    # Test pentru string
    text = "Salut, lume!"
    string_hash = sha256_string(text)
    print("Hash SHA-256 pentru string:")
    print(f"Text: {text}")cd ..
    print(f"Hash: {string_hash}\n")

    # Test pentru fișier
    file_path = "exemplu.txt"
    try:
        file_hash = sha256_file(file_path)
        print("Hash SHA-256 pentru fișier:")
        print(f"Fișier: {file_path}")
        print(f"Hash: {file_hash}")
    except FileNotFoundError:
        print(f"Eroare: Fișierul '{file_path}' nu a fost găsit.")


if __name__ == "__main__":
    main()