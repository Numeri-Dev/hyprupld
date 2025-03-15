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

# Add to the configuration section near other readonly variables
readonly SAVE_DIR_SETTING="screenshot_save_directory"

# Add this near the other readonly variables at the top
readonly VERSION="hyprupld-dev"

# Add these new readonly variables near the top with other readonly declarations
readonly GITHUB_API_URL="https://api.github.com/repos/PhoenixAceVFX/hyprupld/releases/latest"
readonly VERSION_PATTERN="^hyprupld-[0-9]{8}-[0-9]{6}$"

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
    if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
        echo "wayland"
    elif [[ -n "${DISPLAY:-}" ]]; then
        echo "x11"
    else
        echo "unknown"
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

    # Check for required packages
    for package in "${required_packages[@]}"; do
        if ! command -v "$package" &>/dev/null; then
            missing_packages+=("$package")
            log_warning "Missing package: $package"
        else
            log_info "Found package: $package"
        fi
    done

    # Special check for wl-copy (because wl-clipboard is obnoxious)
    if ! command -v wl-copy &>/dev/null; then
        missing_packages+=("wl-clipboard")
        log_warning "Missing package: wl-clipboard (provides wl-copy)"
    else
        log_info "Found package: wl-copy (from wl-clipboard)"
    fi

    # Install missing packages if any
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
            -s|--save)
                handle_save_option
                shift
                ;;
            -update)
                handle_update
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

handle_save_option() {
    save_enabled=true
    save_directory=$(get_save_directory)
}

get_save_directory() {
    local dir
    dir=$(get_saved_value "$SAVE_DIR_SETTING")
    
    if [[ -z "$dir" ]]; then
        log_info "No saved screenshot directory found, prompting user"
        local base_dir
        base_dir=$(zenity --file-selection \
            --directory \
            --title="Select Base Directory" \
            --text="Choose where to create the 'hyprupld' screenshots folder:") || exit 1
            
        # Create the hyprupld subdirectory
        dir="${base_dir}/hyprupld"
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir" || {
                log_error "Failed to create hyprupld directory: $dir"
                save_value "$SAVE_DIR_SETTING" ""
                exit 1
            }
            log_info "Created hyprupld directory at: $dir"
        fi
            
        save_value "$SAVE_DIR_SETTING" "$dir"
        log_success "Screenshot directory set to: $dir"
    fi
    
    # Verify directory exists and is writable
    if [[ ! -d "$dir" ]]; then
        log_error "Screenshot directory does not exist: $dir"
        save_value "$SAVE_DIR_SETTING" ""
        exit 1
    fi
    
    if [[ ! -w "$dir" ]]; then
        log_error "Screenshot directory is not writable: $dir"
        save_value "$SAVE_DIR_SETTING" ""
        exit 1
    fi
    
    echo "$dir"
    return 0
}

save_screenshot() {
    if [[ "$save_enabled" == "true" ]]; then
        # Get current month and year
        local month_year
        month_year=$(date +%B-%Y | tr '[:upper:]' '[:lower:]')
        local monthly_dir="${save_directory}/${month_year}"
        
        # Create monthly directory if it doesn't exist
        if [[ ! -d "$monthly_dir" ]]; then
            mkdir -p "$monthly_dir"
            log_info "Created new month directory: $monthly_dir"
        fi
        
        # Generate timestamp and save file
        local timestamp
        timestamp=$(date +%Y%m%d-%H%M%S)
        local save_path="${monthly_dir}/hyprupld-${timestamp}.png"
        
        cp "$SCREENSHOT_FILE" "$save_path"
        log_success "Screenshot saved to: $save_path"
        fyi "Screenshot saved to: $save_path"
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
  -s, --save       Save screenshots to a specified directory
  -update          Update hyprupld to the latest version

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
    # Save the screenshot if -s option was used
    save_screenshot
    
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

# Add this helper function near the other utility functions
detect_display_server() {
    if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
        echo "wayland"
    elif [[ -n "${DISPLAY:-}" ]]; then
        echo "x11"
    else
        echo "unknown"
    fi
}

# Update the clipboard functions
copy_to_clipboard() {
    log_step "Copying screenshot to clipboard"
    
    local display_server
    display_server=$(detect_display_server)
    
    case "$display_server" in
        "wayland")
            if command -v wl-copy &> /dev/null; then
                log_info "Using wl-copy for Wayland clipboard operations"
                cat "$SCREENSHOT_FILE" | wl-copy
                clipboard_content=$(wl-paste 2>&1)
            else
                log_error "wl-copy not found. Please install wl-clipboard"
                return 1
            fi
            ;;
        "x11")
            if command -v xclip &> /dev/null; then
                log_info "Using xclip for X11 clipboard operations"
                xclip -selection clipboard -t image/png -i "$SCREENSHOT_FILE"
            else
                log_error "xclip not found. Please install xclip"
                return 1
            fi
            ;;
        *)
            log_error "No supported display server detected"
            return 1
            ;;
    esac
    
    log_success "Screenshot copied to clipboard"
    fyi "Screenshot copied to clipboard"
    return 0
}

