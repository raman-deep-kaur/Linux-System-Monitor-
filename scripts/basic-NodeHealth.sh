#!/bin/bash

set -x

# ===================================
# Basic System Node Health Monitor
# ===================================

# Disk Usage
df -h

# Memory Usage (human-readbale)
free -h

#Memory Usage (in GB)
free -g

# CPU load averages
uptime

# Number of CPU cores
nproc

# Top 5 Processes by CPU
ps -eo pid,comm,%cpu --sort=-%cpu | head -6

set +x

