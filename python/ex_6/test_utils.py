#!/usr/bin/env python3

from utils import encode_base64, decode_base64


def main():
    text_original = "Salut, lume!"

    # Codificare Base64
    text_codificat = encode_base64(text_original)
    print("Text original:", text_original)
    print("Text codificat (Base64):", text_codificat)

    # Decodificare Base64
    text_decodificat = decode_base64(text_codificat)
    print("Text decodificat:", text_decodificat)


if __name__ == "__main__":
    main()