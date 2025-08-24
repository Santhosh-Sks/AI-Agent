#!/bin/sh
set -e

# Ensure data dir exists
mkdir -p /data

echo "Starting n8n with data folder: $N8N_USER_FOLDER"

# Start n8n directly without any custom entrypoint
exec n8n
