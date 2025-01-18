#!/bin/bash

if [[ -z "$SSH_KEY_PATH" || -z "$SSH_USERNAME" || -z "$SSH_HOST" ]]; then
  echo "Error: Environment variables SSH_KEY_PATH, SSH_USERNAME, and SSH_HOST must be set."
  exit 1
fi

echo Deploy on VPS
ssh -i "$SSH_KEY_PATH" ${SSH_USERNAME}@${SSH_HOST} "bash -s" < ./deploy.sh



