#!/bin/bash
# Update and install dependencies
apt-get update
apt-get install -y slurmd munge

# Configure MUNGE
cat /vagrant/config/munge.key > /etc/munge/munge.key
chown munge:munge /etc/munge/munge.key
chmod 600 /etc/munge/munge.key
systemctl enable munge
systemctl start munge

# Slurm configuration file
cat /vagrant/config/slurm.conf > /etc/slurm/slurm.conf

# Set permissions
chown slurm:slurm /etc/slurm/slurm.conf
chmod 644 /etc/slurm/slurm.conf

# Create spool directory
mkdir -p /var/spool/slurmd
chown slurm:slurm /var/spool/slurmd
chmod 755 /var/spool/slurmd

# Start Slurm daemon
systemctl enable slurmd
systemctl start slurmd