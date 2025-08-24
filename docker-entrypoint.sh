#!/bin/sh
set -e

# Ensure data dir exists
mkdir -p /data

# If there is no SQLite DB yet, import the workflows once
# (If you later use Postgres or a mounted disk, this still works fine.)
if [ ! -f /data/database.sqlite ]; then
  echo "No database found, importing workflows from /import/workflows (if any)..."
  if [ -d /import/workflows ]; then
    # Import all JSON files in the folder
    n8n import:workflow --input=/import/workflows --separate || true
  fi
else
  echo "Database exists, skipping import."
fi

# Hand off to n8n (Render will pass the port via N8N_PORT=$PORT)
exec n8n start
