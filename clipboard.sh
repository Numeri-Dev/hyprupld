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

# Helper functions
get_saved_value() {
    [[ -f "$settings_file" ]] && jq -r ".$1" "$settings_file" || echo ""
}

save_value() {
    mkdir -p "$(dirname "$settings_file")"
    [[ -f "$settings_file" ]] && jq ".$1=\"$2\"" "$settings_file" > "$settings_file.tmp" && mv "$settings_file.tmp" "$settings_file" || echo "{\"$1\": \"$2\"}" > "$settings_file"
}

detect_package_managers() {
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
        fi
    done

    # Save detected managers to JSON
    printf '%s\n' "${detected_managers[@]}" | jq -R . | jq -s . > "$pckmgrs_file"
    echo "${detected_managers[@]}"
}

get_package_managers() {
    if [[ -f "$pckmgrs_file" ]]; then
        jq -r '.[]' "$pckmgrs_file"
    else
        detect_package_managers
    fi
}

install_dependencies() {
    required_packages=("$@")
    package_managers=($(get_package_managers))
    missing_packages=()

    # Check for missing dependencies
    for package in "${required_packages[@]}"; do
        if ! command -v "$package" &>/dev/null; then
            missing_packages+=("$package")
        fi
    done

    if [[ ${#missing_packages[@]} -eq 0 ]]; then
        return
    fi

    echo "The following packages are missing: ${missing_packages[*]}"
    for manager in "${package_managers[@]}"; do
        case "$manager" in
            "arch") sudo pacman -S --noconfirm "${missing_packages[@]}" && return ;;
            "debian") sudo apt-get install -y "${missing_packages[@]}" && return ;;
            "fedora") sudo dnf install -y "${missing_packages[@]}" && return ;;
            "nixos") sudo nix-env -iA nixpkgs."${missing_packages[@]}" && return ;;
            "gentoo") sudo emerge --ask "${missing_packages[@]}" && return ;;
            "opensuse") sudo zypper install -y "${missing_packages[@]}" && return ;;
            "void") sudo xbps-install -y "${missing_packages[@]}" && return ;;
            "arch_community")
                if command -v yay &>/dev/null; then
                    yay -S --noconfirm "${missing_packages[@]}" && return
                elif command -v paru &>/dev/null; then
                    paru -S --noconfirm "${missing_packages[@]}" && return
                fi
                ;;
        esac
    done

    echo "Could not install dependencies. Install the following manually: ${missing_packages[*]}"
    exit 1
}

# Ensure Zenity, jq, and xclip are installed
install_dependencies "zenity" "jq" "xclip"

# Detect distro and desktop environment
distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"')
desktop_env=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')

# Handle screenshots based on the desktop environment
case "$desktop_env" in
    *"sway"*|*"hyprland"*|*"i3"*)
        install_dependencies "grimblast"
        grimblast save area "$temp_file"
        ;;
    *"kde"*)
        install_dependencies "flameshot" "spectacle"
        saved_tool=$(get_saved_value "kde_tool")
        if [[ -z "$saved_tool" ]]; then
            tool=$(zenity --list --radiolist --title="KDE Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE Flameshot FALSE Spectacle --width=500 --height=316) || exit 1
            save_value "kde_tool" "$tool"
        else
            tool="$saved_tool"
        fi
        if [[ "$tool" == "Flameshot" ]]; then
            flameshot gui -p "$temp_file"
        else
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
        notify-send "Error" "Unsupported desktop environment: $desktop_env" -a "Screenshot Script"
        exit 1
        ;;
esac

# Verify screenshot
if [[ ! -f "$temp_file" ]]; then
    notify-send "Error" "Failed to take screenshot." -a "Screenshot Script"
    exit 1
fi

# Copy screenshot to clipboard
if command -v xclip &> /dev/null; then
    xclip -selection clipboard -t image/png -i "$temp_file"
elif command -v wl-copy &> /dev/null; then
    wl-copy < "$temp_file"
else
    notify-send "Error" "No clipboard utility found (xclip or wl-copy)." -a "Screenshot Script"
    exit 1
fi

notify-send "Success" "Screenshot copied to clipboard." -a "Screenshot Script" -i "$temp_file"

# Clean up temporary files
rm -f "$temp_file"
