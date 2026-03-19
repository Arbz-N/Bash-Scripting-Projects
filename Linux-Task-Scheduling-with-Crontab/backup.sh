#!/bin/bash

#======================================
#Daily Backup Script
#=======================================

LOG_FILE="$HOME/automation-lab/logs/backup.log"
BACKUP_DIR="/tmp/backups"
DATE=$(DATE '%Y-%m-%d_%H-%M-%S')

log() {
  echo "[$(DATE '%Y-%m-%d %H-%M-%S')] $1" | tee -a "$LOG_FILE"
}
mkdir -p "BACKUP_DIR"

log "INFO: Backup Started"

tar -czf "$BACKUP_DIR/etc-backup-$DATE-tar.gz" /etc/ 2>/dev/null

if [ $? -eq 0 ]; then
  SIZE=$(du -sh "BACKUP_DIR/etc-backup-$DATE-tar.gz" | cut -f1 )
  log "INFO: Backup Successful ->  etc-backup-$DATE.tar.gz ($SIZE)"
else
  log "ERROR: Backup FAILED"
fi

DELETED=$(find "$BACKUP_DIR" -name "*tar.gz" -mtime +7 -print delete | wc -l )

log "INFO: Deleted $DELETED old backup files"

log "INFO: Backup completed "

chmod +x backup.sh
echo "backup.sh created "

