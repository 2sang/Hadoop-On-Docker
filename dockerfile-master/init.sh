#!/bin/bash
# init.sh

SLAVES_NUMBER=$1

# This enables execute runtime command at once, and runs in container.
# just list all needed commands below.


# Add (ip, 'master') set in /etc/hosts
echo $(hostname --ip-address) master >> /etc/hosts

rm $HADOOP_HOME/etc/hadoop/slaves
echo "master" >> $HADOOP_HOME/etc/hadoop/slaves

# keygen
ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa

# for every single nodes,

for ((c=1; c<=$SLAVES_NUMBER; c++))
do
	echo "slave$c" >> $HADOOP_HOME/etc/hadoop/slaves
	ssh-keyscan -H slave$c >> ~/.ssh/known_hosts
	sshpass -f /password.txt ssh-copy-id slave$c
done

ssh-keyscan -H master >> ~/.ssh/known_hosts
sshpass -f /password.txt ssh-copy-id master
ssh-keyscan -H 0.0.0.0 >> ~/.ssh/known_hosts

hdfs namenode -format
start-all.sh

# last target command
#/usr/sbin/sshd -D
