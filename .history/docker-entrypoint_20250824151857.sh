#!/bin/sh
set -e

# Ensure data dir exists
mkdir -p /data

# Run n8n with Render's assigned port
exec n8n start --tunnel
