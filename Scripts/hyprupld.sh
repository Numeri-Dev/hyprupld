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

# Color codes for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Main script variables
temp_file="/tmp/screenshot.png"
response_file="/tmp/upload.json"
settings_file="$HOME/.config/hyprupld/settings.json"
pckmgrs_file="$HOME/.config/hyprupld/pckmgrs.json"

# Parse command line arguments
service="" # Default Service
auth_header="" # Default Header
while [[ $# -gt 0 ]]; do
    case $1 in
        -debug)
            # Enable strict error handling and debug output
            set -euox pipefail
            shift
            ;;
        -reset)
            if [[ -f "$settings_file" ]]; then
                rm "$settings_file"
                echo -e "${GREEN}[SUCCESS]${NC} Settings file has been reset"
            else
                echo -e "${YELLOW}[WARNING]${NC} No settings file found to reset"
            fi
            exit 0
            ;;
        -u|--url)
            if [[ -n "$2" ]]; then
                url="$2"
                service="custom"
                auth_header="Authorization"
                shift 2
            else
                echo -e "${RED}[ERROR]${NC} URL argument is missing"
                exit 1
            fi
            ;;
        -pixelvault)
            url="https://pixelvault.co"
            service="pixelvault"
            auth_header="Authorization"
            shift
            ;;
        -guns)
            url="https://guns.lol/api/upload"
            service="guns"
            auth_header="key"
            shift
            ;;
        -ez)
            url="https://api.e-z.host/files"
            service="ez"
            auth_header="key"
            shift
            ;;
        -fakecrime)
            url="https://upload.fakecrime.bio"
            service="fakecrime"
            auth_header="Authorization"
            shift
            ;;
        -nest)
            url="https://nest.rip/api/files/upload"
            service="nest"
            auth_header="Authorization"
            shift
            ;;
        -atumsworld)
            url="https://atums.world/api/upload"
            service="atumsworld"
            auth_header="authorization"
            shift
            ;;
        -h|--help)
            echo "Usage: $(basename "$0") [OPTIONS]"
            echo "Options:"
            echo "  -h, --help       Show this help message"
            echo "  -debug           Enable debug mode with strict error handling"
            echo "  -reset           Reset all settings and start fresh"
            echo "  -u, --url URL    Set a custom upload URL"
            echo "  -guns            Use guns.lol"
            echo "  -ez              Use e-z.host"
            echo "  -fakecrime       Use fakecri.me"
            echo "  -nest            Use nest.rip"
            echo "  -pixelvault      Use pixelvault.co"
            echo "  -atumsworld      Use atums.world"
            exit 0
            ;;
        *)
            echo -e "${RED}[ERROR]${NC} Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${CYAN}[STEP]${NC} $1"
}

get_saved_value() {
    local key="$1"
    if [[ -f "$settings_file" ]]; then
        local value
        value=$(jq -r ".[\"$key\"]" "$settings_file")
        if [[ "$value" != "null" ]]; then
            echo "$value"
        fi
    fi
}

save_value() {
    local key="$1"
    local value="$2"
    log_info "Saving $key to settings file"
    mkdir -p "$(dirname "$settings_file")"
    if [[ -f "$settings_file" ]]; then
        local temp_file="${settings_file}.tmp"
        jq ".[\"$key\"]=\"$value\"" "$settings_file" > "$temp_file" && mv "$temp_file" "$settings_file"
    else
        echo "{\"$key\": \"$value\"}" > "$settings_file"
    fi
    log_success "Value saved successfully"
}

detect_package_managers() {
    log_step "Detecting package managers..."
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
        log_info "Using cached package manager information"
        jq -r '.[]' "$pckmgrs_file"
    else
        log_info "No cached package manager information found, detecting..."
        detect_package_managers
    fi
}

# Dependency management functions
check_dependencies() {
    log_step "Checking for required tools"
    local required_packages=()

    # Set required packages based on distribution
    if [[ -f "/etc/arch-release" ]]; then
        required_packages=("zenity" "jq" "xclip" "fyi")
    else
        required_packages=("zenity" "jq" "xclip" "fyi")
    fi

    # Check for missing packages
    local missing_packages=()
    for package in "${required_packages[@]}"; do
        if ! command -v "$package" &>/dev/null; then
            missing_packages+=("$package")
            log_warning "Missing package: $package"
        else
            log_info "Found package: $package"
        fi
    done

    # Install missing packages if needed
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        install_missing_packages "${missing_packages[@]}"
    else
        log_success "All required packages are already installed"
    fi
}

install_missing_packages() {
    local missing_packages=("$@")
    log_warning "Missing required packages. Installing: ${missing_packages[*]}"

    # Handle non-terminal environment
    if ! [ -t 0 ]; then
        handle_gui_installation "${missing_packages[@]}"
        return
    fi

    # Get package managers and attempt installation
    mapfile -t package_managers < <(get_package_managers)
    for manager in "${package_managers[@]}"; do
        if attempt_package_installation "$manager" "${missing_packages[@]}"; then
            return 0
        fi
    done

    log_error "Could not install dependencies. Install manually: ${missing_packages[*]}"
    exit 1
}

