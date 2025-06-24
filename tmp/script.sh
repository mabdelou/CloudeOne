#!/bin/bash

INVENTORY="inventory/hosts.yaml"
START_PLAYBOOK="playbooks/deploy_site.yaml"
DOWN_PLAYBOOK="playbooks/teardown_site.yaml"

if [ "$1" == "start" ]; then
  echo "🚀 Starting deployment..."
  ansible-playbook -i "$INVENTORY" "$START_PLAYBOOK" --ask-vault-pass
elif [ "$1" == "down" ]; then
  echo "🧹 Running teardown..."
  ansible-playbook -i "$INVENTORY" "$DOWN_PLAYBOOK" --ask-vault-pass
else
  echo "❌ Usage: $0 {start|down}"
  exit 1
fi
