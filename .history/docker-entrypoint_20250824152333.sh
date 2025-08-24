#!/bin/sh
set -e

# Ensure necessary folders exist
mkdir -p /data/.n8n
mkdir -p /data/custom-nodes
mkdir -p /data/import

echo "Starting n8n with user folder at $N8N_USER_FOLDER"

# Start n8n
exec n8n
