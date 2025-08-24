#!/bin/sh
set -e

# Default to /usr/local/data if N8N_USER_FOLDER is not set
: "${N8N_USER_FOLDER:=/usr/local/data}"

echo "Ensuring n8n user folder at $N8N_USER_FOLDER"
mkdir -p "$N8N_USER_FOLDER/.n8n" "$N8N_USER_FOLDER/custom-nodes" "$N8N_USER_FOLDER/import"

# If image contains import files under /usr/local/data/import, copy them into the user folder import
if [ -d "/usr/local/data/import" ] && [ "$(ls -A /usr/local/data/import 2>/dev/null)" ]; then
  echo "Copying bundled imports into $N8N_USER_FOLDER/import"
  cp -a /usr/local/data/import/. "$N8N_USER_FOLDER/import/" || true
fi

echo "Starting n8n with user folder at $N8N_USER_FOLDER"

# Execute n8n (forward any args)
exec n8n "$@"
