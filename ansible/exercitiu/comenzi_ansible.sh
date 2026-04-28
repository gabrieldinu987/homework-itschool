#!/bin/bash

# PREREQ
# schimba numele la servere dupa instalare
sudo nano /etc/hostname

# IP-uri alocate de DHCP
ip a
# app1: 192.168.2.195
# app2: 192.168.2.196
# db1 : 192.168.2.197

# instaleaza open-ssh pe serverele dorite
sudo apt install openssh-server -y
sudo systemctl enable ssh
# test
# ssh gabriel@192.168.2.195
# ssh gabriel@192.168.2.196
# ssh gabriel@192.168.2.197

# se copiaza cheaia publica pe servere
# scp -P 22 ~/.ssh/id_rsa.pub  gabriel@192.168.2.195:/home/gabriel/.ssh/
# scp -P 22 ~/.ssh/id_rsa.pub  gabriel@192.168.2.196:/home/gabriel/.ssh/
# scp -P 22 ~/.ssh/id_rsa.pub  gabriel@192.168.2.197:/home/gabriel/.ssh/

# ssh la servere
ssh -i ~/.ssh/id_rsa gabriel@192.168.2.195 -p 22
ssh -i ~/.ssh/id_rsa gabriel@192.168.2.196 -p 22
ssh -i ~/.ssh/id_rsa gabriel@192.168.2.197 -p 22


# instalare ansible
python3 -m pip install --user ansible
ansible --version


#ex_1
ansible database -i inventory.ini -m ping
ansible all -i inventory.ini -m ping 


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