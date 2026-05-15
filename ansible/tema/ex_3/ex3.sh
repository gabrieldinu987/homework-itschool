#!/bin/bash

# Creați un playbook Ansible care actualizează fișierul /etc/hosts  de pe remote cu o linie nouă (dacă nu există deja), apoi notifică un handler care face ping la hostname-ul adăugat.
# folositi modulul lineinfile
# ip-ul și hostname-ul trebuie sa fie declarate ca variabile în interiorul playbook-ului
# faceți ping (din remote) către noul host de 3 ori și salvați rezultatul într-o variabila
# printati rezultatul în consola debug Ansible

ansible-playbook -i inventory.ini playbook.yml