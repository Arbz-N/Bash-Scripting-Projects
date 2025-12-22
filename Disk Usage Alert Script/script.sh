#!/bin/bash
#=========================================
# Script: disk_alert.sh
# Purpose: Send alert if disk usage > 80%
#=========================================

THRESHOLD=80
USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Disk usage high on $(hostname): $USAGE%"
else
    echo "Disk OK: $USAGE%"
fi