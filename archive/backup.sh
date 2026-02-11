#!/bin/bash
SOURCE_DIR="/home/kitan/linux-system-monitor"
BACKUP_DIR="/home/kitan/backups"

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
tar -czf "$BACKUP_DIR/system-monitor-backup-$TIMESTAMP.tar.gz" -C "$SOURCE_DIR" .

echo "Backup created at: $BACKUP_DIR/system-monitor-backup-$TIMESTAMP.tar.gz"

