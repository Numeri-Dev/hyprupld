#!/bin/bash
#==============================================================================
# HyprUpld Installation Script
# This script clones and installs the HyprUpld application
#==============================================================================
# Author: PhoenixAceVFX
# License: GPL-2.0
# Repository: https://github.com/PhoenixAceVFX/hyprupld
#==============================================================================

set -e  # Exit on any error

echo "Installing HyprUpld..."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed"
    exit 1
fi

# Clone the repository
echo "Cloning repository..."
if ! git clone https://github.com/PhoenixAceVFX/hyprupld.git; then
    echo "Error: Failed to clone repository"
    exit 1
fi

# Change to repository directory
if ! cd hyprupld; then
    echo "Error: Failed to enter repository directory"
    exit 1
fi

# Make scripts executable
echo "Setting up installation scripts..."
chmod +x compile.sh install_scripts.sh

# Run installation scripts
echo "Running installation scripts..."
if ! ./compile.sh; then
    echo "Error: Compilation failed"
    exit 1
fi

if ! ./install_scripts.sh; then
    echo "Error: Installation failed"
    exit 1
fi

echo "Installation completed successfully!"