handle_gui_installation() {
    local missing_packages=("$@")
    local askpass_script
    
    # Ask for installation confirmation
    if ! zenity --question \
        --title="Package Installation" \
        --text="This script needs to install the following packages:\n\n${missing_packages[*]}\n\nDo you want to proceed?" \
        --width=300; then
        log_error "User declined package installation"
        exit 1
    fi
    
    # Get sudo password
    local sudo_password
    sudo_password=$(zenity --password --title="Authentication Required") || exit 1
    askpass_script="$(mktemp)"
    echo '#!/bin/sh' > "$askpass_script"
    echo "echo '$sudo_password'" >> "$askpass_script"
    chmod +x "$askpass_script"
    export SUDO_ASKPASS="$askpass_script"

    # Clean up the temporary askpass script
    trap 'rm -f "$askpass_script"' EXIT
}

attempt_package_installation() {
    local manager="$1"
    shift
    local packages=("$@")
    local exit_status
    
    log_info "Attempting to install with $manager"
    case "$manager" in
        "arch")
            sudo -A pacman -S --noconfirm "${packages[@]}"
            ;;
        "debian")
            sudo -A apt-get install -y "${packages[@]}"
            ;;
        "fedora")
            sudo -A dnf install -y "${packages[@]}"
            ;;
        "nixos")
            sudo -A nix-env -iA nixpkgs."${packages[@]}"
            ;;
        "gentoo")
            sudo -A emerge --ask "${packages[@]}"
            ;;
        "opensuse")
            sudo -A zypper install -y "${packages[@]}"
            ;;
        "void")
            sudo -A xbps-install -y "${packages[@]}"
            ;;
        "arch_community")
            if command -v yay &>/dev/null; then
                yay -S --noconfirm "${packages[@]}"
            elif command -v paru &>/dev/null; then
                paru -S --noconfirm "${packages[@]}"
            else
                return 1
            fi
            ;;
        *)
            return 1
            ;;
    esac
    
    exit_status=$?
    if [ $exit_status -eq 0 ]; then
        log_success "Installation successful"
        return 0
    fi
    return 1
}

get_authentication() {
    local service="$1"
    log_step "Retrieving authentication key for $service"
    
    auth=$(get_saved_value "${service}_auth")
    if [[ -z "$auth" ]]; then
        log_info "No saved auth key found for $service, prompting user"
        auth=$(zenity --entry \
            --title="Authentication Key" \
            --text="Enter your auth key for $service:" \
            --width=500) || exit 1
        save_value "${service}_auth" "$auth"
    else
        log_info "Using saved auth key for $service"
    fi
}

# Detect distro and desktop environment
distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"')
desktop_env=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')
log_info "Detected distribution: $distro"
log_info "Detected desktop environment: $desktop_env"

# Get auth key only if a service is specified
if [[ -n "$service" ]]; then
    get_authentication "$service"
fi

