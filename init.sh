#!/bin/bash

REMOTE_USER="vagrant"
REMOTE_HOST="192.168.56.23"
REMOTE_PORT=22
SSH_KEY="$HOME/.ssh/CloudOneKey"

# Step 1: Generate SSH key if not already present
if [ ! -f "$SSH_KEY" ]; then
  echo "🔐 Generating SSH key..."
  ssh-keygen -t rsa -b 4096 -N "" -f "$SSH_KEY"
else
  echo "✅ SSH key already exists"
fi

# Step 2: Copy SSH key to remote host
echo "🔗 Copying SSH key to $REMOTE_HOST..."
ssh-copy-id -i "$SSH_KEY.pub" -p $REMOTE_PORT "$REMOTE_USER@$REMOTE_HOST"

# Step 3: Install Ansible Docker collection locally
echo "📦 Installing community.docker collection..."
ansible-galaxy collection install community.docker:3.4.11
