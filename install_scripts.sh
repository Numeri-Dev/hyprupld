#!/bin/bash -e

# ░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓████████▓▒░▒▓███████▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░       ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░      ░▒▓██████▓▒░  ░▒▓█▓▒▒▓█▓▒░░▒▓██████▓▒░  ░▒▓██████▓▒░
# ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░        ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓████████▓▒░  ░▒▓██▓▒░  ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░      ░▒▓███████▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓████████▓▒░░▒▓██████▓▒░░▒▓███████▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░      ░▒▓████████▓▒░▒▓███████▓▒░
# Script by PhoenixAceVFX
# Licensed under GPL-2.0

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to print colored and formatted messages
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "\n${BOLD}${MAGENTA}$1${NC}\n"
}

# Directory containing the AppImage files
SCRIPTS_DIR="$(realpath "$(dirname "$0")/Compiled")"

# Directory where we'll create the symbolic links
# Using ~/.local/bin which is commonly in PATH and doesn't require sudo
INSTALL_DIR="$HOME/.local/bin"

print_header "HyprUpld Installation Script"
print_info "Script directory: $SCRIPTS_DIR"
print_info "Installation directory: $INSTALL_DIR"

# Create the install directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    print_info "Creating installation directory $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
    print_success "Directory created successfully."
else
    print_info "Installation directory already exists."
fi

# Check if the Scripts directory exists
if [ ! -d "$SCRIPTS_DIR" ]; then
    print_error "Scripts directory not found at $SCRIPTS_DIR"
    exit 1
fi

# Function to create a symbolic link with a simplified name
create_link() {
    local source="$1"
    local target_name="$2"
    local target="$INSTALL_DIR/$target_name"
    
    print_info "Processing ${CYAN}$(basename "$source")${NC}..."
    
    # Make the AppImage executable if it's not already
    if [ ! -x "$source" ]; then
        print_info "Making executable: $source"
        chmod +x "$source"
    else
        print_info "File is already executable."
    fi
    
    # Check if link already exists
    if [ -L "$target" ]; then
        print_info "Updating existing link for $target_name"
    else
        print_info "Creating new link for $target_name"
    fi
    
    # Create the symbolic link
    ln -sf "$source" "$target"
    print_success "Created link: ${BOLD}$target_name${NC} -> ${CYAN}$(basename "$source")${NC}"
}

print_header "Creating Symbolic Links"

# Map of AppImage files to their simplified command names
declare -A file_map
file_map["clipboard-x86_64.AppImage"]="hyprupld-clipboard"
file_map["e-z.gg-x86_64.AppImage"]="hyprupld-ez"
file_map["fakecri.me-x86_64.AppImage"]="hyprupld-fakecrime"
file_map["guns.lol-x86_64.AppImage"]="hyprupld-guns"
file_map["nest.rip-x86_64.AppImage"]="hyprupld-nest"
file_map["pixelvault.co-x86_64.AppImage"]="hyprupld-pixelvault"
# Add more mappings here as needed
# file_map["another-app-x86_64.AppImage"]="simple-name"

# Create links for each file in the map
for file in "${!file_map[@]}"; do
    source_file="$SCRIPTS_DIR/$file"
    if [ -f "$source_file" ]; then
        create_link "$source_file" "${file_map[$file]}"
    else
        print_warning "$file not found in $SCRIPTS_DIR"
    fi
done

print_header "Checking PATH Configuration"

# Check if INSTALL_DIR is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    print_warning "$INSTALL_DIR is not in your PATH."
    
    # For Bash/Zsh users, show instructions
    echo -e "${YELLOW}For Bash users (add to ~/.bashrc):${NC}"
    echo -e "  ${CYAN}export PATH=\"\$PATH:$INSTALL_DIR\"${NC}"
    echo ""
    echo -e "${YELLOW}For Zsh users (add to ~/.zshrc):${NC}"
    echo -e "  ${CYAN}export PATH=\"\$PATH:$INSTALL_DIR\"${NC}"
    echo ""
    
    # For Fish users, attempt to automatically add to PATH
    if command -v fish &>/dev/null; then
        print_info "Detected Fish shell. Attempting to add $INSTALL_DIR to your PATH..."
        if fish -c "set -U fish_user_paths \$fish_user_paths $INSTALL_DIR"; then
            print_success "Successfully added to Fish shell PATH!"
        else
            print_error "Failed to add to Fish shell PATH. Please add manually."
        fi
    else
        echo -e "${YELLOW}For Fish users (add to ~/.config/fish/config.fish):${NC}"
        echo -e "  ${CYAN}set -x PATH \$PATH $INSTALL_DIR${NC}"
        echo ""
        echo -e "${YELLOW}Or run this command for Fish shell:${NC}"
        echo -e "  ${CYAN}fish -c \"set -U fish_user_paths \$fish_user_paths $INSTALL_DIR\"${NC}"
    fi
else
    print_success "$INSTALL_DIR is already in your PATH."
fi

print_header "Installation Complete!"
echo -e "You can now use the following commands:"
for cmd in "${file_map[@]}"; do
    echo -e "  ${GREEN}${BOLD}$cmd${NC}"
done