#!/bin/bash

    # Create required directories
mkdir -p /scripts /backup

    # ===== VARIABLES =====
SOURCE_DIR="/var/www/html/ecommerce"         # Website directory to backup
BACKUP_DIR="/backup"                          # Local backup storage directory
BACKUP_FILE="ecommerce.zip"                   # Name of the backup archive
REMOTE_USER="user1"                           # Remote server username
REMOTE_SERVER="datacenter1"                   # Remote server hostname or IP
REMOTE_DIR="/backup"                          # Remote directory to store backup

    # Create a zip archive of the website data
zip -r ${BACKUP_DIR}/${BACKUP_FILE} ${SOURCE_DIR}

    # Copy the backup archive to the remote data center server
scp ${BACKUP_DIR}/${BACKUP_FILE} ${REMOTE_USER}@${REMOTE_SERVER}:${REMOTE_DIR}

echo "✅ Backup completed successfully!"
