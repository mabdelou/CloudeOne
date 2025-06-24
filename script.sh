#!/bin/bash

# Define paths to Ansible inventory and playbook files
INVENTORY="inventory/hosts.yaml"
START_PLAYBOOK="playbooks/deploy_site.yaml"
DOWN_PLAYBOOK="playbooks/teardown_site.yaml"

# Check command line argument to determine action
if [ "$1" == "start" ]; then
  echo "🚀 Starting deployment..."
  # Run Ansible playbook with inventory file and prompt for vault password
  ansible-playbook -i "$INVENTORY" "$START_PLAYBOOK" --ask-vault-pass
elif [ "$1" == "down" ]; then
  echo "🧹 Running teardown..."
  # Run teardown playbook with inventory file and prompt for vault password
  ansible-playbook -i "$INVENTORY" "$DOWN_PLAYBOOK" --ask-vault-pass
else
  # Display usage information if invalid or no argument provided
  echo "❌ Usage: $0 {start|down}"
  exit 1
fi
