#/bin/bash
#==============================
#Simple Linux System Health Monitor
#==============================
# 1. Print header with date
echo "=============================="
echo " System Health Report - $(date) "
echo "=============================="
# 2. Uptime
echo -e "\n--- Uptime ---"
uptime
# 3. Disk Usage
echo -e "\n--- Disk Usage ---"
df -h
# 4. Memory Usage
echo -e "\n--- Memory Usage ---"
free -m
# 5. Top 5 Processes by CPU Usage
echo -e "\n--- Top 5 Processes (CPU) ---"
if ps -eo pid,comm,%cpu ---sort=-%cpu 2>/dev/null 2>&1; then
     ps -eo pid,comm,%cpu ---sort=-%cpu | head -n 6
else 
     top -b -n 1 | head -n 12
fi 
# 6. Last 10 log entries from syslog
echo -e "\n---Recent Logs (var/log/syslog or /var/log/messages) ---"
if [ -f /var/log/syslog ]; then
    tail -n 5 /var/log/syslog
elif [ -f /var/log/messages ]; then
    tail -n 5 /var/log/messages 
else 
     echo "No system log file found."
fi
tail -n 10 /var/log/syslog
echo -e "\nReport finished at: $(date)"
echo "=============================="
#!/bin/bash
# Enhanced System Health Monitor
# Log file with timestamp
LOGFILE="/home/$USER/system_health_$(date +%Y%m%d_%H%M%S).log"
echo "===== System Health Report =====" | tee -a $LOGFILE
echo "Generated on: $(date)" | tee -a $LOGFILE
echo "==============================" | tee -a $LOGFILE
echo -e "\nDisk Usage:" | tee -a $LOGFILE
df -h | tee -a $LOGFILE
echo -e "\nMemory Usage:" | tee -a $LOGFILE
free -h | tee -a $LOGFILE
# Check memory usage threshold (example: 80%)
MEMORY_USED=$(free | awk '/Mem:/ {print $3/$2 * 100.0}')
if (( ${MEMOERY_USED%} > 80 )); then
echo " WARNING: Memory usage above 80%!" | tee -a $LOGFILE
fi
echo -e "\nCPU Load:" |tee -a $LOGILE
uptime | tee -a $LOGFILE
echo -e "\nTop 5 processes by memory:" | tee -a $LOGFILE
ps -ep pid,ppid,cmd,%mem,%cpu --sort=-%mem |head -6 |tee -a $LOGFILE
echo -e "\nRecent system errors:" |tee -a $LOGFILE
journalctl -p 3 -n 10 | tee -a $LOGFILE
grep -i "error" /var/log/syslog | tail -n 10 | tee -a $LOGFILE
