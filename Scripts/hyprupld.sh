#!/bin/bash
#==============================================================================
# hyprupld - Screenshot and Upload Utility
#==============================================================================
# This script provides a flexible screenshot capture and upload solution
# supporting multiple desktop environments and upload services.
#==============================================================================
# Author: PhoenixAceVFX
# License: GPL-2.0
# Repository: https://github.com/PhoenixAceVFX/hyprupld
#==============================================================================

set -o errexit  # Exit on error
set -o nounset  # Exit on undefined variables
set -o pipefail # Exit on pipe failures

# Configuration paths
readonly CONFIG_DIR="${HOME}/.config/hyprupld"
readonly SETTINGS_FILE="${CONFIG_DIR}/settings.json"
readonly PCKMGRS_FILE="${CONFIG_DIR}/pckmgrs.json"

# Temporary files
readonly TEMP_DIR="/tmp"
readonly SCREENSHOT_FILE="${TEMP_DIR}/screenshot.png"
readonly UPLOAD_RESPONSE="${TEMP_DIR}/upload.json"

# ANSI color codes
readonly COLOR_RED='\033[0;31m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[0;33m'
readonly COLOR_BLUE='\033[0;34m'
readonly COLOR_MAGENTA='\033[0;35m'
readonly COLOR_CYAN='\033[0;36m'
readonly COLOR_RESET='\033[0m'

# Default values
service=""
auth_header=""
url=""

# Service configurations
declare -A SERVICES=(
    ["pixelvault"]="https://pixelvault.co|Authorization"
    ["guns"]="https://guns.lol/api/upload|key"
    ["ez"]="https://api.e-z.host/files|key"
    ["fakecrime"]="https://upload.fakecrime.bio|Authorization"
    ["nest"]="https://nest.rip/api/files/upload|Authorization"
    ["atumsworld"]="https://atums.world/api/upload|authorization"
)

#==============================================================================
# Function Definitions
#==============================================================================

# 1. Logging Functions
log_info() {
    echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $1"
}

log_success() {
    echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} $1"
}

log_warning() {
    echo -e "${COLOR_YELLOW}[WARNING]${COLOR_RESET} $1"
}

log_error() {
    echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} $1"
}

log_step() {
    echo -e "${COLOR_CYAN}[STEP]${COLOR_RESET} $1"
}

# 2. Cleanup Functions
cleanup_on_error() {
    local err=$?
    log_error "An error occurred (Exit code: $err)"
    cleanup_files
    exit "$err"
}

cleanup_on_exit() {
    cleanup_files
}

cleanup_files() {
    if [[ -f "$SCREENSHOT_FILE" ]]; then
        rm -f "$SCREENSHOT_FILE"
    fi
    if [[ -f "$UPLOAD_RESPONSE" ]]; then
        rm -f "$UPLOAD_RESPONSE"
    fi
    if [[ -n "${SUDO_ASKPASS:-}" && -f "$SUDO_ASKPASS" ]]; then
        rm -f "$SUDO_ASKPASS"
    fi
}

# 3. Configuration Functions
ensure_config_dir() {
    if [[ ! -d "$CONFIG_DIR" ]]; then
        mkdir -p "$CONFIG_DIR"
        log_info "Created configuration directory: $CONFIG_DIR"
    fi
}

validate_config() {
    if [[ -f "$SETTINGS_FILE" ]]; then
        if ! jq empty "$SETTINGS_FILE" 2>/dev/null; then
            log_error "Invalid settings file format"
            backup_and_reset_config
        fi
    fi
}

backup_and_reset_config() {
    local backup_file="${SETTINGS_FILE}.backup-$(date +%Y%m%d-%H%M%S)"
    if [[ -f "$SETTINGS_FILE" ]]; then
        mv "$SETTINGS_FILE" "$backup_file"
        log_warning "Corrupted settings file backed up to: $backup_file"
    fi
    echo "{}" > "$SETTINGS_FILE"
    log_info "Created new settings file"
}

get_saved_value() {
    local key="$1"
    if [[ -f "$SETTINGS_FILE" ]]; then
        jq -r ".[\"$key\"] // empty" "$SETTINGS_FILE"
    fi
}

save_value() {
    local key="$1"
    local value="$2"
    local temp_file
    temp_file=$(mktemp)
    
    if [[ -f "$SETTINGS_FILE" ]]; then
        jq --arg key "$key" --arg value "$value" '.[$key] = $value' "$SETTINGS_FILE" > "$temp_file"
    else
        jq --arg key "$key" --arg value "$value" '{($key): $value}' <<< '{}' > "$temp_file"
    fi
    
    mv "$temp_file" "$SETTINGS_FILE"
}

