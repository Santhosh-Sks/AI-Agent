# Use the official n8n image
FROM n8nio/n8n:latest

# Use a writable data folder (avoid creating /data at build time)
ENV N8N_USER_FOLDER=/usr/local/data

# Copy importable workflows and custom nodes into the writable data folder
COPY import ${N8N_USER_FOLDER}/import
COPY custom-nodes ${N8N_USER_FOLDER}/custom-nodes

# Copy entrypoint script with permissions (set at copy time to avoid chmod errors)
COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Use our entrypoint script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
