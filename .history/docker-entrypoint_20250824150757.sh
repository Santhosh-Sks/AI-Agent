#!/bin/sh
set -e

echo ">>> Starting n8n with data folder: $N8N_USER_FOLDER"

# Make sure the data folder exists
mkdir -p /data

# If workflows exist in /import, try to import them once (best-effort)
if [ -d "/import" ] && [ "$(ls -A /import 2>/dev/null)" ]; then
  echo ">>> Importing workflows from /import"
  for wf in /import/*.json; do
    [ -f "$wf" ] || continue
    echo ">>> Importing: $wf"
    node /usr/local/lib/node_modules/n8n/bin/n8n import:workflow --input="$wf" || echo ">>> Import failed for $wf, continuing..."
  done
fi

# Determine what command to run. Some platforms pass 'start' which is not a n8n CLI subcommand.
# If no args or a 'start' arg is provided, run the n8n binary directly via node.
if [ "$#" -eq 0 ]; then
  echo ">>> No command provided, starting n8n"
  exec node /usr/local/lib/node_modules/n8n/bin/n8n
fi

if [ "$1" = "start" ]; then
  echo ">>> Platform passed 'start', starting n8n binary instead"
  exec node /usr/local/lib/node_modules/n8n/bin/n8n
fi

if [ "$1" = "n8n" ] && [ "$2" = "start" ]; then
  echo ">>> Platform passed 'n8n start', starting n8n binary instead"
  exec node /usr/local/lib/node_modules/n8n/bin/n8n
fi

# Otherwise run the provided command
exec "$@"
