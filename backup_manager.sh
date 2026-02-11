#!/bin/bash

#################################################
# Automated Backup Manager
# Professional backup solution with logging
#################################################

# Configuration
BACKUP_DIR="$HOME/backups"
LOG_FILE="$BACKUP_DIR/backup.log"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
MAX_BACKUPS=5  # Keep only last 5 backups

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Logging function
log_message() {
    local level="$1"
    local message="$2"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" >> "$LOG_FILE"
    
    case $level in
        INFO)
            echo -e "${BLUE}ℹ${NC}  $message"
            ;;
        SUCCESS)
            echo -e "${GREEN}✓${NC} $message"
            ;;
        WARNING)
            echo -e "${YELLOW}⚠${NC}  $message"
            ;;
        ERROR)
            echo -e "${RED}✗${NC} $message"
            ;;
    esac
}

# Create backup directory if it doesn't exist
initialize_backup_system() {
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
        log_message "INFO" "Created backup directory: $BACKUP_DIR"
    fi
    
    if [ ! -f "$LOG_FILE" ]; then
        touch "$LOG_FILE"
        log_message "INFO" "Initialized backup log file"
    fi
}

# Backup function
create_backup() {
    local source_dir="$1"
    local backup_name="$2"
    
    if [ ! -d "$source_dir" ]; then
        log_message "ERROR" "Source directory does not exist: $source_dir"
        return 1
    fi
    
    local backup_file="$BACKUP_DIR/${backup_name}_${TIMESTAMP}.tar.gz"
    
    log_message "INFO" "Starting backup of: $source_dir"
    
    if tar -czf "$backup_file" -C "$(dirname "$source_dir")" "$(basename "$source_dir")" 2>/dev/null; then
        local size=$(du -h "$backup_file" | cut -f1)
        log_message "SUCCESS" "Backup created: $backup_file (Size: $size)"
        return 0
    else
        log_message "ERROR" "Failed to create backup of: $source_dir"
        return 1
    fi
}

# Clean old backups (keep only MAX_BACKUPS most recent)
cleanup_old_backups() {
    local backup_count=$(ls -1 "$BACKUP_DIR"/*.tar.gz 2>/dev/null | wc -l)
    
    if [ "$backup_count" -gt "$MAX_BACKUPS" ]; then
        log_message "INFO" "Cleaning up old backups (keeping last $MAX_BACKUPS)"
        
        ls -1t "$BACKUP_DIR"/*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | while read old_backup; do
            rm -f "$old_backup"
            log_message "INFO" "Removed old backup: $(basename "$old_backup")"
        done
    fi
}

# Display backup statistics
show_backup_stats() {
    echo ""
    echo "=========================================="
    echo "   BACKUP SYSTEM STATISTICS"
    echo "=========================================="
    echo ""
    
    local total_backups=$(ls -1 "$BACKUP_DIR"/*.tar.gz 2>/dev/null | wc -l)
    local total_size=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)
    
    echo "📁 Backup Location: $BACKUP_DIR"
    echo "📦 Total Backups: $total_backups"
    echo "💾 Total Size: $total_size"
    echo "📝 Log File: $LOG_FILE"
    echo ""
    
    if [ "$total_backups" -gt 0 ]; then
        echo "Recent Backups:"
        ls -1t "$BACKUP_DIR"/*.tar.gz 2>/dev/null | head -5 | while read backup; do
            local size=$(du -h "$backup" | cut -f1)
            echo "  • $(basename "$backup") - $size"
        done
    else
        echo "  No backups found"
    fi
    
    echo ""
    echo "=========================================="
}

# Main execution
main() {
    echo "=========================================="
    echo "   AUTOMATED BACKUP MANAGER"
    echo "=========================================="
    echo ""
    
    initialize_backup_system
    
    # Example: Backup current directory's scripts folder
    if [ -d "./scripts" ]; then
        create_backup "./scripts" "scripts_backup"
    else
        log_message "WARNING" "Scripts directory not found, creating sample backup"
        # Create a sample backup of current directory
        mkdir -p "./sample_data"
        echo "Sample file created at $(date)" > "./sample_data/sample.txt"
        create_backup "./sample_data" "sample_backup"
        rm -rf "./sample_data"
    fi
    
    # Cleanup old backups
    cleanup_old_backups
    
    # Show statistics
    show_backup_stats
    
    log_message "SUCCESS" "Backup process completed successfully"
    echo ""
    echo -e "${GREEN}✓${NC} Backup completed successfully!"
    echo ""
}

# Run main function
main
