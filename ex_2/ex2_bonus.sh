#!/bin/bash
# În loc de 2 fișiere comparati o lista de oricât de multe fișiere. Dacă oricare 2 fișiere din lista sunt diferite intoarce-ti un mesaj de eroare.  

# Verificăm dacă sunt cel puțin 2 argumente.
# "$#" reprezintă numărul de argumente primite.
if [ "$#" -lt 2 ]; then
    # Dacă sunt mai puțin de 2 fișiere, nu putem face comparația.
    echo "Utilizare: $0 fisier1 fisier2 [fisier3 ...]"
    # $0 reprezintă numele scriptului.
    exit 1
    # Ieșire cu cod de eroare.
fi

# Verificăm dacă toate fișierele există.
for f in "$@"; do
    # "$@" reprezintă lista tuturor argumentelor primite.
    if [ ! -f "$f" ]; then
        # -f verifică dacă argumentul este fișier obișnuit existent.
        echo "Eroare: fișierul '$f' nu există."
        exit 1
        # Dacă un fișier lipsește, ieșim imediat cu eroare.
    fi
done

# Calculăm hash-ul primului fișier.
# Acesta va fi hash-ul de referință.
ref_hash=$(sha256sum "$1" | awk '{print $1}')
# sha256sum generează: hash + nume fișier.
# awk '{print $1}' extrage doar hash-ul.

# Parcurgem restul fișierelor începând cu al doilea.
for f in "${@:2}"; do
    # "${@:2}" înseamnă toate argumentele de la poziția 2 încolo.
    current_hash=$(sha256sum "$f" | awk '{print $1}')
    # Calculăm hash-ul fișierului curent.

    if [ "$current_hash" != "$ref_hash" ]; then
        # Dacă hash-ul diferă de cel de referință,
        # înseamnă că cel puțin două fișiere sunt diferite.
        echo "Eroare: fișierele NU sunt identice."
        exit 1
        # Ieșim imediat cu cod de eroare.
    fi
done

# Dacă am ajuns aici, înseamnă că toate hash-urile sunt egale.
echo "Toate fișierele sunt identice."
exit 0
# Ieșire cu cod 0 (succes).
