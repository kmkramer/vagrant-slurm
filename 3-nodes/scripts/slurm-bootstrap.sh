#!/bin/bash

echo "creating users"
sudo adduser --uid 1111 --disabled-password --gecos "" munge
sudo adduser --uid 1121 --disabled-password --gecos "" slurm

echo "setting up munge"
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install libmunge-dev libmunge2 munge
sudo systemctl enable munge
#sudo chown -R munge: /etc/munge /var/log/munge /var/lib/munge /run/munge

if [ $HOSTNAME == "controller" ]
then
	echo "setting up controller"
	sudo apt -y install slurmdbd
	sudo systemctl start munge
	munge -n | unmunge | grep STATUS
	sudo cp /etc/munge/munge.key /vagrant/munge/munge.key
else
	echo "setting up non-controller nodes"
	sudo cp -p /vagrant/munge/munge.key /etc/munge/munge.key
	sudo chown munge /etc/munge/munge.key
	sudo systemctl start munge
	munge -n | unmunge | grep STATUS
fi
