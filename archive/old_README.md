#Linux System Health Monitor

This is a simple Linux system health monitoring script created by **Kitan**, a beginner DevOps enthusiast.

## Description

A collection of bash scripts that provide system health monitoring and automated backup capabilities for Linux systems. Perfect for learning DevOps fundamentals and system administration.

## Features

### Basic Monitor (`monitor.sh`)
- System uptime display
- Disk usage analyis
- Memory usage statistics
- Top CPU-consuming process
- Recent system logs

### Enhanced Monitor (`enhanced-monitor.sh`)
- All basic monitor features
- Automatic logging with timestamps
- Disk and memory usage alerts (configurable thresholds)
- Formatted, colorized output
- Top 5 memory-intensive processes
- Log file: `system_monitor.log`

### Backup Script (`backup.sh`)
- Automated backup of monitoring scripts
- Timestamoed backup files
- Compressed tar.gz archives
- Creates backup directory automatically 

## Installation & Usage

1. **Clone the repository:**
```bash
   git clone [https://github.com/kitancodes/linux-system-monitor.git]
   cd linux-system-monitor

2.Make scripts executable 
chmod +x monitor.sh enhanced-monitor.sh backup.sh

3. Run the scripts
# Basic monitoring
./monitor.sh

# Enhanved monitoring with logging
./enhanced-monitor.sh

# Create backup
./backup.sh

File Structure
linux-system-monitor/
|-- README.md
|-- monitor.sh                            # Basic system monitor
|-- enhanced-monitor.sh                   # Advanced monitor with logging
|-- backup.sh                             # Backup script
`-- system_monitor.log                    # Generated log file

Sample Output
----- SYSTEM HEALTH MONITOR -----
Date: Fri Sep 27 20:19:20 WAT 2025
Uptime: 2 hours, 15 minutes

----- DISK USAGE -----
/dev/sda1: 45% used (8.26/18G)

----- MEMORY USAGE -----
Memory: 3.26/8.0G (40% used)

## Learning Goals
1. Practice Linux command-line skills.
2. Learn Bash scripting basics.
3. Implement Git version control workflows. 
4. Understand system monitoring concepts.
5. Learn DevOps automation principles.

## Contributing
This is a learning project, but feedback suggestions are welcome! Feel free to:
1. Open issues for bugs or improvements
2. Submit pull requests
3. Share your monitoring ideas 
 
## Notes
1. Designed for educational purposes.
2. Tested on Ubuntu/Debian systems
3. Requires basic Linux utilities (df,free,ps,tail)

*Created as part of my DevOps learning journey*
