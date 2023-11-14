#!/bin/sh

# Start SSH SOCKS proxy
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no -N -D 0.0.0.0:$SOCKS_PORT -p $SSH_PORT $SSH_USER@$SSH_HOST