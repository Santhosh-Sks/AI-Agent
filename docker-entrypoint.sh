#!/bin/sh
set -e

# Ensure folders exist
mkdir -p /data

echo "Starting n8n..."

# Import workflows on first run (optional)
if [ -d "/import/workflows" ] && [ "$(ls -A /import/workflows 2>/dev/null)" ]; then
  echo "Found workflows to import..."
  for wf in /import/workflows/*.json; do
    if [ -f "$wf" ]; then
      echo "Found workflow: $wf"
      # We'll import these after n8n starts
    fi
  done
fi

# Start n8n directly
exec n8n
