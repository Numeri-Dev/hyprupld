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

# Exit on error, undefined variables, and pipe failures
set -o errexit  
set -o nounset  
set -o pipefail 

# Configuration paths for settings and package managers
readonly CONFIG_DIR="${HOME}/.config/hyprupld"
readonly SETTINGS_FILE="${CONFIG_DIR}/settings.json"
readonly PCKMGRS_FILE="${CONFIG_DIR}/pckmgrs.json"

# Temporary files for screenshots and upload responses
readonly TEMP_DIR="/tmp"
readonly SCREENSHOT_FILE="${TEMP_DIR}/screenshot.png"
readonly UPLOAD_RESPONSE="${TEMP_DIR}/upload.json"

# ANSI color codes for logging
readonly COLOR_RED='\033[0;31m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[0;33m'
readonly COLOR_BLUE='\033[0;34m'
readonly COLOR_MAGENTA='\033[0;35m'
readonly COLOR_CYAN='\033[0;36m'
readonly COLOR_RESET='\033[0m'

# Default values for service, auth header, and URL
service=""
auth_header=""
url=""

# Service configurations for different upload services
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

# Add version information
readonly VERSION="hyprupld-dev"

# Add GitHub API URL and version pattern for updates
readonly GITHUB_API_URL="https://api.github.com/repos/PhoenixAceVFX/hyprupld/releases/latest"
readonly VERSION_PATTERN="^hyprupld-[0-9]{8}-[0-9]{6}$"

# Sound file paths for feedback
readonly SOUND_DIR="/usr/local/share/hyprupld/sounds"
readonly SCREENSHOT_SOUND="${SOUND_DIR}/sstaken.mp3"
readonly CLIPBOARD_SOUND="${SOUND_DIR}/clipboard.mp3"
readonly LINK_SOUND="${SOUND_DIR}/link.mp3"

#==============================================================================
# Function Definitions
#==============================================================================

# Logging functions for different log levels
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

# Cleanup functions to handle errors and exit
cleanup_on_error() {
    local err=$?
    log_error "An error occurred (Exit code: $err)"
    cleanup_files
    exit "$err"
}

cleanup_on_exit() {
    cleanup_files
}

# Remove temporary files created during execution
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

# Ensure the configuration directory exists
ensure_config_dir() {
    if [[ ! -d "$CONFIG_DIR" ]]; then
        mkdir -p "$CONFIG_DIR"
        log_info "Created configuration directory: $CONFIG_DIR"
    fi
}

# Validate the settings file format
validate_config() {
    if [[ -f "$SETTINGS_FILE" ]]; then
        if ! python3 -c "import json; json.load(open('$SETTINGS_FILE'))" 2>/dev/null; then
            log_error "Invalid settings file format"
            backup_and_reset_config
        fi
    fi
}

# Backup and reset the settings file if corrupted
backup_and_reset_config() {
    local backup_file="${SETTINGS_FILE}.backup-$(date +%Y%m%d-%H%M%S)"
    if [[ -f "$SETTINGS_FILE" ]]; then
        mv "$SETTINGS_FILE" "$backup_file"
        log_warning "Corrupted settings file backed up to: $backup_file"
    fi
    echo "{}" > "$SETTINGS_FILE"
    log_info "Created new settings file"
}

# Retrieve a saved value from the settings file
get_saved_value() {
    local key="$1"
    if [[ -f "$SETTINGS_FILE" ]]; then
        python3 -c "import json; print(json.load(open('$SETTINGS_FILE')).get('$key', ''))"
    fi
}

# Save a key-value pair to the settings file
save_value() {
    local key="$1"
    local value="$2"
    local temp_file
    temp_file=$(mktemp)

    if [[ -f "$SETTINGS_FILE" ]]; then
        python3 -c "
import json
import sys
data = json.load(open('$SETTINGS_FILE'))
data['$key'] = '$value'
with open('$temp_file', 'w') as f:
    json.dump(data, f, indent=4)
"
    else
        python3 -c "
import json
data = {}
data['$key'] = '$value'
with open('$temp_file', 'w') as f:
    json.dump(data, f, indent=4)
"
    fi
    
    mv "$temp_file" "$SETTINGS_FILE"
}

# Check system requirements before running the script
check_system_requirements() {
    check_display_server
    check_basic_dependencies
}

# Detect the display server (Wayland or X11)
check_display_server() {
    if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
        echo "wayland"
    elif [[ -n "${DISPLAY:-}" ]]; then
        echo "x11"
    else
        echo "unknown"
    fi
}

