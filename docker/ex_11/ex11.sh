#!/bin/bash

# Creați 2 rețele docker de tip bridge cu numele public si private.  Rețeaua private trebuie sa nu aiba access la internet (vezi optiunea –internal).
# Porniti 3 containere de docker plecand de la imaginea tools (vezi exercițiul 9). Numele containerelor sunt: frontend, backend si database. 
# Conectati containerele la aceste rețele astfel incat:
#       - frontend-ul poate sa acceseze backend-ul, dar nu si baza de date.
#       - backend-ul poate sa acceseze atat frontend-ul cat si baza de date
#       - baza de date poate fi accesată doar de către backend și nu are access la internet.
# Verificati aceste conexiuni facand ping din fiecare container.

# Reteua publica
docker network create --driver bridge public

# Reteaua privata
docker network create --driver bridge --internal private

# Run frontend
docker run -dit \
  --name frontend \
  --network public \
  -p 8081:80 \
  tools-img

# Run backend
  docker run -dit \
  --name backend \
  --network public \
  --network private \
  -p 8082:80 \
  tools-img

# Run database
  docker run -dit \
  --name database \
  --network private \
  -p 8083:80 \
  tools-img