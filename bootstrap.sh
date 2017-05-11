#!/bin/bash

# This script can be downloaded and run to bootstrap the Ansible config
#
# https://raw.githubusercontent.com/clcollins/ansible/master/bootstrap.sh
#
# Or, a short URL for the above: https://git.io/v9O46
#
# Eg: curl -sSL https://git.io/v9O46 -o /tmp/bootstrap.sh
#
# Currently only Fedora support

set -e

ANSIBLE_REPO="https://github.com/clcollins/ansible.git"
CHECKOUT_DIR="/tmp/ansible-bootstrap"

PACKAGE_MANAGER_CMD="dnf install -y"
ANSIBLE_PACKAGE="ansible"

# Bootstrap for Ansible 
if ! ansible --version
then
  $PACKAGE_MANAGER_CMD $ANSIBLE_PACKAGE
fi

ansible-pull --verify-commit --clean -d ${CHECKOUT_DIR} -U ${ANSIBLE_REPO}
