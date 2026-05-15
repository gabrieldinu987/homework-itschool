#!/bin/bash

# Creati un inventar Ansible cu 2 hosturi, unul valid si altul invalid. 
# Pentru hostul valid configurați un user diferit de cel cu care rulați Ansible. 
# Setați un alias pentru fiecare host.
# Rulați o comanda de Ansible care sa faca ping pe ambele hosturi.


# IP alocat de DHCP
ip a
# srv1: 192.168.2.194

# instaleaza open-ssh pe serverele dorite
sudo apt install openssh-server -y
sudo systemctl enable ssh

# se creaza utilizatorul ansible pe fiecare server
sudo adduser ansible
sudo usermod -aG sudo ansible
cd /etc/sudoers.d/
echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee ansible-nopasswd
su - ansible
mkdir .ssh
cd .ssh

# pe server-ul master se creeaza o pereche de chei ssh pt utilizatorul ansible
ssh-keygen -t ed25519 -C "ansible_admin@gECORP.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/ansible-key

# se copiaza cheaia publica pe servere
ssh-copy-id -i ~/.ssh/ansible-key.pub ansible@192.168.2.194
ssh -i ~/.ssh/ansible-key.pub ansible@192.168.2.194 -p 22

# se incearca ping la serverele din inventar
ansible servers -i ./inventory.ini -m ping
