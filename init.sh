#!/bin/bash

# Define SSH connection parameters
REMOTE_USER="vagrant"              # Username for the Vagrant VM
REMOTE_HOST="192.168.56.23"        # IP address of the Vagrant VM (matches Vagrantfile)
REMOTE_PORT=22                     # SSH port
SSH_KEY="$HOME/.ssh/CloudOneKey"   # Path to the SSH key

# Step 1: Create Python virtual environment in .venv/
if [ ! -d ".venv" ]; then
  echo "🔧 Creating virtual environment..."
  python3 -m virtualenv .venv
else
  echo "✅ Virtual environment already exists"
fi

# Step 2: Activate the virtual environment to isolate Python dependencies
source .venv/bin/activate
echo "🐍 Virtualenv activated: $(which python)"

# Step 3: Install required Python dependencies
echo "📦 Installing Python dependencies..."
pip install -r requirements.txt

# Step 4: Install required Ansible collection for Docker management
echo "📦 Installing community.docker collection..."
ansible-galaxy collection install community.docker:3.4.11

# Step 5: Start the Vagrant VM that will host the Docker containers
echo "🚀 Starting Vagrant..."
vagrant up

# Step 6: Generate SSH key if not already present
if [ ! -f "$SSH_KEY" ]; then
  echo "🔐 Generating SSH key..."
  ssh-keygen -t rsa -b 4096 -N "" -f "$SSH_KEY"
else
  echo "✅ SSH key already exists"
fi

# Step 7: Copy SSH key to the Vagrant VM for passwordless authentication
echo "🔗 Copying SSH key to $REMOTE_HOST..."
ssh-copy-id -i "$SSH_KEY.pub" -p $REMOTE_PORT "$REMOTE_USER@$REMOTE_HOST"
