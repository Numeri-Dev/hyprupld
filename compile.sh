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

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'  # Added blue color for verbose output
NC='\033[0m' # No Color

# Enable verbose output
VERBOSE=true

# Function for verbose logging
log_verbose() {
    if [ "$VERBOSE" = true ]; then
        echo -e "${BLUE}[VERBOSE] $1${NC}"
    fi
}

echo -e "${GREEN}Starting AppImage creation script${NC}"
log_verbose "Script version: 1.0"
log_verbose "Working directory: $(pwd)"

# Function to check if a package is installed based on the package manager
is_package_installed() {
  local package="$1"
  local pm="$2"
  
  log_verbose "Checking if package '$package' is installed using $pm"
  
  case "$pm" in
    "pacman")
      pacman -Q "$package" &> /dev/null
      ;;
    "apt")
      dpkg -l "$package" 2>/dev/null | grep -q "^ii"
      ;;
    "dnf"|"yum")
      rpm -q "$package" &> /dev/null
      ;;
    "zypper")
      rpm -q "$package" &> /dev/null
      ;;
    "apk")
      apk info -e "$package" &> /dev/null
      ;;
    *)
      echo "Unsupported package manager: $pm"
      return 1
      ;;
  esac
  local result=$?
  [ $result -eq 0 ] && log_verbose "Package '$package' is installed" || log_verbose "Package '$package' is NOT installed"
  return $result
}

# Detect package manager and install dependencies
echo -e "${YELLOW}Checking and installing dependencies...${NC}"
log_verbose "Detecting system package manager..."

# Detect package manager
if command -v pacman &> /dev/null; then
  PM="pacman"
  INSTALL_CMD="sudo pacman -Sy --noconfirm"
  PACKAGES=("wget" "fuse2" "base-devel" "cmake" "glib2" "cairo" "pango" "imagemagick")
elif command -v apt &> /dev/null || command -v apt-get &> /dev/null; then
  PM="apt"
  INSTALL_CMD="sudo apt-get install -y"
  PACKAGES=("wget" "fuse" "build-essential" "cmake" "libglib2.0-dev" "libcairo2-dev" "libpango1.0-dev" "imagemagick")
elif command -v dnf &> /dev/null; then
  PM="dnf"
  INSTALL_CMD="sudo dnf install -y"
  PACKAGES=("wget" "fuse" "gcc" "gcc-c++" "make" "cmake" "glib2-devel" "cairo-devel" "pango-devel" "ImageMagick")
elif command -v yum &> /dev/null; then
  PM="yum"
  INSTALL_CMD="sudo yum install -y"
  PACKAGES=("wget" "fuse" "gcc" "gcc-c++" "make" "cmake" "glib2-devel" "cairo-devel" "pango-devel" "ImageMagick")
elif command -v zypper &> /dev/null; then
  PM="zypper"
  INSTALL_CMD="sudo zypper install -y"
  PACKAGES=("wget" "fuse" "gcc" "gcc-c++" "make" "cmake" "glib2-devel" "cairo-devel" "pango-devel" "ImageMagick")
elif command -v apk &> /dev/null; then
  PM="apk"
  INSTALL_CMD="sudo apk add"
  PACKAGES=("wget" "fuse" "gcc" "g++" "make" "cmake" "glib-dev" "cairo-dev" "pango-dev" "imagemagick")
else
  echo -e "${RED}Unsupported distribution. Could not find a supported package manager.${NC}"
  echo -e "${YELLOW}Please install the following packages manually: wget, fuse, build tools, cmake, glib2, cairo, pango, imagemagick${NC}"
  read -p "Continue anyway? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
  PM="none"
fi

