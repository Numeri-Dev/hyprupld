#!/bin/bash
#==============================================================================
# HyprUpld macOS Installation Script
# This script clones and installs the HyprUpld application for macOS
#==============================================================================
# Author: Numeri
# License: GPL-2.0
# Repository: https://github.com/Numeri-Dev/hyprupld
#==============================================================================

set -e  # Exit on any error

# Terminal Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No Color

echo -e "${GREEN}Installing HyprUpld for macOS...${NC}"

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo -e "${RED}Error: This script is only for macOS systems${NC}"
    echo "Please use install.sh for Linux systems"
    exit 1
fi

# Check for required tools
REQUIRED_TOOLS=("git" "convert")
MISSING_TOOLS=()

for tool in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        MISSING_TOOLS+=("$tool")
    fi
done

if [ ${#MISSING_TOOLS[@]} -ne 0 ]; then
    echo -e "${RED}Error: Missing required tools: ${MISSING_TOOLS[*]}${NC}"
    echo -e "${YELLOW}Please install the following:${NC}"
    echo "- git: Use Xcode command line tools (xcode-select --install)"
    echo "- convert: Install ImageMagick using Homebrew (brew install imagemagick)"
    exit 1
fi

# Clone the repository
echo -e "${GREEN}Cloning repository...${NC}"
if ! git clone https://github.com/Numeri-Dev/hyprupld.git; then
    echo -e "${RED}Error: Failed to clone repository${NC}"
    exit 1
fi

# Change to repository directory
cd hyprupld || exit 1

# Make scripts executable
chmod +x compile_macos.sh install_scripts_macos.sh

# Compile the application
echo -e "${GREEN}Compiling application...${NC}"
./compile_macos.sh

# Install the application
echo -e "${GREEN}Installing application...${NC}"
./install_scripts_macos.sh

echo -e "${GREEN}Installation complete!${NC}"

# Provide instructions for first run
echo -e "\n${YELLOW}Installation Notes:${NC}"
echo "1. The application has been installed to either /Applications or ~/Applications"
echo "2. Sound files are in ~/Library/Application Support/HyprUpld/sounds"
echo "3. You may need to right-click the app and select 'Open' for the first run"
echo "4. You might need to allow the app in System Preferences > Security & Privacy"

exit 0