# Handle screenshots based on the desktop environment
log_step "Taking screenshot based on desktop environment: $desktop_env"
case "$desktop_env" in
    *"sway"*|*"hyprland"*|*"i3"*)
        log_info "Using grimblast for Wayland/i3 environment"
        check_dependencies
        grimblast save area "$temp_file"
        ;;
    *"kde"*)
        log_info "Detected KDE environment"
        check_dependencies
        tool=$(get_saved_value "kde_tool")
        if [[ -z "$tool" ]]; then
            log_info "No preferred screenshot tool saved, prompting user"
            tool=$(zenity --list --radiolist --title="KDE Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE Flameshot FALSE Spectacle --width=500 --height=316) || exit 1
            save_value "kde_tool" "$tool"
        fi
        if [[ "$tool" == "Flameshot" ]]; then
            log_info "Using Flameshot for screenshot"
            flameshot gui -p "$temp_file"
        else
            log_info "Using Spectacle for screenshot"
            spectacle --region --background --nonotify --output "$temp_file"
        fi
        ;;
    *"xfce"*)
        check_dependencies
        tool=$(get_saved_value "xfce_tool")
        if [[ -z "$tool" ]]; then
            tool=$(zenity --list --radiolist --title="XFCE Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE XFCE4-Screenshooter FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "xfce_tool" "$tool"
        fi
        if [[ "$tool" == "XFCE4-Screenshooter" ]]; then
            xfce4-screenshooter -r -s "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *"gnome"*)
        check_dependencies
        tool=$(get_saved_value "gnome_tool")
        if [[ -z "$tool" ]]; then
            tool=$(zenity --list --radiolist --title="GNOME Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE GNOME-Screenshot FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "gnome_tool" "$tool"
        fi
        if [[ "$tool" == "GNOME-Screenshot" ]]; then
            gnome-screenshot -a -f "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *"cinnamon"*)
        check_dependencies
        tool=$(get_saved_value "cinnamon_tool")
        if [[ -z "$tool" ]]; then
            tool=$(zenity --list --radiolist --title="Cinnamon Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE GNOME-Screenshot FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "cinnamon_tool" "$tool"
        fi
        if [[ "$tool" == "GNOME-Screenshot" ]]; then
            gnome-screenshot -a -f "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *"deepin"*)
        check_dependencies
        deepin-screenshot -s "$temp_file"
        ;;
    *"mate"*)
        check_dependencies
        tool=$(get_saved_value "mate_tool")
        if [[ -z "$tool" ]]; then
            tool=$(zenity --list --radiolist --title="MATE Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE MATE-Screenshot FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "mate_tool" "$tool"
        fi
        if [[ "$tool" == "MATE-Screenshot" ]]; then
            mate-screenshot -a -f "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *)
        log_error "Unsupported desktop environment: $desktop_env"
        fyi "Error" "Unsupported desktop environment: $desktop_env" -a "Screenshot Script"
        exit 1
        ;;
esac

# Verify screenshot
if [[ ! -f "$temp_file" ]]; then
    log_error "Failed to take screenshot"
    fyi "Error" "Failed to take screenshot." -a "Screenshot Script"
    exit 1
else
    log_success "Screenshot saved to $temp_file"
fi

# If no service specified, copy screenshot to clipboard
if [[ -n "$service" ]]; then
    # Get the current version of Firefox
    firefox_version=$(firefox --version | awk '{print $3}')
    log_info "Detected Firefox version: $firefox_version"

    # Modified upload section
    log_step "Uploading screenshot to $url"
    if [[ "$service" == "guns" ]]; then
        # Use guns.lol specific upload method
        response=$(curl -s -X POST -F "file=@$temp_file" -F "key=$auth" "$url")
        echo "$response" > "$response_file"
    elif [[ "$service" == "fakecrime" ]]; then
        # Use fakecrime specific upload method
        image_url=$(curl -X POST -F "file=@$temp_file" -H "Authorization: $auth" -v "$url" 2>/dev/null)
        if [[ -z "$image_url" || "$image_url" == "null" ]]; then
            log_error "Failed to upload screenshot"
            fyi "Failed to upload screenshot"
            rm -f "$temp_file"
            exit 1
        fi
        log_success "Screenshot uploaded successfully"
        
        # Copy URL to clipboard
        echo -n "$image_url" | xclip -selection clipboard
        clipboard_content=$(xclip -selection clipboard -o)
        log_info "URL copied to clipboard: $clipboard_content"
        fyi "Image URL copied to clipboard: $clipboard_content"
    else
        # Original upload method for other services
        response=$(curl -s -X POST "$url" \
            -H "Content-Type: multipart/form-data" \
            -H "User-Agent: Mozilla/5.0 (Wayland; Linux x86_64; rv:$firefox_version) Gecko/20100101 Firefox/$firefox_version" \
            -H "$auth_header: $auth" \
            -F "file=@$temp_file" \
            -o "$response_file")
    fi

    # Process response and copy URL for non-fakecrime services
    if [[ "$service" != "fakecrime" && -f "$response_file" ]]; then
        json_key=""
        case "$service" in
            "pixelvault") json_key=".resource" ;;
            "nest") json_key=".fileURL" ;;
            "guns") json_key=".link" ;;
            "ez") json_key=".imageUrl" ;;
            "atumsworld") json_key=".files[0].url" ;;
            *) json_key=".resource" ;;  # Default fallback
        esac
        cat "$response_file" | jq -r "$json_key" | tr -d '\n' | xclip -sel c
        clipboard_content=$(xclip -selection clipboard -o)
        log_info "URL copied to clipboard: $clipboard_content"
        fyi "Image URL copied to clipboard: $clipboard_content"
    fi
else
    # If no service specified, copy screenshot to clipboard
    log_step "Copying screenshot to clipboard"
    if command -v xclip &> /dev/null; then
        log_info "Using xclip for clipboard operations"
        xclip -selection clipboard -t image/png -i "$temp_file"
    elif command -v wl-copy &> /dev/null; then
        log_info "Using wl-copy for clipboard operations"
        wl-copy < "$temp_file"
    else
        log_error "No clipboard utility found (xclip or wl-copy)"
        fyi "No clipboard utility found (xclip or wl-copy)"
        exit 1
    fi
    log_success "Screenshot copied to clipboard"
    fyi "Screenshot copied to clipboard"
fi

# Clean up temporary files
log_info "Cleaning up temporary files"
rm -f "$temp_file" "$response_file"
log_success "Temporary files removed"
