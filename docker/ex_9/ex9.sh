#!/bin/bash
# Creați o imagine de docker cu numele tools plecand de la imaginea de baza ubuntu si instalati pe ea (în Dockerfile următoarele):
# - vim
# - ping (iputils-ping)
# Puneti in CMD un sleep Infinity ca imaginea sa nu “moara” imediat ce a fost pornita. 
# Faceti build la imagine si porniti un container de test (dati ping catre google.com) 

# Se creeaza imaginea
docker build -t tools-img .

# Se ruleaza containerul
docker run -d --name tools1 tools-img

# Comenzi din container
docker exec -it tools1 bash