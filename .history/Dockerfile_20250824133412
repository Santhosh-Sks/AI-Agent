# Use the official n8n image as base
FROM n8nio/n8n:latest

# Copy importable workflows into the image
COPY import /import

# Copy custom nodes (if any)
COPY custom-nodes /data/custom-nodes

# Set n8n data directory
ENV N8N_USER_FOLDER=/data

# Copy our custom entrypoint with executable permissions
COPY --chmod=755 docker-entrypoint.sh /docker-entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

# Default command (just n8n, not n8n start)
CMD ["n8n"]
