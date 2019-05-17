#!/usr/bin/env bash

set -o errexit
set -o nounset

DEPLOY_KEY_NAME='gitlab-deploy-key'

if [ -f $DEPLOY_KEY_NAME ]
then
  echo "File $DEPLOY_KEY_NAME already exists"
  exit 1
else
  ssh-keygen -q -t ed25519 -f $DEPLOY_KEY_NAME -N ''

  if ! oc get secret $DEPLOY_KEY_NAME 1>/dev/null 2>&1
  then
    oc create secret generic $DEPLOY_KEY_NAME \
   --from-file=ssh-privatekey=$DEPLOY_KEY_NAME \
   --type=kubernetes.io/ssh-auth
  fi

  echo "Created Kubernetes secret ${DEPLOY_KEY_NAME} with private key"
  echo "Public key ->>"

  cat ${DEPLOY_KEY_NAME}.pub

  rm $DEPLOY_KEY_NAME $DEPLOY_KEY_NAME.pub
fi
