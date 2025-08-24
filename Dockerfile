# Use the official n8n image as base
FROM n8nio/n8n:latest

# Copy importable workflows into the image
COPY import /import

# Copy custom nodes (if any)
COPY custom-nodes /data/custom-nodes

# Set n8n data directory
ENV N8N_USER_FOLDER=/data

# Ensure n8n runs even if PATH differs — run the n8n script directly with node
ENTRYPOINT ["node", "/usr/local/lib/node_modules/n8n/bin/n8n"]
