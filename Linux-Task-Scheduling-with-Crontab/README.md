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

Project Structure

    CrontabLab/
    │
    ├── backup.sh               # Daily /etc/ backup (7-day retention)
    ├── cleanup-logs.sh         # Weekly log cleanup (30-day retention)
    ├── health-check.sh         # CPU / Memory / Disk threshold monitoring
    │
    └── README.md

Prerequisites

Requirement                Check
Linux                     (Ubuntu/Debian)Any machine
cron service              sudo systemctl status cron → active


# Install cron if missing
sudo apt-get install -y cron
sudo systemctl enable cron
sudo systemctl start cron

Architecture

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

