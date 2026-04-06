#!bin/bash

# Alegeți orice alta imagine de pe docker hub ce nu a fost folosită la curs.
# Încercați sa înțelegeți ce face imaginea și cum se rulează local. Rulati imaginea local. 

docker run -d \
  --name web-server \
  -p 8080:80 \
  nginx

docker stop web-server