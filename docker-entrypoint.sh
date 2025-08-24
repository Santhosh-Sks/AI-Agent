#!/bin/sh
set -e

# Determine desired user folder, default to /usr/local/data
: "${N8N_USER_FOLDER:=/usr/local/data}"

# Try to create the configured user folder; if that fails, fall back to /usr/local/data
if ! mkdir -p "$N8N_USER_FOLDER" 2>/dev/null; then
  echo "Warning: cannot create or write to configured N8N_USER_FOLDER '$N8N_USER_FOLDER'. Falling back to /usr/local/data"
  N8N_USER_FOLDER=/usr/local/data
fi

# If /usr/local/data is not writable, fall back to /tmp/n8n
if ! mkdir -p "$N8N_USER_FOLDER" 2>/dev/null; then
  echo "Warning: /usr/local/data not writable. Falling back to /tmp/n8n"
  N8N_USER_FOLDER=/tmp/n8n
  mkdir -p "$N8N_USER_FOLDER"
fi

# Ensure necessary subfolders exist inside the chosen user folder
mkdir -p "$N8N_USER_FOLDER/.n8n" "$N8N_USER_FOLDER/custom-nodes" "$N8N_USER_FOLDER/import"

# If the image bundled imports under /usr/local/data/import, copy them into the active user folder import
if [ -d "/usr/local/data/import" ] && [ "$(ls -A /usr/local/data/import 2>/dev/null)" ]; then
  echo "Copying bundled imports into $N8N_USER_FOLDER/import"
  cp -a /usr/local/data/import/. "$N8N_USER_FOLDER/import/" || true
fi

echo "Starting n8n with user folder at $N8N_USER_FOLDER"

# Execute n8n with any provided args
exec n8n "$@"
