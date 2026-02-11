#!/bin/bash

# Test suite for Backup Manager
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

TESTS_PASSED=0
TESTS_FAILED=0
BACKUP_DIR="$HOME/backups"

# Test helper functions
assert_equals() {
    local expected="$1"
    local actual="$2"
    local test_name="$3"
    
    if [ "$expected" = "$actual" ]; then
        echo -e "${GREEN}v${NC} PASS: $test_name"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}x${NC} FAIL: $test_name"
        echo "  Expected: $expected"
        echo "  Got: $actual"
        ((TESTS_FAILED++))
    fi
}

assert_contains() {
    local substring="$1"
    local string="$2"
    local test_name="$3"
    
    if [[ "$string" == *"$substring"* ]]; then
        echo -e "${GREEN}v${NC} PASS: $test_name"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}x${NC} FAIL: $test_name"
        echo "  Expected output to contain: '$substring'"
        ((TESTS_FAILED++))
    fi
}

assert_file_exists() {
    local filename="$1"
    local test_name="$2"
    
    if [ -f "$filename" ]; then
        echo -e "${GREEN}v${NC} PASS: $test_name"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}x${NC} FAIL: $test_name"
        echo "  File '$filename' does not exist"
        ((TESTS_FAILED++))
    fi
}

assert_dir_exists() {
    local dirname="$1"
    local test_name="$2"
    
    if [ -d "$dirname" ]; then
        echo -e "${GREEN}v${NC} PASS: $test_name"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}x${NC} FAIL: $test_name"
        echo "  Directory '$dirname' does not exist"
        ((TESTS_FAILED++))
    fi
}

assert_exit_code() {
    local expected="$1"
    local actual="$2"
    local test_name="$3"
    
    if [ "$expected" -eq "$actual" ]; then
        echo -e "${GREEN}v${NC} PASS: $test_name"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}x${NC} FAIL: $test_name"
        echo "  Expected exit code: $expected"
        echo "  Got exit code: $actual"
        ((TESTS_FAILED++))
    fi
}

# Cleanup function
cleanup_test_environment() {
    rm -rf "$BACKUP_DIR" 2>/dev/null
    rm -rf "./sample_data" 2>/dev/null
}

echo "=========================================="
echo "   BACKUP MANAGER - TEST SUITE"
echo "=========================================="
echo ""

# Clean up any previous test artifacts
cleanup_test_environment

# Test 1: Script exists
assert_file_exists "backup_manager.sh" "backup_manager.sh exists"

# Test 2: Script has valid bash syntax
if [ -f "backup_manager.sh" ]; then
    bash -n backup_manager.sh 2>/dev/null
    assert_exit_code 0 $? "Script has valid bash syntax"
fi

# Test 3: Script is executable or can be run
if [ -f "backup_manager.sh" ]; then
    chmod +x backup_manager.sh 2>/dev/null
    output=$(bash backup_manager.sh 2>&1)
    exit_code=$?
    
    # Test 4: Script runs successfully
    assert_exit_code 0 $exit_code "Script executes without errors"
    
    # Test 5: Check for required output sections
    assert_contains "AUTOMATED BACKUP MANAGER" "$output" "Script displays header"
    assert_contains "BACKUP SYSTEM STATISTICS" "$output" "Script shows statistics"
    assert_contains "Backup completed successfully" "$output" "Script confirms completion"
    
    # Test 6: Backup directory is created
    assert_dir_exists "$BACKUP_DIR" "Backup directory is created"
    
    # Test 7: Log file is created
    assert_file_exists "$BACKUP_DIR/backup.log" "Log file is created"
    
    # Test 8: Backup files are created
    backup_count=$(ls -1 "$BACKUP_DIR"/*.tar.gz 2>/dev/null | wc -l)
    if [ "$backup_count" -gt 0 ]; then
        echo -e "${GREEN}v${NC} PASS: Backup files are created ($backup_count found)"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}x${NC} FAIL: No backup files created"
        ((TESTS_FAILED++))
    fi
    
    # Test 9: Log file contains entries
    if [ -f "$BACKUP_DIR/backup.log" ]; then
        log_lines=$(wc -l < "$BACKUP_DIR/backup.log")
        if [ "$log_lines" -gt 0 ]; then
            echo -e "${GREEN}v${NC} PASS: Log file contains entries ($log_lines lines)"
            ((TESTS_PASSED++))
        else
            echo -e "${RED}x${NC} FAIL: Log file is empty"
            ((TESTS_FAILED++))
        fi
    fi
    
    # Test 10: Log file has proper format
    if [ -f "$BACKUP_DIR/backup.log" ]; then
        log_content=$(cat "$BACKUP_DIR/backup.log")
        assert_contains "[INFO]" "$log_content" "Log file has INFO entries"
        assert_contains "[SUCCESS]" "$log_content" "Log file has SUCCESS entries"
    fi
    
    # Test 11: Run script twice to test cleanup functionality
    echo ""
    echo -e "${BLUE}ℹ${NC}  Running backup script again to test multiple executions..."
    bash backup_manager.sh > /dev/null 2>&1
    exit_code=$?
    assert_exit_code 0 $exit_code "Script handles multiple executions"
    
else
    echo -e "${YELLOW}!${NC} SKIP: Remaining tests (backup_manager.sh not found)"
    ((TESTS_FAILED+=10))
fi

# Cleanup test environment
cleanup_test_environment

echo ""
echo "=========================================="
echo "   TEST RESULTS"
echo "=========================================="
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"
echo "=========================================="

# Exit with error if any tests failed
if [ $TESTS_FAILED -gt 0 ]; then
    exit 1
else
    exit 0
fi
