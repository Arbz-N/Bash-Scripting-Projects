#!/bin/bash
# =============================================
# Weekly Log Cleanup Script
# =============================================

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

LOG_FILE="$HOME/automation-lab/logs/cleanup.log"
TARGET_DIR="/var/log"
MAX_DAYS=30

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "INFO: Log cleanup started"

# Purane logs count karo
OLD_COUNT=$(find "$TARGET_DIR" -name "*.log" \
  -mtime +$MAX_DAYS 2>/dev/null | wc -l)
log "INFO: Found $OLD_COUNT files older than $MAX_DAYS days"

# Disk space before
SPACE_BEFORE=$(df -h / | tail -1 | awk '{print $4}')

# Delete karo
find "$TARGET_DIR" -name "*.log" \
  -mtime +$MAX_DAYS \
  -delete 2>/dev/null

# Disk space after
SPACE_AFTER=$(df -h / | tail -1 | awk '{print $4}')

log "INFO: Free space: $SPACE_BEFORE → $SPACE_AFTER"
log "INFO: Cleanup completed "
EOF

chmod +x cleanup-logs.sh
echo "cleanup-logs.sh created "