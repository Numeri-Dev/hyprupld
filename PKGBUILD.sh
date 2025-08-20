#!/bin/bash
#==============================================================================
# HyprUpld Installation Script
# This script clones and installs the HyprUpld application
#==============================================================================
# Author: Numeri
# License: GPL-2.0
# Repository: https://github.com/Numeri-Dev/hyprupld
#==============================================================================

git clone https://github.com/Numeri-Dev/hyprupld.git
cd hyprupld
makepkg -si