# Check for basic dependencies required by the script
check_basic_dependencies() {
    local basic_deps=("curl" "python3")
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

# Detect available package managers on the system
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

    printf '%s\n' "${detected_managers[@]}" | python3 -c "import sys, json; json.dump(sys.stdin.read().splitlines(), sys.stdout)" > "$PCKMGRS_FILE"
    log_success "Detected package managers: ${detected_managers[*]}"
    echo "${detected_managers[@]}"
}

# Get cached package manager information or detect it
get_package_managers() {
    if [[ -f "$PCKMGRS_FILE" ]]; then
        log_info "Using cached package manager information"
        python3 -c "import json; print(json.load(open('$PCKMGRS_FILE')))"
    else
        log_info "No cached package manager information found, detecting..."
        detect_package_managers
    fi
}

# Check for required tools and dependencies
check_dependencies() {
    log_step "Checking for required tools"
    local required_packages=("zenity" "python3" "xclip" "fyi")
    local audio_packages=("pulseaudio-utils" "sox" "alsa-utils" "mpg123")
    local missing_packages=()
    local has_audio_player=false

    # Check for required packages
    for package in "${required_packages[@]}"; do
        if ! command -v "$package" &>/dev/null; then
            missing_packages+=("$package")
            log_warning "Missing package: $package"
        else
            log_info "Found package: $package"
        fi
    done

    # Check for audio player availability
    for player in "paplay" "play" "aplay" "mpg123"; do
        if command -v "$player" &>/dev/null; then
            has_audio_player=true
            log_info "Found audio player: $player"
            break
        fi
    done

    if [[ "$has_audio_player" == "false" ]]; then
        log_warning "No audio player found. Installing pulseaudio-utils for sound support"
        missing_packages+=("pulseaudio-utils")
    fi

    # Install missing packages if any
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        install_missing_packages "${missing_packages[@]}"
    else
        log_success "All required packages are already installed"
    fi
}

# Install missing packages using the appropriate package manager
install_missing_packages() {
    local missing_packages=("$@")
    log_warning "Missing required packages. Installing: ${missing_packages[*]}"

    if ! [ -t 0 ]; then
        handle_gui_installation "${missing_packages[@]}"
        return
    fi

    # Install missing packages if any
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        local package_managers
        mapfile -t package_managers < <(python3 -c "import json; print(json.load(open('$PCKMGRS_FILE')))")
        for manager in "${package_managers[@]}"; do
            case "$manager" in
                "arch")
                    handle_gui_installation_arch "${missing_packages[@]}"
                    return
                    ;;
                "debian")
                    handle_gui_installation_debian "${missing_packages[@]}"
                    return
                    ;;
                "fedora")
                    handle_gui_installation_fedora "${missing_packages[@]}"
                    return
                    ;;
                "nixos")
                    handle_gui_installation_nixos "${missing_packages[@]}"
                    return
                    ;;
                "gentoo")
                    handle_gui_installation_gentoo "${missing_packages[@]}"
                    return
                    ;;
                "opensuse")
                    handle_gui_installation_opensuse "${missing_packages[@]}"
                    return
                    ;;
                "void")
                    handle_gui_installation_void "${missing_packages[@]}"
                    return
                    ;;
                *)
                    log_warning "Unsupported package manager: $manager"
                    ;;
            esac
        done
    else
        log_success "All required packages are already installed"
    fi
}

# Handle GUI installation for Debian-based systems
handle_gui_installation_debian() {
    local missing_packages=("$@")
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
    echo "echo '$sudo_password' | sudo -S apt-get install -y ${missing_packages[*]}" >> "$askpass_script"
    chmod +x "$askpass_script"
    export SUDO_ASKPASS="$askpass_script"
    (bash "$askpass_script" &)
}

# Handle GUI installation for Arch-based systems
handle_gui_installation_arch() {
    local missing_packages=("$@")
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
    echo "echo '$sudo_password' | sudo -S pacman -S --noconfirm ${missing_packages[*]}" >> "$askpass_script"
    chmod +x "$askpass_script"
    export SUDO_ASKPASS="$askpass_script"
    (bash "$askpass_script" &)
}

# Argument parsing function to handle command-line options
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
                exit 0
                ;;
            -update)
                handle_update
                ;;
            -mute)
                mute_enabled=true
                shift
                ;;
            -silent)
                silent_enabled=true
                mute_enabled=true
                shift
                ;;
            -kill)
                log_info "Killing all running instances of hyprupld..."
                pkill -f hyprupld
                log_success "All running instances of hyprupld have been killed."
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

