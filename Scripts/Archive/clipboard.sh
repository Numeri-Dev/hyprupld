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


# Main script variables
temp_file="/tmp/screenshot.png"
settings_file="$HOME/.config/hyprupld/settings.json"
pckmgrs_file="$HOME/.config/hyprupld/pckmgrs.json"
verbose=true  # Enable verbose output by default

# Color codes for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    if [[ "$verbose" == true ]]; then
        echo -e "${BLUE}[INFO]${NC} $1"
    fi
}

log_success() {
    if [[ "$verbose" == true ]]; then
        echo -e "${GREEN}[SUCCESS]${NC} $1"
    fi
}

log_warning() {
    if [[ "$verbose" == true ]]; then
        echo -e "${YELLOW}[WARNING]${NC} $1"
    fi
}

log_error() {
    if [[ "$verbose" == true ]]; then
        echo -e "${RED}[ERROR]${NC} $1"
    fi
}

get_saved_value() {
    [[ -f "$settings_file" ]] && jq -r ".$1" "$settings_file" || echo ""
}

save_value() {
    log_info "Saving setting: $1 = $2"
    mkdir -p "$(dirname "$settings_file")"
    [[ -f "$settings_file" ]] && jq ".$1=\"$2\"" "$settings_file" > "$settings_file.tmp" && mv "$settings_file.tmp" "$settings_file" || echo "{\"$1\": \"$2\"}" > "$settings_file"
}

detect_package_managers() {
    log_info "Detecting package managers..."
    declare -a managers=("pacman" "apt-get" "dnf" "nix-env" "emerge" "zypper" "xbps-install" "yay" "paru")
    declare -A manager_names=(
        ["pacman"]="arch"
        ["apt-get"]="debian"
        ["dnf"]="fedora"
        ["nix-env"]="nixos"
        ["emerge"]="gentoo"
        ["zypper"]="opensuse"
        ["xbps-install"]="void"
        ["yay"]="arch_community"
        ["paru"]="arch_community"
    )

    detected_managers=()
    for manager in "${managers[@]}"; do
        if command -v "$manager" &>/dev/null; then
            detected_managers+=("${manager_names[$manager]}")
            log_info "Found package manager: $manager (${manager_names[$manager]})"
        fi
    done

    # Save detected managers to JSON
    printf '%s\n' "${detected_managers[@]}" | jq -R . | jq -s . > "$pckmgrs_file"
    log_success "Detected package managers: ${detected_managers[*]}"
    echo "${detected_managers[@]}"
}

get_package_managers() {
    if [[ -f "$pckmgrs_file" ]]; then
        log_info "Reading package managers from cache"
        jq -r '.[]' "$pckmgrs_file"
    else
        log_info "No cached package managers found, detecting..."
        detect_package_managers
    fi
}

