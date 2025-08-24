#!/bin/sh
set -e

echo ">>> Starting n8n with data folder: $N8N_USER_FOLDER"

# Make sure the data folder exists
mkdir -p /data

# If workflows exist in /import, try to import them once
if [ -d "/import" ] && [ "$(ls -A /import 2>/dev/null)" ]; then
  echo ">>> Importing workflows from /import"
  n8n import:workflow --input=/import/*.json || true
fi

# Run n8n with whatever command was passed
exec "$@"
