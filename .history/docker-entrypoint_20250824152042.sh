#!/bin/sh
set -e

# Ensure folders exist
mkdir -p /data/custom-nodes
mkdir -p /import

# Load workflows automatically if any exist
if [ -d "/import" ] && [ "$(ls -A /import)" ]; then
  echo "Importing workflows..."
  n8n import:workflow --input=/import/*.json || true
fi

# Start n8n
exec n8n
