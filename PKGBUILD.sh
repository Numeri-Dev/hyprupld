#!/bin/bash
#==============================================================================
# HyprUpld Installation Script
# This script clones and installs the HyprUpld application
#==============================================================================
# Author: PhoenixAceVFX
# License: GPL-2.0
# Repository: https://github.com/PhoenixAceVFX/hyprupld
#==============================================================================

git clone https://github.com/PhoenixAceVFX/hyprupld.git
cd hyprupld
makepkg -si
