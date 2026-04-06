#!/bin/bash

# Porniti un server nginx cu numele blue pe portul 8080 si altul cu numele green pe portul 8090.
# Pentru fiecare server serviți un fișier static index.html din local cu background blue respectiv green.
# Accesati-le in browser.

# Se creeaza serverul nginx blue si facem bind mount intre folderul de pe host $(pwd)/nginx/blue si folderul din container /usr/share/nginx/html
docker run -d \
  --name blue \
  -p 8080:80 \
  -v $(pwd)/nginx/blue:/usr/share/nginx/html \
  nginx

# Se creeaza serverul nginx green si facem bind mount intre folderul de pe host $(pwd)/nginx/blue si folderul din container /usr/share/nginx/html
  docker run -d \
  --name green \
  -p 8090:80 \
  -v $(pwd)/nginx/green:/usr/share/nginx/html \
  nginx