# 4. System Check Functions
check_system_requirements() {
    check_display_server
    check_basic_dependencies
}

check_display_server() {
    if [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" ]]; then
        log_error "No display server detected"
        exit 1
    fi
}

check_basic_dependencies() {
    local basic_deps=("curl" "jq")
    local missing=()
    
    for dep in "${basic_deps[@]}"; do
        if ! command -v "$dep" &>/dev/null; then
            missing+=("$dep")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        log_error "Missing basic dependencies: ${missing[*]}"
        exit 1
    fi
}

# 5. Package Management Functions
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

    local detected_managers=()
    for manager in "${managers[@]}"; do
        if command -v "$manager" &>/dev/null; then
            detected_managers+=("${manager_names[$manager]}")
            log_info "Found package manager: $manager (${manager_names[$manager]})"
        fi
    done

    printf '%s\n' "${detected_managers[@]}" | jq -R . | jq -s . > "$PCKMGRS_FILE"
    log_success "Detected package managers: ${detected_managers[*]}"
    echo "${detected_managers[@]}"
}

get_package_managers() {
    if [[ -f "$PCKMGRS_FILE" ]]; then
        log_info "Using cached package manager information"
        jq -r '.[]' "$PCKMGRS_FILE"
    else
        log_info "No cached package manager information found, detecting..."
        detect_package_managers
    fi
}

check_dependencies() {
    log_step "Checking for required tools"
    local required_packages=("zenity" "jq" "xclip" "fyi")
    local missing_packages=()

    for package in "${required_packages[@]}"; do
        if ! command -v "$package" &>/dev/null; then
            missing_packages+=("$package")
            log_warning "Missing package: $package"
        else
            log_info "Found package: $package"
        fi
    done

    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        install_missing_packages "${missing_packages[@]}"
    else
        log_success "All required packages are already installed"
    fi
}

install_missing_packages() {
    local missing_packages=("$@")
    log_warning "Missing required packages. Installing: ${missing_packages[*]}"

    if ! [ -t 0 ]; then
        handle_gui_installation "${missing_packages[@]}"
        return
    fi

    local package_managers
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
    
    if ! zenity --question \
        --title="Package Installation" \
        --text="This script needs to install the following packages:\n\n${missing_packages[*]}\n\nDo you want to proceed?" \
        --width=300; then
        log_error "User declined package installation"
        exit 1
    fi
    
    local sudo_password
    sudo_password=$(zenity --password --title="Authentication Required") || exit 1
    askpass_script="$(mktemp)"
    echo '#!/bin/sh' > "$askpass_script"
    echo "echo '$sudo_password'" >> "$askpass_script"
    chmod +x "$askpass_script"
    export SUDO_ASKPASS="$askpass_script"
}

attempt_package_installation() {
    local manager="$1"
    shift
    local packages=("$@")
    
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
    
    local exit_status=$?
    if [ $exit_status -eq 0 ]; then
        log_success "Installation successful"
        return 0
    fi
    return 1
}

# 6. Argument Parsing Functions
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -debug)
                set -euox pipefail
                shift
                ;;
            -reset)
                handle_reset
                exit 0
                ;;
            -u|--url)
                handle_custom_url "$2" || exit 1
                shift 2
                ;;
            -h|--help)
                display_help
                exit 0
                ;;
            -v|--version)
                print_version
                exit 0
                ;;
            -*)
                local service_name="${1#-}"
                if [[ -n "${SERVICES[$service_name]:-}" ]]; then
                    IFS='|' read -r url auth_header <<< "${SERVICES[$service_name]}"
                    service="$service_name"
                    shift
                else
                    log_error "Unknown option: $1"
                    echo "Use -h or --help for usage information"
                    exit 1
                fi
                ;;
            *)
                log_error "Unknown option: $1"
                echo "Use -h or --help for usage information"
                exit 1
                ;;
        esac
    done
}

handle_reset() {
    if [[ -f "$SETTINGS_FILE" ]]; then
        rm "$SETTINGS_FILE"
        log_success "Settings file has been reset"
    else
        log_warning "No settings file found to reset"
    fi
}

handle_custom_url() {
    local custom_url="$1"
    if [[ -n "$custom_url" ]]; then
        url="$custom_url"
        service="custom"
        auth_header="Authorization"
        return 0
    else
        log_error "URL argument is missing"
        return 1
    fi
}

