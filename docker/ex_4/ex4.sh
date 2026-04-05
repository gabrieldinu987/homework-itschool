#!/bin/bash

# Construiți o imagine de docker simpla care printeaza mesajul “Salut din container” (folosind comanda echo).
# Folositi imaginea de baza alpine. De ce credeți ca am folosit aceasta imagine?
# Rulati imagine si incercati sa-i dati cat mai putin cpu si memory.
#   Raspuns => docker: Error response from daemon: Minimum memory limit allowed is 6MB
# Care sunt valorile cele mai mici pentru CPU si memory pe care ați reușit sa i le dați containerului?
# Dați push la imagine în contul vostru de DockerHub

# Se creaza imaginea folosind dockerfile-ul existent
docker build -f ./dockerfile -t gabrieldinu987/salut-img:1.0 .

# Se creaza containerul cu memorie si cpu specificat
docker run -d \
  --name salutare2 \
  --memory="6m" \
  --cpus="0.1" \
  -p 8080:80 \
  gabrieldinu987/salut-img:1.0

# Se verifica log-ul din containerul salutare
docker logs salutare2

# Logare in DockerHub
 docker login

 # Formatare pt DockerHub
 docker tag salut-img:1.0 gabrieldinu987/salut-img:1.0

 # Publicare pe DockerHub
docker push gabrieldinu987/salut-img:1.0