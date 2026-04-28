#!/bin/bash

ssh-copy-id -i ~/.ssh/id_rsa.pub ansible@server_ip

ansible -i ./hosts.ini servers -m ping
