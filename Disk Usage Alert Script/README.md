Disk Usage Monitoring Script
📝 Overview

This project contains a Bash script that monitors disk usage on a Linux system.
It checks the root (/) filesystem usage and alerts when disk utilization exceeds a defined threshold.

This script is useful for:

System monitoring
DevOps automation
Learning shell scripting
Cron-based health checks

Prerequisites

Before running this script, make sure the following requirements are met:

Linux-based operating system
Ubuntu, Amazon Linux, CentOS, Debian, etc.

Bash shell

Default on most Linux distributions
Core Linux utilities (usually pre-installed):

df
awk
sed
grep

Basic user permission
configure mail in machine 
No root access required for read-only disk checks

(Optional) Cron service

Required only if you want to automate the script

How It Works

Reads disk usage of the root filesystem (/)
Extracts the usage percentage
Compares it with a defined threshold


🔧 Configuration

Modify the threshold value as needed:

THRESHOLD=80

▶ How to Run
chmod +x disk_usage.sh
./disk_usage.sh

Run as a Cron Job (Optional)

To execute the script every 10 minutes:

crontab -e


Add the following line:

*/10 * * * * /path/to/disk_usage.sh >> /var/log/disk_usage.log 2>&1

Sample Output

Normal usage
Disk OK: 45%

High usage
⚠ Disk usage high on server-name: 85%