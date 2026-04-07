#!/bin/bash

# Faceți un script Python (app.py) care scrie loguri atât în consolă, cât și într-un fișier la calea /log/app.log. 
# Scriptul trebuie să printeze, la fiecare secundă, un mesaj însoțit de un timestamp.
# Împachetați scriptul într-un Docker image și porniți-l. 
# Directorul în care se scriu logurile trebuie montat ca volum Docker (deci va trebui să creați mai întâi un volum cu numele loguri folosind docker volume create și să îl folosiți la rularea containerului).
# Porniți un al doilea container Docker cu Nginx, care folosește același volum și expune fișierul de loguri, astfel încât acesta să poată fi accesat din browser (montați volumul la calea /usr/share/nginx/html).
# Verificați în browser că puteți accesa fișierul de loguri și că acesta este actualizat cu mesaje noi la fiecare secundă.

# Se creeaza imaginea scriptului python
docker build -t gabrieldinu987/logger-img:1.0 .

# Se creeaza un volum
docker volume create loguri-vol1

# Rulam containerul de python
docker run -d \
  --name logger1-python \
  -v loguri-vol1:/log \
  gabrieldinu987/logger-img:1.0

# Rulam containerul de nginx
docker run -d \
  --name nginx-server \
  -p 8080:80 \
  -v loguri-vol1:/usr/share/nginx/html \
  nginx