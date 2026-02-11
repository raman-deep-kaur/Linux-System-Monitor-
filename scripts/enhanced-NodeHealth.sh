#!/bin/bash
set -x

# ==============================
# Enhanced Node Health Monitor
# ==============================

#Log file with timestamp
LOGFILE="$HOME/system_health_$(date +%Y%m%d_%H%M%S).log"

# Disk Usage
DISK_USE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
df -h | tee -a "$LOGFILE"
if [ "$DISK_USE" -gt 90 ]; then
     echo "WARNING: Disk usage critical ($DISK_USE%)" | tee -a "$LOGFILE"
fi

# Memory Usage
MEMORY_USED=$(free | awk '/Mem:/ {print $3/$2 * 100.0}')
free -h | tee -a "$LOGFILE"
if (( $(echo "$MEMORY_USED > 80" | bc -l) )); then
     echo "WARNING: Memory usage above 80%! Current: $MEMORY_USED%" | tee -a "$LOGFILE"
fi

# CPU load averages
uptime | tee -a "$LOGFILE"

# Number of CPU cores
nproc | tee -a "$LOGFILE"

# Top 5 Processes by CPU
ps -eo pid,comm,%cpu --sort=-%cpu | head -6 | tee -a "$LOGFILE"

# Recent system errors
journalctl -p 3 -n 5 | tee -a "$LOGFILE"
if [ -f /var/log/syslog ]; then
     grep -i "error" /var/log/syslog | tail -n 5 | tee -a "$LOGFILE"
fi

set +x
