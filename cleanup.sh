#!/usr/bin/env bash
#==============================================================================
# HyprUpld Cleanup Script
# This script removes HyprUpld and its components from the system
#==============================================================================
# Author: PhoenixAceVFX
# License: GPL-2.0
# Repository: https://github.com/PhoenixAceVFX/hyprupld
#==============================================================================

set -e  # Exit on any error

# Terminal Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'  # No Color

# Function to print status messages
print_status() {
    echo -e "${BLUE}==>${NC} ${BOLD}$1${NC}"
}

print_error() {
    echo -e "${RED}Error:${NC} $1" >&2
}

print_success() {
    echo -e "${GREEN}Success:${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}Warning:${NC} $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect OS
detect_os() {
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "macos"
    else
        echo "linux"
    fi
}

# Function to remove files with confirmation
remove_file() {
    local file="$1"
    if [ -e "$file" ]; then
        if rm -rf "$file"; then
            print_success "Removed $file"
        else
            print_error "Failed to remove $file"
            return 1
        fi
    fi
}

# Main cleanup function
main() {
    print_status "Starting HyprUpld cleanup..."
    
    # Detect OS
    OS=$(detect_os)
    
    # Kill any running hyprupld processes
    if pgrep -x "hyprupld" > /dev/null; then
        print_warning "Terminating running hyprupld processes..."
        pkill -x "hyprupld" || true
    fi
    
    # Remove binary files
    if [ "$OS" = "macos" ]; then
        # macOS specific cleanup
        print_status "Removing macOS application bundles..."
        remove_file "/Applications/hyprupld.app"
        remove_file "$HOME/Applications/hyprupld.app"
        
        # Remove command line symlink
        if [ -L "/usr/local/bin/hyprupld" ]; then
            remove_file "/usr/local/bin/hyprupld"
        fi
        if [ -L "$HOME/bin/hyprupld" ]; then
            remove_file "$HOME/bin/hyprupld"
        fi
        
        # Remove sound files
        remove_file "$HOME/Library/Application Support/HyprUpld"
    else
        # Linux specific cleanup
        print_status "Removing Linux binaries..."
        remove_file "/usr/local/bin/hyprupld"
        remove_file "/usr/local/share/hyprupld"
    fi
    
    # Ask about config directory
    if [ -d "$HOME/.config/hyprupld" ]; then
        echo -e "\n${YELLOW}Found configuration directory at $HOME/.config/hyprupld${NC}"
        read -p "Do you want to keep your configuration files? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Removing configuration directory..."
            remove_file "$HOME/.config/hyprupld"
        else
            print_success "Configuration directory preserved at $HOME/.config/hyprupld"
        fi
    fi
    
    # Remove source directory if it exists in current location
    if [ -d "hyprupld" ]; then
        read -p "Do you want to remove the source directory? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_status "Removing source directory..."
            remove_file "hyprupld"
        fi
    fi

    # Remove default repository location
    print_status "Checking default repository location..."
    if [ -d "$HOME/hyprupld" ]; then
        read -p "Do you want to remove the default repository directory at $HOME/hyprupld? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_status "Removing default repository directory..."
            remove_file "$HOME/hyprupld"
        fi
    fi

    # Remove any remaining symlinks in PATH
    print_status "Checking for any remaining symlinks..."
    for dir in $(echo $PATH | tr ':' ' '); do
        if [ -L "$dir/hyprupld" ]; then
            print_status "Found symlink at $dir/hyprupld"
            read -p "Do you want to remove this symlink? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                remove_file "$dir/hyprupld"
            fi
        fi
    done

    # Remove sound files
    print_status "Checking for sound files..."
    if [ "$OS" = "macos" ]; then
        SOUNDS_DIR="$HOME/Library/Application Support/HyprUpld/sounds"
    else
        SOUNDS_DIR="/usr/local/share/hyprupld/sounds"
    fi

    if [ -d "$SOUNDS_DIR" ]; then
        read -p "Do you want to remove the sound files at $SOUNDS_DIR? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_status "Removing sound files..."
            remove_file "$SOUNDS_DIR"
        fi
    fi
    
    print_success "HyprUpld cleanup completed!"
    echo -e "\n${YELLOW}Note: If you installed HyprUpld using a package manager, you may need to remove it using that package manager.${NC}"
    echo -e "\n${YELLOW}If you did not run the install in the default directory for your shell you will need to clean that manually.${NC}"
    echo -e "\n${YELLOW}We do not keep track of where the repo was cloned, We only assume the default location.${NC}"
}

# Run the cleanup
main "$@" 