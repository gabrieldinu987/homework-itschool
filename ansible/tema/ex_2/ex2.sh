#!/bin/bash

# Creați un playbook Ansible care instalează și utilizează pachetul locate pentru a localiza calea pentru o lista de fișiere. 
# lista de fișiere este definită într-un fișier yml numit locate-files.yml
# hint: instrucțiuni instalare locate
# calea către fișiere trebuie afișată în consola debug Ansible

ansible-playbook -i inventory.ini playbook.yml