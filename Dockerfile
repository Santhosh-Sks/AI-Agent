# Use the official n8n base image
FROM n8nio/n8n:latest

# Copy workflows (optional, if you want to pre-import them)
COPY import /import

# Copy custom nodes (optional)
COPY custom-nodes /data/custom-nodes

# Copy custom entrypoint script with permissions
COPY --chmod=755 docker-entrypoint.sh /docker-entrypoint.sh

# Set persistent data directory
ENV N8N_USER_FOLDER=/data

# Use our entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

# Expose n8n port
EXPOSE 5678

# Start n8n
CMD ["n8n"]