copy_url_to_clipboard() {
    local url="$1"
    local display_server
    display_server=$(detect_display_server)
    
    case "$display_server" in
        "wayland")
            if command -v wl-copy &> /dev/null; then
                log_info "Using wl-copy for Wayland clipboard operations"
                echo -n "$url" | wl-copy
                clipboard_content=$(wl-paste)
            else
                log_error "wl-copy not found. Please install wl-clipboard"
                return 1
            fi
            ;;
        "x11")
            if command -v xclip &> /dev/null; then
                log_info "Using xclip for X11 clipboard operations"
                echo -n "$url" | xclip -selection clipboard
                clipboard_content=$(xclip -selection clipboard -o)
            else
                log_error "xclip not found. Please install xclip"
                return 1
            fi
            ;;
        *)
            log_error "No supported display server detected"
            return 1
            ;;
    esac
    
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
    # Add this line before parse_arguments
    save_enabled=false
    
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

# Add these new functions near the other function definitions
handle_update() {
    # Find and kill any running hyprupld processes except our own
    local our_pid=$$
    local hyprupld_pids
    mapfile -t hyprupld_pids < <(pgrep -f "hyprupld" | grep -v "$our_pid")
    
    if [[ ${#hyprupld_pids[@]} -gt 0 ]]; then
        log_warning "Found running hyprupld processes, stopping them for update..."
        for pid in "${hyprupld_pids[@]}"; do
            if kill -0 "$pid" 2>/dev/null; then
                log_info "Stopping hyprupld process: $pid"
                kill "$pid"
            fi
        done
    fi

    if [[ ! -d "$HOME/hyprupld" ]]; then
        log_info "hyprupld source directory not found, cloning repository..."
        if ! git clone https://github.com/PhoenixAceVFX/hyprupld.git "$HOME/hyprupld"; then
            log_error "Failed to clone repository"
            exit 1
        fi
        log_success "Repository cloned successfully"
    fi

    log_step "Updating hyprupld..."
    cd "$HOME/hyprupld" || exit 1
    
    log_info "Pulling latest changes from repository..."
    if ! git pull; then
        log_error "Failed to pull latest changes"
        exit 1
    fi
    
    if ! bash compile.sh; then
        log_error "Compilation failed"
        exit 1
    fi
    
    if ! bash install_scripts.sh; then
        log_error "Installation failed"
        exit 1
    fi
    
    log_success "hyprupld has been updated successfully"
    exit 0
}

prompt_for_update() {
    if zenity --question \
        --title="Update Available" \
        --text="A newer version of hyprupld is available. Would you like to update now?" \
        --width=300; then
        handle_update
    else
        log_info "You can run with -update to update later"
    fi
}

# Update the print_version function
print_version() {
    echo "$VERSION"
    
    # Exit early if using dev version
    if [[ "$VERSION" == "hyprupld-dev" ]]; then
        exit 0
    fi
    
    # Check if version matches expected pattern (hyprupld-YYYYMMDD-HHMMSS)
    if [[ "$VERSION" =~ ^hyprupld-([0-9]{8})-([0-9]{6})$ ]]; then
        # Extract date and time from local version
        local_date="${BASH_REMATCH[1]}"
        local_time="${BASH_REMATCH[2]}"
        local_datetime="${local_date}${local_time}"
        
        # Get latest release info from GitHub
        log_info "Checking for updates..."
        latest_release=$(curl -s "$GITHUB_API_URL")
        
        if [[ -n "$latest_release" ]]; then
            # Extract the tag name (version) from the latest release
            latest_version=$(echo "$latest_release" | jq -r '.tag_name')
            
            # Check if the latest version matches our expected format
            if [[ "$latest_version" =~ ^hyprupld-([0-9]{8})-([0-9]{6})$ ]]; then
                latest_date="${BASH_REMATCH[1]}"
                latest_time="${BASH_REMATCH[2]}"
                latest_datetime="${latest_date}${latest_time}"
                
                # Compare versions
                if (( local_datetime >= latest_datetime )); then
                    log_success "You are running the latest version"
                else
                    log_warning "A newer version is available"
                    prompt_for_update
                fi
            else
                log_warning "Invalid version format from GitHub: $latest_version"
            fi
        else
            log_warning "Could not check for updates - GitHub API request failed"
        fi
    else
        log_warning "Invalid local version format: $VERSION"
    fi
    
    exit 0
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

