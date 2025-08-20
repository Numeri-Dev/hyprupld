#!/usr/bin/env bash
#==============================================================================
# HyprUpld macOS Installation Script
# Author: Numeri
# License: GPL-2.0
# Description: Installs HyprUpld and related tools to macOS system
#==============================================================================
# Exit on any error
set -e

#==============================================================================
# Configuration
#==============================================================================
SCRIPTS_DIR="$(realpath "$(dirname "$0")/Compiled")"
SOUNDS_DIR="$(realpath "$(dirname "$0")/sounds")"

# Try system Applications first, fall back to user Applications
if [ -w "/Applications" ]; then
    INSTALL_DIR="/Applications"
    echo "Installing to system Applications directory"
else
    INSTALL_DIR="$HOME/Applications"
    echo "Installing to user Applications directory"
    # Create user Applications directory if it doesn't exist
    mkdir -p "$INSTALL_DIR"
fi

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
# Helper Functions
#==============================================================================
print_status() {
    echo -e "${BLUE}==>${NC} ${BOLD}$1${NC}"
}

print_error() {
    echo -e "${RED}Error:${NC} $1" >&2
}

print_success() {
    echo -e "${GREEN}Success:${NC} $1"
}

#==============================================================================
# Installation
#==============================================================================
main() {
    print_status "Starting HyprUpld installation for macOS..."

    # Check if Compiled directory exists and contains .app bundles
    if [ ! -d "$SCRIPTS_DIR" ] || ! ls "$SCRIPTS_DIR"/*.app >/dev/null 2>&1; then
        print_error "No .app bundles found in $SCRIPTS_DIR"
        print_error "Please run compile_macos.sh first to create the .app bundles"
        exit 1
    fi

    # Check if sounds directory exists
    if [ ! -d "$SOUNDS_DIR" ]; then
        print_error "Sounds directory not found at $SOUNDS_DIR"
        exit 1
    fi

    # Install each .app bundle
    for app in "$SCRIPTS_DIR"/*.app; do
        app_name=$(basename "$app")
        target_path="$INSTALL_DIR/$app_name"
        
        print_status "Installing $app_name..."
        
        # Remove existing installation if present
        if [ -d "$target_path" ]; then
            print_status "Removing existing installation..."
            rm -rf "$target_path"
        fi

        # Copy the .app bundle
        if cp -R "$app" "$target_path"; then
            print_success "Installed $app_name to $target_path"
        else
            print_error "Failed to install $app_name"
            exit 1
        fi
    done

    # Create and populate sounds directory
    SOUNDS_INSTALL_DIR="$HOME/Library/Application Support/HyprUpld/sounds"
    print_status "Installing sound files..."
    
    mkdir -p "$SOUNDS_INSTALL_DIR"
    if cp -R "$SOUNDS_DIR"/* "$SOUNDS_INSTALL_DIR/"; then
        print_success "Installed sound files to $SOUNDS_INSTALL_DIR"
    else
        print_error "Failed to install sound files"
        exit 1
    fi

    # Create symbolic link for command-line access
    if [ -w "/usr/local/bin" ]; then
        SYMLINK_DIR="/usr/local/bin"
    else
        SYMLINK_DIR="$HOME/bin"
        mkdir -p "$SYMLINK_DIR"
        # Add ~/bin to PATH if not already there
        if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
            echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.zshrc"
            echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bash_profile"
        fi
    fi

    # Create the symbolic link
    MAIN_APP="$INSTALL_DIR/hyprupld.app"
    if [ -d "$MAIN_APP" ]; then
        print_status "Creating command-line symlink..."
        ln -sf "$MAIN_APP/Contents/MacOS/hyprupld" "$SYMLINK_DIR/hyprupld"
        print_success "Created command-line symlink at $SYMLINK_DIR/hyprupld"
    fi

    print_success "HyprUpld installation completed successfully!"
    echo -e "${YELLOW}Note: Applications have been installed to $INSTALL_DIR${NC}"
    echo -e "${YELLOW}Sound files are located at $SOUNDS_INSTALL_DIR${NC}"
    echo -e "${YELLOW}Command 'hyprupld' is now available in terminal${NC}"
    
    if [ "$SYMLINK_DIR" = "$HOME/bin" ]; then
        echo -e "${YELLOW}Note: Please restart your terminal or run 'source ~/.zshrc' (or ~/.bash_profile) to use the command${NC}"
    fi
}

# Run the installation
main
