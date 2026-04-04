#!/bin/bash

# Adauga automat hasbang in fisierele de sh in care nu este prezent. 
# Scriptul verifica toate scripturile sh dintr-un director primit ca parametru.

# Verificare argument
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

DIR="$1"

# Verificare dacă directorul există
if [ ! -d "$DIR" ]; then
  echo "Directory not found!"
  exit 1
fi

# Parcurgere fisiere .sh
find "$DIR" -type f -name "*.sh" | while read -r file; do
  # Citim prima linie
  first_line=$(head -n 1 "$file")

  # Verificam daca incepe cu #!
  if [[ "$first_line" != "#!"* ]]; then
    echo "Adding shebang to: $file"
    
    # Adaugam shebang la inceput
    tmp_file=$(mktemp)
    echo "#!/bin/bash" > "$tmp_file"
    cat "$file" >> "$tmp_file"
    mv "$tmp_file" "$file"
  else
    echo "Already has shebang: $file"
  fi
done