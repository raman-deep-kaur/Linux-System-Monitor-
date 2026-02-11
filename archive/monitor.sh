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

