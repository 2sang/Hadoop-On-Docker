#!/bin/bash
# init.sh

# This enables execute runtime command at once, and runs in container.
# just list all needed commands below.


# Add (ip, 'master') set in /etc/hosts
echo $(hostname --ip-address) master >> /etc/hosts

# keygen
ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa

# for every single nodes,

for ((c=0; c<=$1; c++))
do
	ssh-keyscan -H slave$c >> ~/.ssh/known_hosts
	sshpass -f /password.txt ssh-copy-id slave$c
done

# last target command
#/usr/sbin/sshd -D