# Reset the settings file
handle_reset() {
    if [[ -f "$SETTINGS_FILE" ]]; then
        rm "$SETTINGS_FILE"
        log_success "Settings file has been reset"
    else
        log_warning "No settings file found to reset"
    fi
}

# Handle custom URL input
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

# Handle the save option for screenshots
handle_save_option() {
    save_enabled=true
    save_directory=$(get_save_directory)
}

# Get the directory to save screenshots
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

# Save the screenshot to the specified directory
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
        fyi_call "HyprUpld" "Screenshot saved to: $save_path"
    fi
}

# Display help information for the script
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
  -mute            Mute sound feedback
  -silent          Silent mode (no sound or notification)
  -kill            Kill all running instances of hyprupld

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

# Take a screenshot based on the desktop environment
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

# Take a screenshot in Wayland environments
take_wayland_screenshot() {
    if [[ "$desktop_env" == *"hyprland"* ]]; then
        log_info "Using hyprshot for Hyprland environment"
        hyprshot -m region -z -s -o "$TEMP_DIR" -f "screenshot.png"
    else
        log_info "Using grimblast for Wayland/i3 environment"
        grimblast save area "$SCREENSHOT_FILE"
    fi
    play_sound "$SCREENSHOT_SOUND"
}

# Take a screenshot in KDE environments
take_kde_screenshot() {
    log_info "Detected KDE environment"
    local tool
    tool=$(get_screenshot_tool "kde" "Flameshot" "Spectacle")
    
    if [[ "$tool" == "Flameshot" ]]; then
        flameshot gui -p "$SCREENSHOT_FILE"
        play_sound "$SCREENSHOT_SOUND"
    else
        spectacle --region --background --nonotify --output "$SCREENSHOT_FILE"
        play_sound "$SCREENSHOT_SOUND"
    fi
}

# Take a screenshot in XFCE environments
take_xfce_screenshot() {
    local tool
    tool=$(get_screenshot_tool "xfce" "XFCE4-Screenshooter" "Flameshot")
    
    if [[ "$tool" == "XFCE4-Screenshooter" ]]; then
        xfce4-screenshooter -r -s "$SCREENSHOT_FILE"
        play_sound "$SCREENSHOT_SOUND"
    else
        flameshot gui -p "$SCREENSHOT_FILE"
        play_sound "$SCREENSHOT_SOUND"
    fi
}

# Take a screenshot in GNOME environments
take_gnome_screenshot() {
    local tool
    tool=$(get_screenshot_tool "gnome" "GNOME-Screenshot" "Flameshot")
    
    if [[ "$tool" == "GNOME-Screenshot" ]]; then
        gnome-screenshot -a -f "$SCREENSHOT_FILE"
        play_sound "$SCREENSHOT_SOUND"
    else
        flameshot gui -p "$SCREENSHOT_FILE"
        play_sound "$SCREENSHOT_SOUND"
    fi
}

# Take a screenshot in Cinnamon environments
take_cinnamon_screenshot() {
    local tool
    tool=$(get_screenshot_tool "cinnamon" "GNOME-Screenshot" "Flameshot")
    
    if [[ "$tool" == "GNOME-Screenshot" ]]; then
        gnome-screenshot -a -f "$SCREENSHOT_FILE"
        play_sound "$SCREENSHOT_SOUND"
    else
        flameshot gui -p "$SCREENSHOT_FILE"
        play_sound "$SCREENSHOT_SOUND"
    fi
}

# Take a screenshot in Deepin environments
take_deepin_screenshot() {
    deepin-screenshot -s "$SCREENSHOT_FILE"
    play_sound "$SCREENSHOT_SOUND"
}

# Take a screenshot in MATE environments
take_mate_screenshot() {
    local tool
    tool=$(get_screenshot_tool "mate" "MATE-Screenshot" "Flameshot")
    
    if [[ "$tool" == "MATE-Screenshot" ]]; then
        mate-screenshot -a -f "$SCREENSHOT_FILE"
        play_sound "$SCREENSHOT_SOUND"
    else
        flameshot gui -p "$SCREENSHOT_FILE"
        play_sound "$SCREENSHOT_SOUND"
    fi
}

# Get the preferred screenshot tool for the specified desktop environment
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

