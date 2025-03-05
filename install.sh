#!/bin/bash

# Clone the repository
git clone https://github.com/PhoenixAceVFX/hyprupld.git
cd hyprupld || { echo "Failed to enter repo directory"; exit 1; }

# Make sure scripts are executable
chmod +x compile.sh install_scripts.sh

# Run the scripts
./compile.sh && ./install_scripts.sh