display_help() {
    cat << EOF
hyprupld - Screenshot and Upload Utility

Usage: hyprupld [OPTIONS]

Options:
  -h, --help       Show this help message
  -v, --version    Display version information
  -debug           Enable debug mode with strict error handling
  -reset           Reset all settings and start fresh
  -u, --url URL    Set a custom upload URL

Screenshot Services:
  -guns            Use guns.lol
  -ez              Use e-z.host
  -fakecrime       Use fakecri.me
  -nest            Use nest.rip
  -pixelvault      Use pixelvault.co
  -atumsworld      Use atums.world

Environment Variables:
  HYPRUPLD_CONFIG  Override default config directory
  HYPRUPLD_DEBUG   Enable debug output when set to 1

Examples:
  hyprupld -guns              # Take screenshot and upload to guns.lol
  hyprupld                    # Take screenshot and copy to clipboard
  hyprupld -u https://example.com/upload  # Use custom upload URL

For more information and updates, visit:
https://github.com/PhoenixAceVFX/hyprupld
EOF
}

# 7. Screenshot Functions
take_screenshot() {
    log_step "Taking screenshot based on desktop environment: $desktop_env"
    
    case "$desktop_env" in
        *"sway"*|*"hyprland"*|*"i3"*)
            take_wayland_screenshot
            ;;
        *"kde"*)
            take_kde_screenshot
            ;;
        *"xfce"*)
            take_xfce_screenshot
            ;;
        *"gnome"*)
            take_gnome_screenshot
            ;;
        *"cinnamon"*)
            take_cinnamon_screenshot
            ;;
        *"deepin"*)
            take_deepin_screenshot
            ;;
        *"mate"*)
            take_mate_screenshot
            ;;
        *)
            log_error "Unsupported desktop environment: $desktop_env"
            return 1
            ;;
    esac

    verify_screenshot
}

take_wayland_screenshot() {
    log_info "Using grimblast for Wayland/i3 environment"
    grimblast save area "$SCREENSHOT_FILE"
}

take_kde_screenshot() {
    log_info "Detected KDE environment"
    local tool
    tool=$(get_screenshot_tool "kde" "Flameshot" "Spectacle")
    
    if [[ "$tool" == "Flameshot" ]]; then
        flameshot gui -p "$SCREENSHOT_FILE"
    else
        spectacle --region --background --nonotify --output "$SCREENSHOT_FILE"
    fi
}

take_xfce_screenshot() {
    local tool
    tool=$(get_screenshot_tool "xfce" "XFCE4-Screenshooter" "Flameshot")
    
    if [[ "$tool" == "XFCE4-Screenshooter" ]]; then
        xfce4-screenshooter -r -s "$SCREENSHOT_FILE"
    else
        flameshot gui -p "$SCREENSHOT_FILE"
    fi
}

take_gnome_screenshot() {
    local tool
    tool=$(get_screenshot_tool "gnome" "GNOME-Screenshot" "Flameshot")
    
    if [[ "$tool" == "GNOME-Screenshot" ]]; then
        gnome-screenshot -a -f "$SCREENSHOT_FILE"
    else
        flameshot gui -p "$SCREENSHOT_FILE"
    fi
}

take_cinnamon_screenshot() {
    local tool
    tool=$(get_screenshot_tool "cinnamon" "GNOME-Screenshot" "Flameshot")
    
    if [[ "$tool" == "GNOME-Screenshot" ]]; then
        gnome-screenshot -a -f "$SCREENSHOT_FILE"
    else
        flameshot gui -p "$SCREENSHOT_FILE"
    fi
}

take_deepin_screenshot() {
    deepin-screenshot -s "$SCREENSHOT_FILE"
}

take_mate_screenshot() {
    local tool
    tool=$(get_screenshot_tool "mate" "MATE-Screenshot" "Flameshot")
    
    if [[ "$tool" == "MATE-Screenshot" ]]; then
        mate-screenshot -a -f "$SCREENSHOT_FILE"
    else
        flameshot gui -p "$SCREENSHOT_FILE"
    fi
}

get_screenshot_tool() {
    local de="$1"
    local default_tool="$2"
    local alternative_tool="$3"
    local tool
    
    tool=$(get_saved_value "${de}_tool")
    if [[ -z "$tool" ]]; then
        log_info "No preferred screenshot tool saved, prompting user"
        tool=$(zenity --list --radiolist \
            --title="${de^^} Screenshot Tool" \
            --text="Choose your preferred screenshot tool:" \
            --column="" --column="Tool" \
            TRUE "$default_tool" \
            FALSE "$alternative_tool" \
            --width=500 --height=316) || exit 1
        save_value "${de}_tool" "$tool"
    fi
    echo "$tool"
}

