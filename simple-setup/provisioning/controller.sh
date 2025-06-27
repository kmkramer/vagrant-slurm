#!/bin/bash
# Update and install dependencies
apt-get update
apt-get install -y slurmctld slurmd munge

# Configure MUNGE for authentication
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

# Create spool directories
mkdir -p /var/spool/slurmctld
chown slurm:slurm /var/spool/slurmctld
chmod 755 /var/spool/slurmctld

# Start Slurm controller
systemctl enable slurmctld
systemctl start slurmctld