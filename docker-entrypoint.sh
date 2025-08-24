#!/bin/sh
set -e

# Determine desired user folder, prefer env value, default to /usr/local/data
: "${N8N_USER_FOLDER:=/usr/local/data}"

choose_writable_folder() {
  TARGET="$1"
  # try to create folder and test writability by creating a temp file
  if mkdir -p "$TARGET" 2>/dev/null; then
    if touch "$TARGET/.n8n_writable_test" 2>/dev/null; then
      rm -f "$TARGET/.n8n_writable_test" 2>/dev/null || true
      echo "$TARGET"
      return 0
    fi
  fi
  return 1
}

# 1) Try configured folder
if choose_writable_folder "$N8N_USER_FOLDER"; then
  echo "Using configured N8N_USER_FOLDER: $N8N_USER_FOLDER"
else
  echo "Warning: cannot create or write to configured N8N_USER_FOLDER '$N8N_USER_FOLDER'. Trying /usr/local/data"
  N8N_USER_FOLDER=/usr/local/data
  if choose_writable_folder "$N8N_USER_FOLDER"; then
    echo "Using fallback N8N_USER_FOLDER: $N8N_USER_FOLDER"
  else
    echo "Warning: /usr/local/data not writable. Falling back to /tmp/n8n"
    N8N_USER_FOLDER=/tmp/n8n
    mkdir -p "$N8N_USER_FOLDER"
    echo "Using fallback N8N_USER_FOLDER: $N8N_USER_FOLDER"
  fi
fi

# Create required subfolders
mkdir -p "$N8N_USER_FOLDER/.n8n" "$N8N_USER_FOLDER/custom-nodes" "$N8N_USER_FOLDER/import"

# Copy bundled imports if any (image copy location)
if [ -d "/usr/local/data/import" ] && [ "$(ls -A /usr/local/data/import 2>/dev/null)" ]; then
  echo "Copying bundled imports into $N8N_USER_FOLDER/import"
  cp -a /usr/local/data/import/. "$N8N_USER_FOLDER/import/" || true
fi

echo "Starting n8n with user folder at $N8N_USER_FOLDER"

exec n8n "$@"