verify_screenshot() {
    if [[ ! -f "$SCREENSHOT_FILE" ]]; then
        log_error "Failed to take screenshot"
        return 1
    fi
    log_success "Screenshot saved to $SCREENSHOT_FILE"
    return 0
}

# 8. Upload Functions
handle_upload() {
    if [[ -n "$service" ]]; then
        upload_screenshot
    else
        copy_to_clipboard
    fi
}

upload_screenshot() {
    local firefox_version
    firefox_version=$(firefox --version | awk '{print $3}')
    log_info "Detected Firefox version: $firefox_version"

    log_step "Uploading screenshot to $url"
    
    case "$service" in
        "guns")
            upload_to_guns
            ;;
        "fakecrime")
            upload_to_fakecrime
            ;;
        *)
            upload_to_generic_service
            ;;
    esac
}

upload_to_guns() {
    local response
    response=$(curl -s -X POST \
        -F "file=@$SCREENSHOT_FILE" \
        -F "key=$auth" \
        "$url")
    echo "$response" > "$UPLOAD_RESPONSE"
    process_upload_response
}

upload_to_fakecrime() {
    local image_url
    image_url=$(curl -X POST \
        -F "file=@$SCREENSHOT_FILE" \
        -H "Authorization: $auth" \
        -v "$url" 2>/dev/null)
        
    if [[ -z "$image_url" || "$image_url" == "null" ]]; then
        log_error "Failed to upload screenshot"
        return 1
    fi
    
    copy_url_to_clipboard "$image_url"
}

upload_to_generic_service() {
    local response
    response=$(curl -s -X POST "$url" \
        -H "Content-Type: multipart/form-data" \
        -H "User-Agent: Mozilla/5.0 (Wayland; Linux x86_64; rv:$firefox_version) Gecko/20100101 Firefox/$firefox_version" \
        -H "$auth_header: $auth" \
        -F "file=@$SCREENSHOT_FILE" \
        -o "$UPLOAD_RESPONSE")
        
    process_upload_response
}

process_upload_response() {
    if [[ ! -f "$UPLOAD_RESPONSE" ]]; then
        log_error "Failed to get upload response"
        return 1
    fi

    local json_key
    case "$service" in
        "pixelvault") json_key=".resource" ;;
        "nest") json_key=".fileURL" ;;
        "guns") json_key=".link" ;;
        "ez") json_key=".imageUrl" ;;
        "atumsworld") json_key=".files[0].url" ;;
        *) json_key=".resource" ;;
    esac
    
    local url
    url=$(jq -r "$json_key" "$UPLOAD_RESPONSE")
    copy_url_to_clipboard "$url"
}

copy_to_clipboard() {
    log_step "Copying screenshot to clipboard"
    
    if command -v xclip &> /dev/null; then
        log_info "Using xclip for clipboard operations"
        xclip -selection clipboard -t image/png -i "$SCREENSHOT_FILE"
    elif command -v wl-copy &> /dev/null; then
        log_info "Using wl-copy for clipboard operations"
        wl-copy < "$SCREENSHOT_FILE"
    else
        log_error "No clipboard utility found (xclip or wl-copy)"
        return 1
    fi
    
    log_success "Screenshot copied to clipboard"
    fyi "Screenshot copied to clipboard"
    return 0
}

copy_url_to_clipboard() {
    local url="$1"
    echo -n "$url" | xclip -selection clipboard
    local clipboard_content
    clipboard_content=$(xclip -selection clipboard -o)
    log_info "URL copied to clipboard: $clipboard_content"
    fyi "Image URL copied to clipboard: $clipboard_content"
}

# 9. Authentication Functions
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

# 10. Initialization Functions
initialize_script() {
    check_system_requirements
    ensure_config_dir
    validate_config
    
    # Detect distribution and desktop environment
    distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"')
    desktop_env=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')
    
    log_info "Detected distribution: $distro"
    log_info "Detected desktop environment: $desktop_env"
    
    check_dependencies
}

# 11. Main Function
main() {
    initialize_script
    parse_arguments "$@"
    
    if [[ -n "$service" ]]; then
        get_authentication "$service" || exit 1
    fi
    
    take_screenshot || exit 1
    handle_upload || exit 1
    
    log_success "Operation completed successfully"
    return 0
}

#==============================================================================
# Script Execution
#==============================================================================

# Set up error handling
trap cleanup_on_error ERR
trap cleanup_on_exit EXIT

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

