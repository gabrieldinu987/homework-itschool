#!/bin/bash

# Impachetati intr-o imagine de docker un script de python ce muta fisiere dintr-un director “input” intr-un director “output”.
# După fiecare fișier mutat scriptul de python “doarme” 5 secunde.
# Porniti imagine de docker si mapati input si output folder la 2 directoare de pe host.

mkdir input output

# Se creeza imaginea 
docker build -f ./dockerfile -t move .

# Se creeaza containerul
docker run -d \
  --name move1 \
  -v $(pwd)/input:/input \
  -v $(pwd)/output:/output \
  mover