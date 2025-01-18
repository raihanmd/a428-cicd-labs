#!/bin/bash
if [[ -z "$SSH_KEY_PATH" || -z "$SSH_USERNAME" || -z "$SSH_HOST" ]]; then
  echo "Error: Environment variables SSH_KEY_PATH, SSH_USERNAME, and SSH_HOST must be set."
  exit 1
fi

echo Copy files to the server
scp -i "$SSH_KEY_PATH" -r build/* "$SSH_USERNAME@$SSH_HOST:/var/www/react"

echo Start react application using PM2
ssh -i "$SSH_KEY_PATH" "$SSH_USERNAME@$SSH_HOST" << EOF
    pm2 stop react || true
    pm2 start npm --name "react" -- start --prefix /var/www/react-app
EOF
