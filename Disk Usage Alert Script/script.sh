#!/bin/bash
#=========================================
# Script: disk_alert.sh
# Purpose: Send email alert if disk usage > 80%
#=========================================

THRESHOLD=70
EMAIL="admin@example.com"

USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    if command -v mail &> /dev/null; then
        echo "Disk usage is above threshold. Current usage is $USAGE%." | mail -s "Disk Usage Alert" "$EMAIL"
    else
        echo "Usage is above threshold but mail command is not installed."
    fi
fi
