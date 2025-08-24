# Use the official n8n image as base
FROM n8nio/n8n:latest

# Copy importable workflows into the image
COPY import /import

# Copy custom nodes (if any)
COPY custom-nodes /data/custom-nodes

# Set n8n data directory
ENV N8N_USER_FOLDER=/data

# The default n8n image already has the correct entrypoint
# We'll let it handle startup normally
# Add a fallback CMD so the container runs the correct n8n command if the platform doesn't override it
CMD ["n8n"]
