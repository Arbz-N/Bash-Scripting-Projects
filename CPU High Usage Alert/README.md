CPU Usage Monitoring Script
Overview

This project contains a Bash script that monitors CPU usage on a Linux system.
It checks the current CPU load and triggers an alert when usage exceeds a defined threshold.

This script is ideal for:

Linux system monitoring
DevOps practice
Learning shell scripting
Cron-based CPU health checks

Prerequisites

Before using this script, ensure the following requirements are met:

Linux-based Operating System
Ubuntu, Amazon Linux, CentOS, Debian, etc.

Bash shell

Default shell on most Linux systems
Required system utilities (usually pre-installed):

top
awk
grep
cut

User permissions

No root access required
(Optional) Cron service

Required only if you want to automate execution

How It Works

Uses the top command to read CPU statistics
Extracts CPU usage percentage
Compares usage with a defined threshold

Displays:

Warning message if CPU usage is high
Normal status message otherwise

Configuration

You can adjust the CPU usage threshold:

THRESHOLD=70

How to Run
chmod +x cpu_alert.sh
./cpu_alert.sh

Run as a Cron Job (Optional)
To monitor CPU usage every 5 minutes:

crontab -e

Add:

*/5 * * * * /path/to/cpu_alert.sh >> /var/log/cpu_usage.log 2>&1

Sample Output

Normal CPU usage
CPU normal: 35%


High CPU usage
High CPU usage: 82%