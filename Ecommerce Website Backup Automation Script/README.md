**Ecommerce Website Backup Automation Script**
    Project Overview

    1. This project provides a fully automated backup solution for an ecommerce website hosted on a Linux server. The script:
    2. Creates a compressed archive of the website directory.
    3. Stores the archive in a local backup directory.
    4. Copies the backup to a remote data center server securely.
    5. Enables passwordless transfer using SSH key-based authentication.

This ensures your website data is securely archived and transferred offsite for disaster recovery.

Prerequisites

Before using this script, make sure:

    Linux Server (Source)
    Bash shell available
    zip utility installed (sudo apt install zip for Debian/Ubuntu)
    /backup directory exists or will be created by the script

    Remote Server (Data Center)
    SSH access is available
    User has write permissions to the target /backup directory
    Passwordless SSH Authentication
    Generate SSH key pair on the source server:

    ssh-keygen -t rsa -b 4096


Copy the public key to the remote server:

    ssh-copy-id user1@datacenter1

Script Details
    #!/bin/bash
    
    # Create required directories
    sudo mkdir -p /scripts /backup
    
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


This ensures the script runs without prompting for a password.

Usage

    Save the script as backup_ecommerce.sh.
    Make the script executable:
    chmod +x backup_ecommerce.sh

Run the script manually:

    ./backup_ecommerce.sh


The backup will be stored locally in /backup and securely transferred to the remote data center.

Automating with Cron

    To schedule automatic backups, add a cron job:
    Open crontab editor:
    crontab -e


Add a line to run daily at 2 AM:

    0 2 * * * /path/to/backup_ecommerce.sh >> /var/log/ecommerce_backup.log 2>&1


Save and exit. The backup script will run automatically, and logs will be saved to /var/log/ecommerce_backup.log.