#!/bin/bash

# This script can be downloaded and run to bootstrap the Ansible config

ANSIBLE_REPO="https://github.com/clcollins/ansible.git"
CHECKOUT_DIR="/tmp/ansible-bootstrap"

# Bootstrap for Ansible 
dnf install -y ansible && sudo ansible-pull -d ${CHECKOUT_DIR} -U ${ANSIBLE_REPO}