# Verify that the screenshot was successfully taken
verify_screenshot() {
    if [[ ! -f "$SCREENSHOT_FILE" ]]; then
        log_error "Failed to take screenshot"
        return 1
    fi
    log_success "Screenshot saved to $SCREENSHOT_FILE"
    return 0
}

# Handle the upload process for the screenshot
handle_upload() {
    # Save the screenshot if -s option was used
    save_screenshot
    
    if [[ -n "$service" ]]; then
        upload_screenshot
    else
        copy_to_clipboard
    fi
}

# Upload the screenshot to the specified service
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

# Upload the screenshot to guns.lol
upload_to_guns() {
    local response
    response=$(curl -s -X POST \
        -F "file=@$SCREENSHOT_FILE" \
        -F "key=$auth" \
        "$url")
    echo "$response" > "$UPLOAD_RESPONSE"
    process_upload_response
}

# Upload the screenshot to fakecrime.bio
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

# Upload the screenshot to a generic service
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

# Process the response from the upload service
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
        "fakecrime") json_key=".url" ;;
        *) json_key=".resource" ;;
    esac
    
    local url
    url=$(python3 -c "import json; print(${json_key})" < "$UPLOAD_RESPONSE")
    
    # Check if the URL is empty or null
    if [[ -z "$url" || "$url" == "null" ]]; then
        log_error "Failed to extract URL from upload response for service: $service"
        return 1
    fi
    
    copy_url_to_clipboard "$url"
}

# Detect the display server (Wayland or X11)
detect_display_server() {
    if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
        echo "wayland"
    elif [[ -n "${DISPLAY:-}" ]]; then
        echo "x11"
    else
        echo "unknown"
    fi
}

# Copy the screenshot to the clipboard
copy_to_clipboard() {
    log_step "Copying screenshot to clipboard"
    
    local display_server
    display_server=$(detect_display_server)
    
    case "$display_server" in
        "wayland")
            if command -v wl-copy &> /dev/null; then
                log_info "Using wl-copy for Wayland clipboard operations"
                if ! cat "$SCREENSHOT_FILE" | wl-copy; then
                    log_error "Failed to copy screenshot to clipboard using wl-copy"
                    return 1
                fi
                clipboard_content=$(wl-paste 2>&1 | tr -d '\0')
            else
                log_error "wl-copy not found. Please install wl-clipboard"
                return 1
            fi
            ;;
        "x11")
            if command -v xclip &> /dev/null; then
                log_info "Using xclip for X11 clipboard operations"
                if ! xclip -selection clipboard -t image/png -i "$SCREENSHOT_FILE"; then
                    log_error "Failed to copy screenshot to clipboard using xclip"
                    return 1
                fi
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
    fyi_call "HyprUpld" "Screenshot copied to clipboard"
    play_sound "$CLIPBOARD_SOUND"
    return 0
}

# Copy a URL to the clipboard
copy_url_to_clipboard() {
    local url="$1"
    local display_server
    display_server=$(detect_display_server)
    
    case "$display_server" in
        "wayland")
            if command -v wl-copy &> /dev/null; then
                log_info "Using wl-copy for Wayland clipboard operations"
                echo -n "$url" | wl-copy
                clipboard_content=$(wl-paste 2>&1 | tr -d '\0')
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
    fyi_call "HyprUpld" "Image URL copied to clipboard: $clipboard_content"
    play_sound "$LINK_SOUND"
}

# Retrieve the authentication key for the specified service
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

# Initialize the script by checking requirements and setting up the environment
initialize_script() {
    check_system_requirements
    check_python  # Check for Python installation
    ensure_config_dir
    ensure_sound_files
    validate_config
    
    # Detect distribution and desktop environment
    distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"')
    desktop_env=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')
    
    log_info "Detected distribution: $distro"
    log_info "Detected desktop environment: $desktop_env"
    
    check_dependencies
}

# Check for running instances of hyprupld
check_running_instances() {
    local running_instances
    running_instances=$(pgrep -c hyprupld)

    if [[ "$running_instances" -gt 0 ]]; then
        if zenity --question --title="Instance Running" --text="Another instance of hyprupld is currently running. Do you want to kill it and continue?" --width=300; then
            # Kill the current instance
            pkill -f hyprupld
            log_info "Killed the running instance of hyprupld."
        else
            if zenity --question --title="Kill All Instances" --text="Do you want to kill all running instances of hyprupld?" --width=300; then
                pkill -f hyprupld
                log_info "Killed all running instances of hyprupld."
            else
                log_warning "User chose not to kill any instances. Exiting."
                exit 1
            fi
        fi
    fi
}

