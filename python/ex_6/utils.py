#!/usr/bin/env python3
"""
Faceți un modul de utils (sau adaugati in modulul creat la exercițiile precedente) in care adaugati 2 metode:
- una care face encode base64 la un text si alta care face decode base64 la text.
Testați aceste metode de utils dintr-un alt script de python.
"""
import base64

def encode_base64(text: str) -> str:
    """
    Codifică un text în format Base64.

    :param text: Textul de codificat
    :return: Textul codificat în Base64
    """
    if not isinstance(text, str):
        raise TypeError("Inputul trebuie să fie de tip string.")

    encoded_bytes = base64.b64encode(text.encode("utf-8"))
    return encoded_bytes.decode("utf-8")


def decode_base64(encoded_text: str) -> str:
    """
    Decodifică un text din format Base64.

    :param encoded_text: Textul codificat în Base64
    :return: Textul decodificat
    """
    if not isinstance(encoded_text, str):
        raise TypeError("Inputul trebuie să fie de tip string.")

    try:
        decoded_bytes = base64.b64decode(encoded_text.encode("utf-8"))
        return decoded_bytes.decode("utf-8")
    except Exception as e:
        raise ValueError("Textul furnizat nu este un Base64 valid.") from e