# Linux Task Scheduling with Crontab
 
    Overview
    This is a hands-on project that demonstrates Linux task scheduling using Crontab. 
    It covers writing production-grade Bash scripts for system backup, log cleanup, and health monitoring — 
    then scheduling them via cron with rate-based, daily, weekly, weekday, and @reboot triggers.
    Key highlights:
    
    Three Bash scripts with proper logging (tee -a), full PATH declaration, and error handling
    Health check with CPU / Memory / Disk thresholds and ALERT status
    Backup with automatic 7-day retention cleanup
    Log cleanup with disk space before/after reporting
    Quick 1-minute cron test method included
    Full crontab pattern reference sheet



## Project Structure:

    CrontabLab/
    │
    ├── backup.sh               # Daily /etc/ backup (7-day retention)
    ├── cleanup-logs.sh         # Weekly log cleanup (30-day retention)
    ├── health-check.sh         # CPU / Memory / Disk threshold monitoring
    │
    └── README.md

## Prerequisites:

    Requirement                Check
    Linux                     (Ubuntu/Debian)Any machine
    cron service              sudo systemctl status cron → active


    # Install cron if missing
    sudo apt-get install -y cron
    sudo systemctl enable cron
    sudo systemctl start cron

## Architecture:

    Cron Daemon (/var/spool/cron/crontabs/)
      │
      ├── */15 * * * *  → health-check.sh
      │                   ├── CPU check    (threshold: 80%)
      │                   ├── Memory check (threshold: 85%)
      │                   └── Disk check   (threshold: 90%)
      │
      ├── 0 3 * * *     → backup.sh
      │                   ├── tar /etc/ → /tmp/backups/
      │                   └── delete files older than 7 days
      │
      ├── 0 0 * * 0     → cleanup-logs.sh
      │                   ├── find /var/log/*.log older than 30 days
      │                   └── report disk space freed
      │
      ├── 0 9 * * 1-5   → health-check.sh >> daily-report.log
      │
      └── @reboot       → health-check.sh
    
      Logs: ~/automation-lab/logs/
      ├── health.log
      ├── backup.log
      └── cleanup.log

### Task 1 — Setup Scripts:

    mkdir -p ~/automation-lab/logs
    cd ~/automation-lab

    # Copy scripts here
    chmod +x backup.sh cleanup-logs.sh health-check.sh
    Test Scripts Manually
    Always test before scheduling with crontab.

    echo "=== Backup Script ==="
    bash backup.sh
    # [2026-03-18 10:00:01] INFO: Backup started
    # [2026-03-18 10:00:02] INFO: Backup successful 

    echo "=== Health Check ==="
    bash health-check.sh
    # [2026-03-18 10:00:01] INFO: CPU Usage: 12%
    # [2026-03-18 10:00:01] INFO: Memory Usage: 45%
    # [2026-03-18 10:00:01] INFO: Disk Usage: 38%
    # [2026-03-18 10:00:01] INFO: Status: OK
    # [2026-03-18 10:00:01] INFO: Health check completed 

    echo "=== Log Cleanup ==="
    bash cleanup-logs.sh

    # View logs
    cat ~/automation-lab/logs/health.log

### Task 2 — Configure Crontab:

    bash# View current crontab
    crontab -l
    
    # Edit
    crontab -e
    Add these entries:
    # ============================================
    # AUTOMATION-LAB CRONTAB
    # ============================================
    
    # Every 15 minutes — health check
    */15 * * * * /root/automation-lab/health-check.sh
    
    # Daily at 3 AM — backup
    0 3 * * * /root/automation-lab/backup.sh
    
    # Every Sunday midnight — log cleanup
    0 0 * * 0 /root/automation-lab/cleanup-logs.sh
    
    # Weekdays at 9 AM — daily report
    0 9 * * 1-5 /root/automation-lab/health-check.sh >> /root/automation-lab/logs/daily-report.log 2>&1
    
    # On every machine reboot
    @reboot /root/automation-lab/health-check.sh

    Verify
    
    crontab -l
    # All entries visible 
    
    sudo systemctl status cron
    # Active: active (running) 
    
    # Watch cron execution in real time
    sudo tail -f /var/log/syslog | grep CRON
    # Ya:
    sudo journalctl -u cron -f

### Task 3 — Quick Test (1 Minute):

    
    bashNEXT_MIN=$(date -d "+1 minute" '+%M')
    CURR_HOUR=$(date '+%H')
    
    # Add test entry
    (crontab -l; \
      echo "$NEXT_MIN $CURR_HOUR * * * echo 'CRON TEST OK' >> /tmp/cron-test.log") \
      | crontab -
    
    echo "Waiting 70 seconds..."
    sleep 70
    
    cat /tmp/cron-test.log
    # CRON TEST OK 
    
    # Remove test entry
    crontab -l | grep -v "cron-test" | crontab -
    echo "Test entry removed "


### Crontab Syntax Reference:

        ┌───────────── minute      (0–59)
        │ ┌─────────── hour        (0–23)
        │ │ ┌───────── day-of-month (1–31)
        │ │ │ ┌─────── month       (1–12)
        │ │ │ │ ┌───── day-of-week  (0–7, 0 and 7 = Sunday)
        │ │ │ │ │
        * * * * *  command
    
    See crontab-reference.txt for the full pattern cheat sheet.

### Cleanup:

    bash# Remove crontab entries
    crontab -l | grep -v "automation-lab" | crontab -
    
    # Delete files
    rm -rf ~/automation-lab/
    rm -f /tmp/backups/etc-backup-*.tar.gz
    rm -f /tmp/cron-test.log

### License:


    This project is licensed under the MIT License.
