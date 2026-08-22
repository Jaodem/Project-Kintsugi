#!/bin/bash

# ==============================================================================
# Project Kintsugi - Automated Data Backup
# ==============================================================================

# Fail fast
set -euo pipefail

readonly C_INFO='\033[0;32m'
readonly C_ERR='\033[0;31m'
readonly C_NONE='\033[0m'

log_info() { printf "${C_INFO}[INFO]${C_NONE} %s\n" "$1"; }
log_err() { printf "${C_ERR}[ERROR]${C_NONE} %s\n" "$1" >&2; }

# Verify rclone is installed
if ! command -v rclone >/dev/null 2>&1; then
    log_err "rclone is not installed. Run 'sudo dnf5 install rclone'."
    exit 1
fi

main() {
    log_info "Starting Project Kintsugi backup routine..."

    # Backup Important Documents
    log_info "Syncing ~/Documents/Important/ to MEGA..."
    rclone sync -P "$HOME/Documents/Important/" mega:Important/

    log_info "Backup completed successfully."
}

main "$@"