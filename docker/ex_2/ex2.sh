#!/bin/bash

# Rulati un container de busybox folosind comanda sleep in detached mode. Puneți un nume containerului. Ce observati?
# Accesați containerul în linie de comanda și listați procesele.
# Omorati și sterge-ti containerul.

# Ruleaza containerul busybox in detached mod
docker run -d --name my_busybox busybox sleep 300

# Afisarea containerului ce ruleaza
docker ps

# Conectare in container
docker exec -it my_busybox sh
# Vizulizare procese in container
ps -a

# Opreste containerul
docker stop my_busybox

# Sterge containerul
docker rm my_busybox

# Sterge imaginea de container
docker rmi busybox