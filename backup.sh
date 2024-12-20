#!/bin/bash

# Set variables
CONTAINER_NAME="n8n-n8n-1"  # Replace with your n8n container name or ID
BACKUP_DIR="./backups"  # Directory on the host to store backups
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Export workflows
docker exec -u node "$CONTAINER_NAME" n8n export:workflow --all --output=/home/node/.n8n/workflows_$TIMESTAMP.json

# Export credentials
docker exec -u node "$CONTAINER_NAME" n8n export:credentials --all --output=/home/node/.n8n/credentials_$TIMESTAMP.json

# Copy the exported files to the host
docker cp "$CONTAINER_NAME":/home/node/.n8n/workflows_$TIMESTAMP.json "$BACKUP_DIR"/
docker cp "$CONTAINER_NAME":/home/node/.n8n/credentials_$TIMESTAMP.json "$BACKUP_DIR"/

# Optional: Remove the exported files from the container
docker exec -u node "$CONTAINER_NAME" rm /home/node/.n8n/workflows_$TIMESTAMP.json
docker exec -u node "$CONTAINER_NAME" rm /home/node/.n8n/credentials_$TIMESTAMP.json

echo "Backup completed successfully. Files are stored in $BACKUP_DIR"
