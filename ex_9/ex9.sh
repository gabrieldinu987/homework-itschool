#Faceți un script ce dă restart la serviciul de sshd dacă este oprit. Puneți scriptul in crontab sa ruleze la fiecare minut. 

#!/bin/bash

SERVICE="sshd"

if ! systemctl is-active --quiet $SERVICE
then
    systemctl restart $SERVICE
fi

#sudo crontab -e
#* * * * * /home/gabriel/LAB/homework-itschool/ex_9/ex9.sh
