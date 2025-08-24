# Use the official n8n base image
FROM n8nio/n8n:latest

# Copy workflows (if you have prebuilt importable JSONs)
COPY import /import

# Copy custom nodes (optional)
COPY custom-nodes /data/custom-nodes

# Copy custom entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Set the n8n user folder
ENV N8N_USER_FOLDER=/data

# Use our entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

# Expose n8n default port
EXPOSE 5678

# Default command
CMD ["n8n", "start"]
