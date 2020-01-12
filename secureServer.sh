#!/bin/bash

sed -e '/Port 22/Port 2222/' \
    -e '/#PermitRootLogin no/PermitRootLogin no/' \
    -e '/#PasswordAuthentication yes/PasswordAuthentication no/' \
    /etc/ssh/sshd_config >/etc/ssh/sshd_config.new

# $(date +%y%b%d-%H%M%S) == "18Aug13-125913"
mv /etc/ssh/sshd_config /etc/ssh/sshd_config.$(date +%y%b%d-%H%M%S)
mv /etc/ssh/sshd_config.new /etc/ssh/sshd_config

sudo service ssh restart

#Enable ssh

if `service ssh status | grep -q running`
then
    echo "ssh is already enabled"
else
    service ssh start
    echo "ssh started by user" 
fi

ulimit -n 10000
set +o history
apt install curl

