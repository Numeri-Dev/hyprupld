#!/usr/bin/env bash
#==============================================================================
# HyprUpld Installation Script
# Author: PhoenixAceVFX
# License: GPL-2.0
# Description: Installs HyprUpld and related tools to the system
#==============================================================================
# Exit on any error
set -e

#==============================================================================
# Configuration
#==============================================================================
SCRIPTS_DIR="$(realpath "$(dirname "$0")/Compiled")"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"
SOUNDS_DIR="$(realpath "$(dirname "$0")/sounds")"

#==============================================================================
# Terminal Colors
#==============================================================================
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly MAGENTA='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'
readonly BOLD='\033[1m'

#==============================================================================
# Logging Functions
#==============================================================================
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_header() { echo -e "\n${BOLD}${MAGENTA}$1${NC}\n"; }

#==============================================================================
# Utility Functions
#==============================================================================
check_prerequisites() {
    if [ ! -d "$SCRIPTS_DIR" ]; then
        log_error "Scripts directory not found at $SCRIPTS_DIR"
        exit 1
    fi
}

ensure_root_privileges() {
    if [ "$EUID" -ne 0 ]; then
        log_warning "Requesting administrative privileges..."
        if ! sudo -v; then
            log_error "Failed to obtain administrative privileges"
            exit 1
        fi
    fi
}

#==============================================================================
# Installation Functions
#==============================================================================
install_binary() {
    local source_file="$1"
    local dest_name="$2"
    
    # Debug output
    log_info "Processing file: $source_file"
    
    # Validate input
    if [[ -z "$dest_name" || "$dest_name" == "error" ]]; then
        log_error "Invalid destination name: '$dest_name' for source: $source_file"
        return 1
    fi
    
    # Normalize binary name
    dest_name="${dest_name/-x86_64/}"
    dest_name="${dest_name/.AppImage/}"
    
    log_info "Installing: $dest_name"
    
    # Create destination directory if needed
    sudo mkdir -p "$(dirname "$INSTALL_DIR/$dest_name")"
    
    # Install binary with appropriate permissions
    if sudo cp "$source_file" "$INSTALL_DIR/$dest_name" && \
       sudo chmod 755 "$INSTALL_DIR/$dest_name"; then
        log_success "Installed $dest_name"
        return 0
    else
        log_error "Failed to install $dest_name"
        return 1
    fi
}

install_all_binaries() {
    local installed_commands=()
    
    # Debug output
    log_info "Contents of $SCRIPTS_DIR:"
    ls -la "$SCRIPTS_DIR"
    
    for binary in "$SCRIPTS_DIR"/*; do
        if [ -f "$binary" ]; then
            local base_name=$(basename "$binary")
            # Skip hidden files
            [[ "$base_name" == .* ]] && continue
            
            # Check for and remove error AppImages
            if [[ "$base_name" == "error" || "$base_name" == "error.AppImage" ]]; then
                log_warning "Found error AppImage, removing: $binary"
                rm -f "$binary"
                continue
            fi
            
            if install_binary "$binary" "$base_name"; then
                installed_commands+=("${base_name/-x86_64/}")
                installed_commands[-1]="${installed_commands[-1]/.AppImage/}"
            fi
        fi
    done
    
    return_installed_commands "${installed_commands[@]}"
}

return_installed_commands() {
    local -a commands=("$@")
    
    if [ ${#commands[@]} -gt 0 ]; then
        log_header "Installed Commands:"
        for cmd in "${commands[@]}"; do
            echo -e "${CYAN}$cmd${NC}"
        done
    else
        log_warning "No commands were installed"
    fi
}

#==============================================================================
# Main Installation Process
#==============================================================================
function main() {
    log_header "HyprUpld Installation"
    log_info "Source directory: $SCRIPTS_DIR"
    log_info "Target directory: $INSTALL_DIR"
    
    # Kill any existing hyprupld process
    if pgrep -x "hyprupld" > /dev/null; then
        log_warning "Terminating existing hyprupld process..."
        pkill -x "hyprupld"
    fi

    check_prerequisites
    ensure_root_privileges
    install_all_binaries
    
    # Create the installation directories for sounds
    sudo mkdir -p /usr/local/share/hyprupld/sounds

    # Install the sound files from the project sounds directory
    sudo cp "$SOUNDS_DIR"/*.mp3 /usr/local/share/hyprupld/sounds/

    # Set permissions for sound files
    sudo chmod 644 /usr/local/share/hyprupld/sounds/*

    log_header "Installation Complete"
    echo
}

main "$@"
