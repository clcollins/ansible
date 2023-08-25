#!/usr/bin/env sh
# OpenShift SOPs

function sop() {
  local OPSSOP="${HOME}/Projects/github.com/openshift/ops-sop"
  if [[ ! -d $OPSSOP ]]
  then
    echo "Not found: $OPSSOP"
  fi
  cd $OPSSOP
}