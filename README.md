
#  Linux System Monitor & DevOps Automation

![CI/CD Status](https://github.com/Kitancodes/linux-system-monitor/actions/workflows/bash-ci.yml/badge.svg)

A collection of DevOps projects showcasing system monitoring, backup automation, and CI/CD pipeline implementation. Built as part of my DevOps learning journey.

##  What's in This Repository

This repo contains two main projects that demonstrate different DevOps skills:

### 1️⃣ System Health Monitoring Scripts (`scripts/` folder)
Real-time Linux system health monitoring with basic and enhanced versions.

### 2️ Backup Automation with CI/CD (root level)
Automated backup system with professional testing pipeline and continuous integration.

---

##  Project 1: System Health Monitoring

### Overview
Scripts that monitor Linux system health including disk usage, memory, CPU load, and processes.

### What's Available

#### Basic Monitor (`scripts/basic-NodeHealth.sh`)
- Disk usage monitoring
- Memory usage tracking
- CPU load display
- Top 5 processes by CPU usage

#### Enhanced Monitor (`scripts/enhanced-NodeHealth.sh`)
- Everything from Basic Monitor
- Timestamped logging to file
- Alert system (warns if disk >90% or memory >80%)
- CPU core count display
- Recent system error reporting

### How to Use

**Run Basic Monitor:**
```bash
cd scripts
chmod +x basic-NodeHealth.sh
./basic-NodeHealth.sh
```

**Run Enhanced Monitor:**
```bash
cd scripts
chmod +x enhanced-NodeHealth.sh
./enhanced-NodeHealth.sh

# Check the generated log file
cat ~/system_health_*.log
```

### What I Learned
- System monitoring fundamentals
- Bash scripting for data collection
- Threshold-based alerting
- Log file management

---

##  Project 2: Backup Automation with CI/CD

### Overview
An automated backup system with intelligent rotation, comprehensive logging, and a full CI/CD testing pipeline.

### Features
- Automated backup creation with timestamps
- Smart backup rotation (keeps last 5 backups)
- Comprehensive logging system
- Error handling and recovery
- Automated testing (13 test cases)
- CI/CD pipeline with GitHub Actions

### How to Use

**Run the Backup Manager:**
```bash
chmod +x backup_manager.sh
./backup_manager.sh
```

**What happens:**
- Creates `~/backups` directory
- Makes compressed backup with timestamp
- Shows statistics (total backups, sizes)
- Auto-cleans old backups

**Run the Tests:**
```bash
chmod +x tests.sh
./tests.sh
```

**What it tests:**
- Script exists and has valid syntax
- Backup files are created properly
- Log files work correctly
- Multiple executions don't break anything
- Exit codes are correct

### The CI/CD Pipeline

Every time I push code, three automated jobs run:

1. **Lint** - ShellCheck analyzes all scripts for errors and bad practices
2. **Test** - Runs comprehensive test suite (13 test cases)
3. **Deploy** - Verifies production readiness

View the pipeline runs in the **Actions** tab on GitHub.

### What I Learned
- Writing automation scripts with proper error handling
- Building comprehensive test suites
- CI/CD pipeline design and implementation
- YAML configuration for GitHub Actions
- DevOps workflow best practices

---

##  Repository Structure

```
linux-system-monitor/
├── .github/
│   └── workflows/
│       └── bash-ci.yml          # CI/CD pipeline configuration
├── archive/                      # Old versions of monitoring scripts
│   ├── backup.sh
│   ├── enhanced-monitor.sh
│   └── monitor.sh
├── scripts/                      # Active system monitoring scripts
│   ├── basic-NodeHealth.sh      # Basic system health monitor
│   └── enhanced-NodeHealth.sh   # Enhanced monitor with logging
├── backup_manager.sh            # Backup automation system
├── tests.sh                     # Comprehensive test suite
└── README.md                    # This file
```

---

##  Technologies Used

- **Bash** - Shell scripting and automation
- **GitHub Actions** - CI/CD pipeline automation
- **ShellCheck** - Static analysis for bash scripts
- **YAML** - Pipeline configuration
- **Git** - Version control

---

##  My Learning Journey

### Phase 1: System Monitoring
Started with basic system health monitoring scripts to understand:
- How to collect system metrics
- Bash scripting fundamentals
- Log file management
- Alert systems

### Phase 2: Backup Automation
Built an automated backup system focusing on:
- Error handling and recovery
- Intelligent data rotation
- Professional logging practices

### Phase 3: CI/CD Integration (Current)
Implemented automated testing and deployment pipelines:
- Writing comprehensive test suites
- GitHub Actions workflows
- Automated quality checks
- DevOps best practices

### What I'm Learning Now
- Bash scripting fundamentals (variables, conditionals, loops, functions)
- YAML syntax for pipeline configuration
- Test-driven development practices
- Error detection and debugging techniques

### What's Next
- Advanced automation concepts
- Monitoring and deployment integration
- Docker containerization
- Infrastructure as Code (Terraform)

---

##  Why This Matters

This repository demonstrates:
- **Progression** from basic scripts to professional DevOps workflows
- **Real projects** not just tutorials
- **Testing mindset** with automated quality checks
- **Continuous learning** and skill development

---

##  Future Plans

### For Monitoring Scripts:
- Schedule with cron for automatic monitoring
- Add email/Slack notifications
- Create monitoring dashboard

### For Backup System:
- Remote storage integration (cloud backup)
- Backup restoration functionality
- Incremental backup support

### For CI/CD:
- Multi-environment deployments
- Advanced testing strategies
- Container integration

---

##  About Me

**Kitan**
- GitHub: [@Kitancodes](https://github.com/Kitancodes)
- Currently learning: DevOps Engineering
- Location: Lagos, Nigeria
- Focus: Building real projects while learning fundamentals

---

##  Notes

- Old script versions are in `archive/` folder for reference
- Active monitoring scripts are in `scripts/` folder
- Backup automation and CI/CD files are in the root directory
- All scripts are tested and functional

---

**Building in public. Learning by doing.** 