if [ "$PM" != "none" ]; then
  log_verbose "Using package manager: $PM"
  log_verbose "Required packages: ${PACKAGES[*]}"
  PACKAGES_TO_INSTALL=()
  
  for pkg in "${PACKAGES[@]}"; do
    if ! is_package_installed "$pkg" "$PM"; then
      echo -e "${YELLOW}Package $pkg is not installed. Adding to installation list.${NC}"
      PACKAGES_TO_INSTALL+=("$pkg")
    else
      echo -e "${GREEN}Package $pkg is already installed.${NC}"
    fi
  done
  
  if [ ${#PACKAGES_TO_INSTALL[@]} -gt 0 ]; then
    echo -e "${YELLOW}Installing missing packages: ${PACKAGES_TO_INSTALL[*]}${NC}"
    echo -e "${YELLOW}Requesting sudo privileges to install packages...${NC}"
    log_verbose "Running: $INSTALL_CMD ${PACKAGES_TO_INSTALL[*]}"
    $INSTALL_CMD "${PACKAGES_TO_INSTALL[@]}"
  else
    echo -e "${GREEN}All required packages are already installed.${NC}"
  fi
fi

# Create directories
WORK_DIR="$(pwd)/appimage_build"
COMPILED_DIR="$(pwd)/Compiled"
log_verbose "Creating working directory: $WORK_DIR"
mkdir -p "$WORK_DIR"
log_verbose "Creating output directory: $COMPILED_DIR"
mkdir -p "$COMPILED_DIR"

# Copy scripts to AppDir
echo -e "${YELLOW}Copying scripts to AppDir...${NC}"
SCRIPTS_DIR="$(pwd)/Scripts"
log_verbose "Scripts directory: $SCRIPTS_DIR"
if [ ! -d "$SCRIPTS_DIR" ]; then
  echo -e "${RED}Scripts directory not found! Creating it...${NC}"
  log_verbose "Creating Scripts directory"
  mkdir -p "$SCRIPTS_DIR"
  echo -e "${YELLOW}Please place your scripts in the Scripts directory and run this script again.${NC}"
  exit 1
fi

# Check for icon and create a default one if not found
ICON_PATH="$(pwd)/HyprUpld.png"
log_verbose "Checking for icon at: $ICON_PATH"
if [ ! -f "$ICON_PATH" ]; then
  echo -e "${YELLOW}Icon HyprUpld.png not found in project root! Creating a placeholder icon...${NC}"
  # Create a simple colored square as placeholder icon using convert (from ImageMagick)
  if command -v convert &> /dev/null; then
    log_verbose "Using ImageMagick to create placeholder icon"
    convert -size 256x256 xc:blue "$ICON_PATH"
  else
    echo -e "${YELLOW}ImageMagick not found. Trying to install...${NC}"
    if [ "$PM" != "none" ]; then
      log_verbose "Installing ImageMagick using $PM"
      case "$PM" in
        "pacman")
          sudo pacman -Sy --noconfirm imagemagick
          ;;
        "apt")
          sudo apt-get install -y imagemagick
          ;;
        "dnf"|"yum")
          sudo $PM install -y ImageMagick
          ;;
        "zypper")
          sudo zypper install -y ImageMagick
          ;;
        "apk")
          sudo apk add imagemagick
          ;;
      esac
      convert -size 256x256 xc:blue "$ICON_PATH"
    else
      echo -e "${RED}Cannot install ImageMagick automatically. Please install it manually.${NC}"
      echo -e "${YELLOW}Creating a simple text file as icon placeholder instead.${NC}"
      echo "This is a placeholder icon" > "$ICON_PATH"
    fi
  fi
  echo -e "${GREEN}Created placeholder icon at $ICON_PATH${NC}"
fi

