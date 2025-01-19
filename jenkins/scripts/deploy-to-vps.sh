#!/bin/bash

cp $SSH_KEY_PATH ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh -i ~/.ssh/id_rsa $SSH_USERNAME@$SSH_HOST "./deploy.sh"
rm ~/.ssh/id_rsa

