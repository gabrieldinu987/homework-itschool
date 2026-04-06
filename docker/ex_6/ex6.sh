#!/bin/bash

# Construiți două imagini Docker separate, ambele pornind de la imaginea de bază ubuntu.
# Prima imagine va folosi instrucțiunea ENTRYPOINT cu comanda echo.
# A doua imagine va folosi instrucțiunea CMD cu comanda echo.
# În ambele cazuri, atât ENTRYPOINT, cât și CMD trebuie să conțină doar comanda echo.
# Rulați fiecare imagine separat și testați următoarele situații:
# Furnizați argumentul Salut și verificați rezultatul afișat în terminal.
# Furnizați comanda ls ca argument și observați comportamentul containerului.

# ENTRYPOINT
docker build -f ./dockerfile-entrypoint -t gabrieldinu987/entrypoint-img:1.0 .

docker run -d \
  --name entrypoint1-container \
  gabrieldinu987/entrypoint-img:1.0 \
  Salut

docker run -d \
  --name entrypoint2-container \
  gabrieldinu987/entrypoint-img:1.0 \
  ls

#CMD
docker build -f ./dockerfile-cmd -t gabrieldinu987/cmd-img:1.0 .

docker run -d \
  --name cmd1-container \
  gabrieldinu987/cmd-img:1.0 \
  salut
  
docker run -d \
  --name cmd2-container \
  gabrieldinu987/cmd-img:1.0 \
  ls