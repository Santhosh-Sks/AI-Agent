#!/bin/sh
set -e

# Ensure folders exist
mkdir -p /data/custom-nodes
mkdir -p /import

# Import workflows on first run (optional)
if [ -d "/import" ] && [ "$(ls -A /import)" ]; then
  echo "Found workflows to import..."
  # This assumes JSON workflow files
  for wf in /import/*.json; do
    echo "Importing workflow: $wf"
    n8n import:workflow --input="$wf" || true
  done
fi

# Execute n8n with passed command
exec "$@"
