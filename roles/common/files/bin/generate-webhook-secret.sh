#!/usr/bin/env bash

set -o nounset
set -e errexit

SECRET_NAME=gitlab-webhook-secret

if ! oc get secret ${SECRET_NAME} 1>/dev/null 2>&1
then
  oc create secret generic ${SECRET_NAME} \
    --from-literal=WebHookSecretKey=$(uuidgen) \
    --type=kubernetes.io/opaque
else
  echo "Secret ${SECRET_NAME} already exists..."
  exit 1
fi
