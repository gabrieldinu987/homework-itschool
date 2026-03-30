#!/bin/bash

# Faceti un script cu numele which.sh ce:
# - Parseaza variabila PATH și pune într-un array toate căile.
# - Itereaza cu un for pe acest array de cai și pentru fiecare cale:
#       1.cauta dacă acea cale contine un fisier executabil cu numele primit ca argument la script (de exemplu ./which.sh ls)
#       2.insrează toate căile ce conțin acel executabil.
# Dacă nu a găsit nicio cale ce contine acel executabil afișați în mesaj de eroare și terminati scriptul cu un cod de eroare.


# Verificăm dacă s-a dat argument
if [ $# -eq 0 ]; then
    echo "Utilizare: $0 nume_executabil"
    exit 1
fi

executabil="$1"

# Parsăm PATH într-un array (separatorul este :)
IFS=':' read -ra cai <<< "$PATH"

gasit=0

# Iterăm prin fiecare cale
for cale in "${cai[@]}"; do
    # Verificăm dacă există fișier executabil cu acel nume
    if [ -x "$cale/$executabil" ] && [ -f "$cale/$executabil" ]; then
        echo "$cale/$executabil"
        gasit=1
    fi
done

# Dacă nu s-a găsit nimic
if [ $gasit -eq 0 ]; then
    echo "Eroare: executabilul '$executabil' nu a fost găsit în PATH" >&2
    exit 2
fi