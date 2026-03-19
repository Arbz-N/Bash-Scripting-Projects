#!/bin/bash
# =============================================
# System Health Check
# =============================================

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

LOG_FILE="$HOME/automation-lab/logs/health.log"
ALERT_CPU=80
ALERT_MEM=85
ALERT_DISK=90
STATUS="OK"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

alert() {
  log "ALERT: $1"
  STATUS="ALERT"
  # Production mein: mail, Slack webhook, PagerDuty
  # echo "ALERT: $1" | mail -s "Server Alert" admin@example.com
}

log "INFO: ── Health check started ──"

# CPU check
CPU=$(top -bn1 | grep "Cpu(s)" | \
  awk '{print $2}' | cut -d'%' -f1 | \
  cut -d',' -f1 | awk '{printf "%.0f", $1}')
log "INFO: CPU Usage: ${CPU}%"
[ "$CPU" -gt "$ALERT_CPU" ] && \
  alert "CPU high: ${CPU}% > threshold ${ALERT_CPU}%"

# Memory check
MEM=$(free | grep Mem | \
  awk '{printf "%.0f", $3/$2 * 100}')
log "INFO: Memory Usage: ${MEM}%"
[ "$MEM" -gt "$ALERT_MEM" ] && \
  alert "Memory high: ${MEM}% > threshold ${ALERT_MEM}%"

# Disk check
DISK=$(df / | tail -1 | \
  awk '{print $5}' | cut -d'%' -f1)
log "INFO: Disk Usage: ${DISK}%"
[ "$DISK" -gt "$ALERT_DISK" ] && \
  alert "Disk high: ${DISK}% > threshold ${ALERT_DISK}%"

# Load average check
LOAD=$(cat /proc/loadavg | awk '{print $1}')
log "INFO: Load Average: $LOAD"

log "INFO: Status: $STATUS"
log "INFO: ── Health check completed  ──"
EOF

chmod +x health-check.sh
echo "health-check.sh created "