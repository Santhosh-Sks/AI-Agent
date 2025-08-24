#!/bin/sh
set -e

echo ">>> Starting n8n with environment: $N8N_USER_FOLDER"

# Run any pre-start logic (imports, migrations, etc.)
if [ -d "/import" ]; then
  echo ">>> Importing workflows from /import"
  n8n import:workflow --input=/import/*.json || true
fi

exec "$@"
