#!/bin/bash

BE_LOCAL_DIR=$(pwd)
BE_REMOTE_DIR=/var/app/shop-api
SSH_ALIAS=ubuntu-sshuser

if ssh $SSH_ALIAS "[ ! -d $BE_REMOTE_DIR ]"; then
    echo "Creating dir $BE_REMOTE_DIR"
    ssh -t $SSH_ALIAS "sudo bash -c 'mkdir -p $BE_REMOTE_DIR && chown -R sshuser:sshuser $BE_REMOTE_DIR'"
else
    echo "Removing previous app"
    ssh $SSH_ALIAS "sudo -S rm -r $BE_REMOTE_DIR/*"
fi

echo "Building and Deploying app"
npm run build
scp -Cr dist/ package.json $SSH_ALIAS:$BE_REMOTE_DIR
ssh -t $SSH_ALIAS "which node"
ssh $SSH_ALIAS "which node && cd $BE_REMOTE_DIR && npm i && npm run restart:pm2"
echo "App built and deployed"
