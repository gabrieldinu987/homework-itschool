#!/bin/bash

# Creați o nouă rețea de tipul bridge cu numele retea-interna.
# Porniti doua containere de tipul tools (vezi exercițiul 9) cu nume diferite.
# Logati-va pe fiecare container și încercați sa dati ping la celalat container folosind ip-ul și apoi DNS-ul.
# Deconectati DOAR primul container de la reteaua retea-interna. Incercati iar sa dati ping intre containere pe baza de IP si pe baza de DNS. 
# Conectati ambele containere la reteaua bridge default. Inspectati ambele retele (bridge-ul default si bridge-ul retea-interna) si verificati ce containere sunt atasate. 
# Inspectati si containerele si verificati la ce retele sunt conectate.

# Se creeaza reteaua "retea-interna"
docker network create --driver bridge retea-interna

# Se listeaza retelele disponibile
docker network ls

# Inspectam configuratia retelei
docker network inspect retea-interna

# Pornire container 1
docker run -dit \
  --name tools1-ctn \
  --network retea-interna \
  tools-img

# Pornire container 2
docker run -dit \
  --name tools2-ctn \
  --network retea-interna \
  tools-img

# Deconectare de la reteaua "retea-interna"
docker network disconnect retea-interna tools1-ctn

# Conectare containere la reteaua default "bridge"
docker network connect bridge tools1-ctn
docker network connect bridge tools2-ctn

# Inspect reteaua bridge
docker network inspect bridge
docker network inspect bridge

# Inspect containere
docker container inspect tools1-ctn
docker container inspect tools2-ctn 