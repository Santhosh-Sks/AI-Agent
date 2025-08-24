#!/bin/sh
set -e

# Ensure data directory exists
mkdir -p /data

echo "Starting n8n..."

# Import workflows on first run (optional)
if [ -d "/import/workflows" ] && [ "$(ls -A /import/workflows 2>/dev/null)" ]; then
  echo "Found workflows to import..."
  for wf in /import/workflows/*.json; do
    if [ -f "$wf" ]; then
      echo "Found workflow: $wf"
    fi
  done
fi

# Use the original n8n entrypoint
exec /usr/local/bin/docker-entrypoint.sh "$@"
