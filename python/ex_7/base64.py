#!/usr/bin/env python3
"""
Faceti un script de python care primeste ca argument un string base64 si un nume de fisier.
Scriptul o sa creeze pe disk un fișier cu numele primit ca argument și o sa ii puna ca și conținut stringul decodat din base64.
Testati scriptul.
"""

import base64
import sys


def decode_base64_to_file(base64_string: str, filename: str) -> None:
    """
    Decodează un string Base64 și îl scrie într-un fișier.

    :param base64_string: String-ul codificat Base64
    :param filename: Numele fișierului de ieșire
    """
    try:
        # Decodare Base64
        decoded_data = base64.b64decode(base64_string)

        # Scriere în fișier în mod binar
        with open(filename, "wb") as file:
            file.write(decoded_data)

        print(f"Fișierul '{filename}' a fost creat cu succes.")

    except base64.binascii.Error as e:
        print("Eroare: Stringul furnizat nu este un Base64 valid.")
        print(f"Detalii: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"A apărut o eroare: {e}")
        sys.exit(1)


def main():
    # Verificare număr argumente
    if len(sys.argv) != 3:
        print("Utilizare: python base64_to_file.py <string_base64> <nume_fisier>")
        sys.exit(1)

    base64_string = sys.argv[1]
    filename = sys.argv[2]

    decode_base64_to_file(base64_string, filename)


if __name__ == "__main__":
    main()
