#!/bin/bash

# Creați un playbook Ansible care citește un fișier de secrete criptat cu Ansible Vault (secrets.yml)
# și seteaza fiecare secret ca variabila de mediu pe hostul remote.
# Variabilele de mediu trebuie sa fie disponibile în orice sesiune de terminal.
# Folosiți parola Vault dintr-un fișier secret .vault-pass.txt
# Conținutul necriptat al fișierului secrets.yml este următorul:
    #POSTGRES_USER:  testuser
    #POSTGRES_PASSWORD: testpass
    #POSTGRES_DB: db

# Optional: Folosind Docker, rulați o imagine de postgres configurată cu variabilele de mediu deja setate. 
#           Task-urile aferente trebuie adaugate în același playbook.

# Criptare fisier secrets.yml cu Ansible Vault
ansible-vault encrypt secrets.yml --vault-password-file ./vault-pass.txt
ansible-vault view secrets.yml

# Se ruleaza playbok-ul
ansible-playbook -i inventory.ini playbook.yml --vault-password-file ./vault-pass.txt
# ansible-playbook -i inventory.ini playbook.yml --ask-vault-pass

# Se verifica pe serverul remote
ssh -i ~/.ssh/ansible-key.pub ansible@192.168.2.194 -p 22
echo $POSTGRES_USER
echo $POSTGRES_PASSWORD
echo $POSTGRES_DB

# Se ruleaza o imagine de postgres configurată cu variabilele de mediu deja setate.
ansible-playbook -i inventory.ini playbook-docker.yml --vault-password-file ./vault-pass.txt