# Process each script in the Scripts directory
log_verbose "Scanning Scripts directory for files to process"
SCRIPT_COUNT=0
for script in "$SCRIPTS_DIR"/*; do
  if [ -f "$script" ]; then
    SCRIPT_COUNT=$((SCRIPT_COUNT+1))
    SCRIPT_NAME=$(basename "$script")
    APPNAME="${SCRIPT_NAME%.*}"
    
    echo -e "${GREEN}Processing script: $SCRIPT_NAME${NC}"
    log_verbose "Script path: $script"
    log_verbose "App name derived from script: $APPNAME"
    
    # Create AppDir structure for this script
    SCRIPT_APPDIR="$WORK_DIR/AppDir_$APPNAME"
    log_verbose "Creating AppDir structure at: $SCRIPT_APPDIR"
    mkdir -p "$SCRIPT_APPDIR/usr/bin"
    mkdir -p "$SCRIPT_APPDIR/usr/share/applications"
    mkdir -p "$SCRIPT_APPDIR/usr/share/icons/hicolor/256x256/apps"
    
    # Copy script to AppDir
    log_verbose "Copying script to: $SCRIPT_APPDIR/usr/bin/$SCRIPT_NAME"
    cp "$script" "$SCRIPT_APPDIR/usr/bin/$SCRIPT_NAME"
    chmod +x "$SCRIPT_APPDIR/usr/bin/$SCRIPT_NAME"
    
    # Copy icon
    log_verbose "Copying icon to AppDir locations"
    cp "$ICON_PATH" "$SCRIPT_APPDIR/usr/share/icons/hicolor/256x256/apps/$APPNAME.png"
    # Also copy icon to root of AppDir (important for appimagetool)
    cp "$ICON_PATH" "$SCRIPT_APPDIR/$APPNAME.png"
    
    # Create desktop file in both locations
    echo -e "${YELLOW}Creating desktop file for $APPNAME...${NC}"
    log_verbose "Creating desktop file at: $SCRIPT_APPDIR/usr/share/applications/$APPNAME.desktop"
    # Create in usr/share/applications
    cat > "$SCRIPT_APPDIR/usr/share/applications/$APPNAME.desktop" << EOF
[Desktop Entry]
Name=$APPNAME
Exec=$SCRIPT_NAME
Icon=$APPNAME
Type=Application
Categories=Utility;
Terminal=true
EOF
    
    # Also create in root of AppDir (important for appimagetool)
    log_verbose "Creating desktop file at: $SCRIPT_APPDIR/$APPNAME.desktop"
    cat > "$SCRIPT_APPDIR/$APPNAME.desktop" << EOF
[Desktop Entry]
Name=$APPNAME
Exec=$SCRIPT_NAME
Icon=$APPNAME
Type=Application
Categories=Utility;
Terminal=true
EOF
    
    # Create AppRun file
    echo -e "${YELLOW}Creating AppRun file for $APPNAME...${NC}"
    log_verbose "Creating AppRun file at: $SCRIPT_APPDIR/AppRun"
    cat > "$SCRIPT_APPDIR/AppRun" << EOF
#!/bin/bash
SELF=\$(readlink -f "\$0")
HERE=\${SELF%/*}
export PATH="\${HERE}/usr/bin:\${PATH}"
"\${HERE}/usr/bin/$SCRIPT_NAME" "\$@"
EOF
    
    chmod +x "$SCRIPT_APPDIR/AppRun"
    
    # Verify all required files exist
    log_verbose "Verifying required files exist in AppDir"
    if [ ! -f "$SCRIPT_APPDIR/usr/bin/$SCRIPT_NAME" ]; then
      echo -e "${RED}Error: Script file not copied correctly to $SCRIPT_APPDIR/usr/bin/$SCRIPT_NAME${NC}"
      continue
    fi
    
    if [ ! -f "$SCRIPT_APPDIR/$APPNAME.desktop" ]; then
      echo -e "${RED}Error: Desktop file not created correctly at $SCRIPT_APPDIR/$APPNAME.desktop${NC}"
      continue
    fi
    
    if [ ! -f "$SCRIPT_APPDIR/AppRun" ]; then
      echo -e "${RED}Error: AppRun file not created correctly at $SCRIPT_APPDIR/AppRun${NC}"
      continue
    fi
    
    # Download AppImage tool if not present
    if [ ! -f "$WORK_DIR/appimagetool-x86_64.AppImage" ]; then
      echo -e "${YELLOW}Downloading appimagetool...${NC}"
      log_verbose "Downloading from: https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
      wget -O "$WORK_DIR/appimagetool-x86_64.AppImage" "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
      chmod +x "$WORK_DIR/appimagetool-x86_64.AppImage"
    else
      log_verbose "appimagetool already downloaded"
    fi
    
    # Create AppImage
    echo -e "${YELLOW}Creating AppImage for $APPNAME...${NC}"
    log_verbose "Changing to directory: $WORK_DIR"
    cd "$WORK_DIR"
    log_verbose "Running appimagetool with ARCH=x86_64"
    log_verbose "Source: $SCRIPT_APPDIR"
    log_verbose "Destination: $COMPILED_DIR/$APPNAME-x86_64.AppImage"
    ARCH=x86_64 ./appimagetool-x86_64.AppImage --verbose "$SCRIPT_APPDIR" "$COMPILED_DIR/$APPNAME-x86_64.AppImage"
    
    if [ -f "$COMPILED_DIR/$APPNAME-x86_64.AppImage" ]; then
      echo -e "${GREEN}AppImage created: $COMPILED_DIR/$APPNAME-x86_64.AppImage${NC}"
      log_verbose "Making AppImage executable"
      # Make the AppImage executable
      chmod +x "$COMPILED_DIR/$APPNAME-x86_64.AppImage"
      log_verbose "AppImage size: $(du -h "$COMPILED_DIR/$APPNAME-x86_64.AppImage" | cut -f1)"
    else
      echo -e "${RED}Failed to create AppImage for $APPNAME${NC}"
    fi
  fi
done

log_verbose "Processed $SCRIPT_COUNT script(s)"

# Check if any AppImages were created
log_verbose "Checking for created AppImages in $COMPILED_DIR"
if ls "$COMPILED_DIR"/*.AppImage 1> /dev/null 2>&1; then
  APPIMAGE_COUNT=$(ls -1 "$COMPILED_DIR"/*.AppImage | wc -l)
  echo -e "${GREEN}All AppImages have been created successfully!${NC}"
  echo -e "${YELLOW}$APPIMAGE_COUNT AppImage(s) are located in: $COMPILED_DIR${NC}"
  log_verbose "Created AppImages: $(ls -1 "$COMPILED_DIR"/*.AppImage)"
else
  echo -e "${RED}No AppImages were created. Please check the errors above.${NC}"
fi 