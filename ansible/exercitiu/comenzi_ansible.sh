#!/bin/bash

# PREREQ
# schimba numele la servere dupa instalare
sudo nano /etc/hostname

# IP-uri alocate de DHCP
ip a
# app1: 192.168.2.188
# app2: 192.168.2.192
# db1 : 192.168.2.194

# instaleaza open-ssh pe serverele dorite
sudo apt install openssh-server -y
sudo systemctl enable ssh

# se creaza utilizatorul ansible pe fiecare server
sudo adduser ansible
sudo usermod -aG sudo ansible
cd /etc/sudoers.d/
echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee ansible-nopasswd
# se creeaza o pereche de chei ssh pt utilizatorul ansible
su - ansible
mkdir .ssh
ssh-keygen -t ed25519 -C "gabrieldinu987@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/ansible-ssh-key

# se copiaza cheaia publica pe servere
ssh-copy-id -i ~/.ssh/ansible-ssh-key.pub ansible@192.168.2.188
ssh-copy-id -i ~/.ssh/ansible-ssh-key.pub ansible@192.168.2.192
ssh-copy-id -i ~/.ssh/ansible-ssh-key.pub -p 2200 ansible@192.168.2.194


# ssh la servere
ssh -i ~/.ssh/ansible-ssh-key.pub ansible@192.168.2.188 -p 22
ssh -i ~/.ssh/ansible-ssh-key.pub ansible@192.168.2.192 -p 22
ssh -i ~/.ssh/ansible-ssh-key.pub ansible@192.168.2.194 -p 2200


# instalare ansible
python3 -m pip install --user ansible
ansible --version


#ex_1
ansible database -i "./inventory.ini" -m ping
ansible all -i "./inventory.ini" -m ping 


#ex_2
ansible-playbook -i inventory.ini ping.yml


#ex_3
ansible-playbook -i inventory.ini create-empty-file.yml
ansible-doc file

#ex_4
ansible-playbook -i inventory.ini install-nginx.yml
ansible-playbook -i inventory.ini clean-install-nginx.yml

#ex_5
ansible-playbook -i inventory.ini create-user.yml

#ex_6
ansible-playbook -i inventory.ini -e pachet=tree install_pachet.yml

#ex_7
ansible-playbook -i inventory.ini -e prenume=Gabriel -e nume=Dinu salut.yaml

#ex_8
ansible-vault create secrets.yml
cat secrets.yml
ansible-vault edit secrets.yml
ansible-vault view secrets.yml

ansible-playbook -i inventory.ini db-connect.yaml --ask-vault-pass

echo "pass12345!" > .vault_pass.txt
chmod 600 .vault_pass.txt

ansible-playbook -i inventory.ini db-connect.yaml --vault-password-file ./vault_pass.txt

ansible-vault encrypt file.yaml
ansible-vault rekey file.yaml
ansible-vault decrypt file.yaml

#ex_9
ansible-vault create domains.yml
ansible-playbook -i inventory.ini --ask-vault-pass ping-domains.yml

#ex_10
ansible-playbook -i inventory.ini docker.yaml
