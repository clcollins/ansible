#!/bin/bash

# This script can be downloaded and run to bootstrap the Ansible config
#
# https://raw.githubusercontent.com/clcollins/ansible/master/bootstrap.sh
#
# Or, a short URL for the above: https://git.io/v9O46
#
# Eg: curl -sSL https://git.io/v9O46 -o /tmp/bootstrap.sh

# Currently only Fedora support

ANSIBLE_REPO="https://github.com/clcollins/ansible.git"
CHECKOUT_DIR="/tmp/ansible-bootstrap"

# Bootstrap for Ansible 
dnf install -y ansible && ansible-pull -d ${CHECKOUT_DIR} -U ${ANSIBLE_REPO}
