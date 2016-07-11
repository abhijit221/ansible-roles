# Ansible Roles

A collection of Ansible roles we created and use at Komand. Confidential information has been scrubbed.
Roles have been written for and tested on CentOS. Some roles include configuration for Debian systems but not all have been tested on them.

## Configuration

Customizable parameters such as keys, passwords, settings etc. are stored in variables files.

* Global variables are in `group_vars/all` 
* Role variables are in `roles/$role/vars/*.yml`

Modify these files for your environment.

We recommend using [Ansible Vault](https://docs.ansible.com/ansible/playbooks_vault.html) or [git-crypt](https://github.com/AGWA/git-crypt) to encrypt this files.

## Roles

The list contains included roles, supported OS, parameter files, and a brief description.

Role      | OS Family     | Param         | Description
----------|---------------|---------------|------------------------------
bro       |RedHat,Debian  | None          | Run Bro in a Docker container
common    |RedHat         |group_vars/all |
cronic    |All            |None           | Install Cronic, a cron wrapper script
docker    |RedHat,Debian  |None           | Install Docker Engine
drone     |RedHat,Debian  |vars/main.yml  | Run Drone in a container
duo       |RedHat,Debian  |vars/main.yml  | Install and configure Duo Security
facts     |All            |None           | Add Ansible External Facts
firewall  |RedHat,Debian  |None           | Enable UFW or Firewalld
mount     |All            |None           | Mount disks if available e.g. EBS on AWS
openswan  |RedHat         |vars/main.yml  | Install and configure an L2TP/IPSEC VPN with local authentication using OpenSWAN
rngd      |RedHat         |None           | Install random number generator service
routes    |RedHat         |None           | Add static routes
unbound   |RedHat,Debian  |None           | Install Unbound and configure as a forwarder
