# Use the official n8n image
FROM n8nio/n8n:latest

# (Optional) Install extra OS packages if your custom nodes need them
# RUN apk add --no-cache ...   # for alpine

# Copy importable workflows into the image
COPY import /import

# Copy custom nodes directory (will create directory if it doesn't exist)
COPY custom-nodes /data/custom-nodes

# Copy our entrypoint that will import workflows on first boot
COPY --chmod=755 docker-entrypoint.sh /docker-entrypoint.sh

# Set the data directory (works with or without a mounted disk)
ENV N8N_USER_FOLDER=/data

# Start via our entrypoint (it will import then launch n8n)
ENTRYPOINT ["/docker-entrypoint.sh"]