# Main function to execute the script
main() {
    # Ensure the config directory exists
    mkdir -p "$CONFIG_DIR"  # Ensure the config directory exists
    : > "$CONFIG_DIR/debug.log"  # Clear the debug.log file
    exec > >(tee -a "$CONFIG_DIR/debug.log") 2>&1  # Redirect output to debug.log

    # Check for running instances of hyprupld
    check_running_instances

    # Initialize flags for saving and muting
    save_enabled=false
    mute_enabled=false
    silent_enabled=false
    
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

# Handle updates for the script
handle_update() {
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

# Prompt the user for an update if available
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

# Print the version of the script and check for updates
print_version() {
    echo "$VERSION"
    
    # Exit early if using dev version
    if [[ "$VERSION" == "hyprupld-dev" ]]; then
        exit 0
    fi
    
    # Get latest release info from GitHub
    log_info "Checking for updates..."
    latest_release=$(curl -s "$GITHUB_API_URL")
    
    if [[ -n "$latest_release" ]]; then
        # Extract the published date from the latest release
        latest_date=$(python3 -c "import json; print(json.loads('''$latest_release''')['published_at'])")
        
        if [[ -n "$latest_date" && "$latest_date" != "null" ]]; then
            # Convert GitHub ISO 8601 date to comparable format (YYYYMMDDHHMMSS)
            latest_datetime=$(date -d "$latest_date" +%Y%m%d%H%M%S)
            
            # Get local version date (assuming version format hyprupld-YYYYMMDD-HHMMSS)
            if [[ "$VERSION" =~ ^hyprupld-([0-9]{8})-([0-9]{6})$ ]]; then
                local_datetime="${BASH_REMATCH[1]}${BASH_REMATCH[2]}"
                
                # Compare timestamps
                if (( local_datetime >= latest_datetime )); then
                    log_success "You are running the latest version"
                else
                    log_warning "A newer version is available"
                    prompt_for_update
                fi
            else
                log_warning "Invalid local version format: $VERSION"
            fi
        else
            log_warning "Could not determine latest release date"
        fi
    else
        log_warning "Could not check for updates - GitHub API request failed"
    fi
    
    exit 0
}

# Play a sound file if not muted
play_sound() {
    if [[ "$mute_enabled" == "true" || "$silent_enabled" == "true" ]]; then
        return 0
    fi
    local sound_file="$1"
    
    # Check if sound file exists
    if [[ ! -f "$sound_file" ]]; then
        log_warning "Sound file not found: $sound_file"
        return 1
    fi

    # Try different audio players in order of preference
    if command -v paplay &> /dev/null; then
        paplay "$sound_file" &> /dev/null
    elif command -v play &> /dev/null; then
        play -q "$sound_file" &> /dev/null
    elif command -v aplay &> /dev/null; then
        aplay -q "$sound_file" &> /dev/null
    elif command -v mpg123 &> /dev/null; then
        mpg123 -q "$sound_file" &> /dev/null
    else
        log_warning "No supported audio player found. Install pulseaudio-utils, sox, alsa-utils, or mpg123 for sound feedback."
        return 1
    fi
}

# Call the fyi function for notifications
fyi_call() {
    if [[ "$silent_enabled" == "true" ]]; then
        return 0 
    fi

    fyi "$1" "$2"
}

# Ensure sound files exist in the specified directory
ensure_sound_files() {
    # Create sounds directory if it doesn't exist
    if [[ ! -d "$SOUND_DIR" ]]; then
        mkdir -p "$SOUND_DIR"
        log_info "Created sounds directory: $SOUND_DIR"
    fi

    # Copy sound files from script directory to config directory if they don't exist
    local script_dir
    script_dir="$(dirname "$(readlink -f "$0")")"
    
    for sound in "sstaken.mp3" "clipboard.mp3" "link.mp3"; do
        if [[ ! -f "${SOUND_DIR}/${sound}" && -f "${script_dir}/${sound}" ]]; then
            cp "${script_dir}/${sound}" "${SOUND_DIR}/${sound}"
            log_info "Copied sound file: ${sound}"
        fi
    done
}

# Function to check if Python is installed
check_python() {
    if ! command -v python3 &> /dev/null; then
        log_error "Python 3 is not installed. Please install Python 3 to use this script."
        exit 1
    fi
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
