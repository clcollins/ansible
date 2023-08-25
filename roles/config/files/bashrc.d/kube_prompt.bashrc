# This file is managed by Ansible
# Do not make local modifications directly

#!/usr/bin/env bash

KUBE_PS1_BINARY=oc
KUBE_PS1="${HOME}/.local/share/kube-ps1/kube-ps1.sh"
if [[ -f KUBE_PS1 ]]
then
    source $KUBE_PS1
    PS1='$(kube_ps1)[\u@\h \W]\$ '
fi

