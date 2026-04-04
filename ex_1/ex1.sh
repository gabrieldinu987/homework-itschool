#!/bin/bash
# Rulați imaginea de docker cu numele hello-world si verificati logurile.
# Verificati apoi dacă mai rulează containerul.
# Stergeti imagine hello-world din local.

# docker descarca imaginea si creeaza un container hello-world
docker run hello-world

# lista containerelor ce ruleaza
docker ps

# lista completa de containere oprite si pornite
docker ps -a

# verificare loguri container
docker logs b4893e099952

# stergere container
docker rm b4893e099952

# stregere imagine
docker rmi hello-world