install_dependencies() {
    required_packages=("$@")
    package_managers=($(get_package_managers))
    missing_packages=()

    # Check for missing dependencies
    log_info "Checking for required dependencies: ${required_packages[*]}"
    for package in "${required_packages[@]}"; do
        if ! command -v "$package" &>/dev/null; then
            missing_packages+=("$package")
            log_warning "Missing dependency: $package"
        else
            log_info "Found dependency: $package"
        fi
    done

    if [[ ${#missing_packages[@]} -eq 0 ]]; then
        log_success "All dependencies are installed"
        return
    fi

    log_warning "The following packages are missing: ${missing_packages[*]}"
    echo -e "${CYAN}Attempting to install missing packages...${NC}"
    
    for manager in "${package_managers[@]}"; do
        case "$manager" in
            "arch") 
                log_info "Using pacman to install packages"
                sudo pacman -S --noconfirm "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "debian") 
                log_info "Using apt-get to install packages"
                sudo apt-get install -y "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "fedora") 
                log_info "Using dnf to install packages"
                sudo dnf install -y "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "nixos") 
                log_info "Using nix-env to install packages"
                sudo nix-env -iA nixpkgs."${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "gentoo") 
                log_info "Using emerge to install packages"
                sudo emerge --ask "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "opensuse") 
                log_info "Using zypper to install packages"
                sudo zypper install -y "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "void") 
                log_info "Using xbps-install to install packages"
                sudo xbps-install -y "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "arch_community")
                if command -v yay &>/dev/null; then
                    log_info "Using yay to install packages"
                    yay -S --noconfirm "${missing_packages[@]}" && log_success "Packages installed successfully" && return
                elif command -v paru &>/dev/null; then
                    log_info "Using paru to install packages"
                    paru -S --noconfirm "${missing_packages[@]}" && log_success "Packages installed successfully" && return
                fi
                ;;
        esac
    done

    log_error "Could not install dependencies. Install the following manually: ${missing_packages[*]}"
    exit 1
}

# Ensure Zenity, jq, and xclip are installed
log_info "Checking for required tools: zenity, jq, xclip"
install_dependencies "zenity" "jq" "xclip"

# Detect distro and desktop environment
distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"')
desktop_env=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')
log_info "Detected distribution: $distro"
log_info "Detected desktop environment: $desktop_env"

# Handle screenshots based on the desktop environment
log_info "Taking screenshot based on desktop environment"
case "$desktop_env" in
    *"sway"*|*"hyprland"*|*"i3"*)
        log_info "Using grimblast for Wayland/i3 environment"
        install_dependencies "grimblast"
        log_info "Capturing area screenshot with grimblast"
        grimblast save area "$temp_file"
        ;;
    *"kde"*)
        log_info "KDE environment detected"
        install_dependencies "flameshot" "spectacle"
        saved_tool=$(get_saved_value "kde_tool")
        if [[ -z "$saved_tool" ]]; then
            log_info "No saved screenshot tool preference, asking user"
            tool=$(zenity --list --radiolist --title="KDE Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE Flameshot FALSE Spectacle --width=500 --height=316) || exit 1
            save_value "kde_tool" "$tool"
        else
            tool="$saved_tool"
            log_info "Using saved screenshot tool preference: $tool"
        fi
        if [[ "$tool" == "Flameshot" ]]; then
            log_info "Capturing screenshot with Flameshot"
            flameshot gui -p "$temp_file"
        else
            log_info "Capturing screenshot with Spectacle"
            spectacle --region --background --nonotify --output "$temp_file"
        fi
        ;;
    *"xfce"*)
        install_dependencies "xfce4-screenshooter" "flameshot"
		saved_tool=$(get_saved_value "xfce_tool")
        if [[ -z "$saved_tool" ]]; then
            tool=$(zenity --list --radiolist --title="XFCE Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE XFCE4-Screenshooter FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "xfce_tool" "$tool"
        else
            tool="$saved_tool"
        fi
        if [[ "$tool" == "XFCE4-Screenshooter" ]]; then
            xfce4-screenshooter -r -s "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *"gnome"*)
        install_dependencies "gnome-screenshot" "flameshot"
        saved_tool=$(get_saved_value "gnome_tool")
        if [[ -z "$saved_tool" ]]; then
            tool=$(zenity --list --radiolist --title="GNOME Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE GNOME-Screenshot FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "gnome_tool" "$tool"
        else
            tool="$saved_tool"
        fi
        if [[ "$tool" == "GNOME-Screenshot" ]]; then
            gnome-screenshot -a -f "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *"cinnamon"*)
        install_dependencies "gnome-screenshot" "flameshot"
        saved_tool=$(get_saved_value "cinnamon_tool")
        if [[ -z "$saved_tool" ]]; then
            tool=$(zenity --list --radiolist --title="Cinnamon Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE GNOME-Screenshot FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "cinnamon_tool" "$tool"
        else
            tool="$saved_tool"
        fi
        if [[ "$tool" == "GNOME-Screenshot" ]]; then
            gnome-screenshot -a -f "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *"deepin"*)
        install_dependencies "deepin-screenshot"
        deepin-screenshot -s "$temp_file"
        ;;
    *"mate"*)
        install_dependencies "mate-screenshot" "flameshot"
        saved_tool=$(get_saved_value "mate_tool")
        if [[ -z "$saved_tool" ]]; then
            tool=$(zenity --list --radiolist --title="MATE Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE MATE-Screenshot FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "mate_tool" "$tool"
        else
            tool="$saved_tool"
        fi
        if [[ "$tool" == "MATE-Screenshot" ]]; then
            mate-screenshot -a -f "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *)
        log_error "Unsupported desktop environment: $desktop_env"
        notify-send "Error" "Unsupported desktop environment: $desktop_env" -a "Screenshot Script"
        exit 1
        ;;
esac

# Verify screenshot
if [[ ! -f "$temp_file" ]]; then
    log_error "Failed to take screenshot"
    notify-send "Error" "Failed to take screenshot." -a "Screenshot Script"
    exit 1
fi
log_success "Screenshot captured successfully: $temp_file"

# Copy screenshot to clipboard
log_info "Copying screenshot to clipboard"
if command -v xclip &> /dev/null; then
    log_info "Using xclip for clipboard operations"
    xclip -selection clipboard -t image/png -i "$temp_file"
elif command -v wl-copy &> /dev/null; then
    log_info "Using wl-copy for clipboard operations"
    wl-copy < "$temp_file"
else
    log_error "No clipboard utility found (xclip or wl-copy)"
    notify-send "Error" "No clipboard utility found (xclip or wl-copy)." -a "Screenshot Script"
    exit 1
fi

log_success "Screenshot copied to clipboard"
notify-send "Success" "Screenshot copied to clipboard." -a "Screenshot Script" -i "$temp_file"

# Clean up temporary files
log_info "Cleaning up temporary files"
rm -f "$temp_file"
log_success "Script completed successfully"
