#!/bin/sh
set -e

# Ensure data dir exists
mkdir -p /data

# Set up n8n environment
export N8N_USER_FOLDER=${N8N_USER_FOLDER:-/data}

# If there is no SQLite DB yet, try to import workflows
if [ ! -f "$N8N_USER_FOLDER/database.sqlite" ]; then
  echo "No database found, will import workflows after n8n starts..."
  if [ -d /import/workflows ]; then
    # Start n8n in background to initialize database
    echo "Starting n8n to initialize database..."
    node /usr/local/lib/node_modules/n8n/bin/n8n &
    N8N_PID=$!
    
    # Wait for n8n to be ready
    sleep 10
    
    # Import workflows
    for workflow in /import/workflows/*.json; do
      if [ -f "$workflow" ]; then
        echo "Importing workflow: $workflow"
        node /usr/local/lib/node_modules/n8n/bin/n8n import:workflow --input="$workflow" || echo "Failed to import $workflow"
      fi
    done
    
    # Stop the background n8n
    kill $N8N_PID 2>/dev/null || true
    wait $N8N_PID 2>/dev/null || true
  fi
else
  echo "Database exists, skipping import."
fi

# Start n8n normally
echo "Starting n8n..."
exec node /usr/local/lib/node_modules/n8n/bin/n8n
