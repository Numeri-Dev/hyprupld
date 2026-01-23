#!/bin/bash
#==============================================================================
# HyprUpld Installation Script
# This script clones and installs the HyprUpld application
#==============================================================================
# Author: LoonieLoonz
# License: GPL-2.0
# Repository: https://github.com/LoonieLoonz/hyprupld
#==============================================================================

git clone https://github.com/LoonieLoonz/hyprupld.git
cd hyprupld
makepkg -si
