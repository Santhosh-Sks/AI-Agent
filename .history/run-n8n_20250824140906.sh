#!/bin/sh
set -e

# Ensure data directory exists
mkdir -p /data

# If workflows are present in /import/workflows, print them (no automatic import to avoid CLI issues)
if [ -d "/import/workflows" ] && [ "$(ls -A /import/workflows 2>/dev/null)" ]; then
  echo "Found workflows to import:"
  ls -1 /import/workflows || true
fi

# Start n8n directly via node, ignore any CMD arguments passed by the platform
exec node /usr/local/lib/node_modules/n8n/bin/n8n
