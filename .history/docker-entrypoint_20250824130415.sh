#!/bin/sh
set -e

# Ensure data dir exists
mkdir -p /data

echo "Starting n8n with data folder: $N8N_USER_FOLDER"

# Start n8n directly using the default entrypoint
exec /usr/local/bin/docker-entrypoint.sh n8n
