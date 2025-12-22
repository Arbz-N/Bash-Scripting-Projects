#!/bin/bash
#=========================================
# Script: cpu_alert.sh
# Purpose: Send alert if CPU load is high
#=========================================

THRESHOLD=70
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)

if [ "$CPU_LOAD" -gt "$THRESHOLD" ]; then
    echo " High CPU usage: $CPU_LOAD%"
else
    echo "CPU normal: $CPU_LOAD%"
fi
