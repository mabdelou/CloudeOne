#!/bin/bash

# Define SSH connection parameters
REMOTE_USER="vagrant"          # Username for the Vagrant VM
REMOTE_HOST="192.168.56.23"    # IP address of the Vagrant VM (matches Vagrantfile)
REMOTE_PORT=22                 # SSH port
SSH_KEY="$HOME/.ssh/CloudOneKey" # Path to store the SSH key

# Create Python virtual environment in .venv/
if [ ! -d ".venv" ]; then
  echo "🔧 Creating virtual environment..."
  virtualenv .venv
else
  echo "✅ Virtual environment already exists"
fi

# Activate the virtual environment to isolate Python dependencies
source .venv/bin/activate
echo "🐍 Virtualenv activated: $(which python)"

# Start the Vagrant VM that will host the Docker containers
echo "🚀 Starting Vagrant..."
vagrant up

# Step 1: Generate SSH key if not already present
# This key will be used for passwordless authentication with the VM
if [ ! -f "$SSH_KEY" ]; then
  echo "🔐 Generating SSH key..."
  ssh-keygen -t rsa -b 4096 -N "" -f "$SSH_KEY"
else
  echo "✅ SSH key already exists"
fi

# Step 2: Copy SSH key to the Vagrant VM for passwordless authentication
echo "🔗 Copying SSH key to $REMOTE_HOST..."
ssh-copy-id -i "$SSH_KEY.pub" -p $REMOTE_PORT "$REMOTE_USER@$REMOTE_HOST"

# Step 3: Install required Ansible collection for Docker management
echo "📦 Installing community.docker collection..."
ansible-galaxy collection install community.docker:3.4.11
