#!/usr/bin/env bash

# Install the Go version if it's not already;
# and either way, switch to it
use_or_install_go_ver() {
  if ! gvm list | grep ${go_version}
  then
    gvm install go${go_version}
  fi
  gvm use go${go_version}
}

