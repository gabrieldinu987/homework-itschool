#!/bin/bash
# Scrieți un script care verifica dacă un site este available (status code între 200 si 399). Scriptul verifică de un număr maxim de ori primit tot ca argument.	

# Verifică dacă numărul de argumente este diferit de 2
if [ $# -ne 2 ]; then
    # Afișează modul corect de utilizare
    echo "Usage: $0 <url> <max_attempts>"
    # Termină scriptul cu cod de eroare 1
    exit 1
fi

# Salvează primul argument (URL-ul) într-o variabilă
URL="$1"

# Salvează al doilea argument (numărul maxim de încercări)
MAX_ATTEMPTS="$2"

# Verifică dacă MAX_ATTEMPTS este un număr întreg pozitiv folosind expresie regulată
if ! [[ "$MAX_ATTEMPTS" =~ ^[0-9]+$ ]]; then
    # Afișează mesaj de eroare dacă nu este număr valid
    echo "max_attempts trebuie sa fie un numar intreg pozitiv."
    # Ieșire cu cod de eroare
    exit 1
fi

# Inițializează contorul de încercări cu 1
ATTEMPT=1

# Bucla se execută cât timp ATTEMPT este mai mic sau egal cu MAX_ATTEMPTS
while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do

    # Execută comanda curl:
    # -o /dev/null  -> ignoră conținutul răspunsului
    # -s            -> rulează în mod silențios (fără progres bar)
    # -w "%{http_code}" -> afișează doar codul HTTP
    # Rezultatul este salvat în variabila STATUS_CODE
    STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" "$URL")

    # Afișează numărul încercării și codul primit
    echo "Incercarea $ATTEMPT: Status code = $STATUS_CODE"

    # Verifică dacă status code este între 200 și 399 (site disponibil)
    if [ "$STATUS_CODE" -ge 200 ] && [ "$STATUS_CODE" -le 399 ]; then
        # Afișează mesaj de succes
        echo "Site-ul este disponibil."
        # Ieșire cu cod 0 (succes)
        exit 0
    fi

    # Crește contorul cu 1
    ATTEMPT=$((ATTEMPT + 1))

    # Așteaptă 1 secundă înainte de următoarea încercare
    sleep 1
done

# Dacă s-a ieșit din buclă înseamnă că toate încercările au eșuat
echo "Site-ul NU este disponibil dupa $MAX_ATTEMPTS incercari."

# Ieșire cu cod 2 (indică eșec după încercări)
exit 2
