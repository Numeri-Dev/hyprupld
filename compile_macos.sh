#!/usr/bin/env bash
#==============================================================================
# macOS .app Bundle Creation Script
#==============================================================================
# Description: Creates .app bundles from scripts in the Scripts directory
# Author: Numeri
# License: GPL-2.0
#==============================================================================

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Enable verbose output
VERBOSE=true

# Function for verbose logging
log_verbose() {
    if [ "$VERBOSE" = true ]; then
        echo -e "${BLUE}[VERBOSE] $1${NC}"
    fi
}

echo -e "${GREEN}Starting macOS .app bundle creation script${NC}"
log_verbose "Script version: 1.0"
log_verbose "Working directory: $(pwd)"

# Setup directories
WORK_DIR="$(pwd)/macos_build"
COMPILED_DIR="$(pwd)/Compiled"
log_verbose "Creating working directory: $WORK_DIR"
mkdir -p "$WORK_DIR"
log_verbose "Creating output directory: $COMPILED_DIR"
mkdir -p "$COMPILED_DIR"

# Copy scripts to build directory
echo -e "${YELLOW}Copying scripts to build directory...${NC}"
SCRIPTS_DIR="$(pwd)/Scripts"
log_verbose "Scripts directory: $SCRIPTS_DIR"
if [ ! -d "$SCRIPTS_DIR" ]; then
    echo -e "${RED}Scripts directory not found! Creating it...${NC}"
    mkdir -p "$SCRIPTS_DIR"
    echo -e "${YELLOW}Please place your scripts in the Scripts directory and run this script again.${NC}"
    exit 1
fi

# Check for icon
ICON_PATH="$(pwd)/HyprUpld.png"
log_verbose "Checking for icon at: $ICON_PATH"
if [ ! -f "$ICON_PATH" ]; then
    echo -e "${YELLOW}Icon HyprUpld.png not found in project root! Creating a placeholder icon...${NC}"
    convert -size 256x256 xc:transparent \
        -fill '#7289DA' \
        -draw 'rectangle 0,0 256,256' \
        "$ICON_PATH"
    echo -e "${GREEN}Created placeholder icon at $ICON_PATH${NC}"
fi

# Store original directory
ORIGINAL_DIR=$(pwd)
log_verbose "Storing original directory: $ORIGINAL_DIR"

# Process each script in the Scripts directory
log_verbose "Scanning Scripts directory for files to process"
SCRIPT_COUNT=0

for script in "$SCRIPTS_DIR"/*; do
    # Skip files in the Archive directory
    if [[ "$script" == *"/Archive/"* ]]; then
        log_verbose "Skipping archived script: $script"
        continue
    fi

    if [ -f "$script" ]; then
        SCRIPT_COUNT=$((SCRIPT_COUNT+1))
        SCRIPT_NAME=$(basename "$script")
        APPNAME="${SCRIPT_NAME%.*}"
        
        echo -e "${GREEN}Processing script: $SCRIPT_NAME${NC}"
        log_verbose "Script path: $script"

        # Create .app bundle structure
        APP_BUNDLE_PATH="$COMPILED_DIR/$APPNAME.app"
        CONTENTS_PATH="$APP_BUNDLE_PATH/Contents"
        MACOS_PATH="$CONTENTS_PATH/MacOS"
        RESOURCES_PATH="$CONTENTS_PATH/Resources"

        log_verbose "Creating .app bundle structure at: $APP_BUNDLE_PATH"
        mkdir -p "$MACOS_PATH"
        mkdir -p "$RESOURCES_PATH"

        # Copy script to MacOS directory
        log_verbose "Copying script to MacOS directory"
        cp "$script" "$MACOS_PATH/$APPNAME"
        chmod +x "$MACOS_PATH/$APPNAME"

        # Update version string in the copied script
        BUILD_TIMESTAMP=$(date +%Y%m%d-%H%M%S)
        VERSION_STRING="hyprupld-${BUILD_TIMESTAMP}"
        log_verbose "Setting version to: $VERSION_STRING"
        sed -i "" "s/readonly VERSION=\"hyprupld-dev\"/readonly VERSION=\"$VERSION_STRING\"/" "$MACOS_PATH/$APPNAME" || true

        # Convert PNG icon to ICNS
        if [ -f "$ICON_PATH" ]; then
            echo -e "${YELLOW}Converting icon to .icns format...${NC}"
            ICONSET="$WORK_DIR/$APPNAME.iconset"
            mkdir -p "$ICONSET"

            # Generate various icon sizes
            convert "$ICON_PATH" -resize 16x16 "$ICONSET/icon_16x16.png"
            convert "$ICON_PATH" -resize 32x32 "$ICONSET/icon_16x16@2x.png"
            convert "$ICON_PATH" -resize 32x32 "$ICONSET/icon_32x32.png"
            convert "$ICON_PATH" -resize 64x64 "$ICONSET/icon_32x32@2x.png"
            convert "$ICON_PATH" -resize 128x128 "$ICONSET/icon_128x128.png"
            convert "$ICON_PATH" -resize 256x256 "$ICONSET/icon_128x128@2x.png"
            convert "$ICON_PATH" -resize 256x256 "$ICONSET/icon_256x256.png"
            convert "$ICON_PATH" -resize 512x512 "$ICONSET/icon_256x256@2x.png"
            convert "$ICON_PATH" -resize 512x512 "$ICONSET/icon_512x512.png"
            convert "$ICON_PATH" -resize 1024x1024 "$ICONSET/icon_512x512@2x.png"

            # Create .icns file
            if command -v iconutil &> /dev/null; then
                iconutil -c icns -o "$RESOURCES_PATH/$APPNAME.icns" "$ICONSET"
            else
                echo -e "${YELLOW}iconutil not found. Icon will not be converted to .icns format.${NC}"
            fi
            rm -rf "$ICONSET"
        fi

        # Create Info.plist
        log_verbose "Creating Info.plist"
        cat > "$CONTENTS_PATH/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>$APPNAME</string>
    <key>CFBundleIconFile</key>
    <string>$APPNAME</string>
    <key>CFBundleIdentifier</key>
    <string>com.Numeri.$APPNAME</string>
    <key>CFBundleName</key>
    <string>$APPNAME</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>${VERSION_STRING}</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.10</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF

        echo -e "${GREEN}Created .app bundle: $APP_BUNDLE_PATH${NC}"
        log_verbose "Bundle size: $(du -h "$APP_BUNDLE_PATH" | cut -f1)"
    fi
done

log_verbose "Processed $SCRIPT_COUNT script(s)"

# Check if any .app bundles were created
log_verbose "Checking for created .app bundles in $COMPILED_DIR"
if ls -d "$COMPILED_DIR"/*.app 1> /dev/null 2>&1; then
    APP_COUNT=$(ls -d "$COMPILED_DIR"/*.app | wc -l)
    echo -e "${GREEN}All .app bundles have been created successfully!${NC}"
    echo -e "${YELLOW}$APP_COUNT .app bundle(s) are located in: $COMPILED_DIR${NC}"
    log_verbose "Created bundles: $(ls -d "$COMPILED_DIR"/*.app)"
else
    echo -e "${RED}No .app bundles were created. Please check the errors above.${NC}"
fi

# Return to original directory
cd "$ORIGINAL_DIR"
log_verbose "Returned to original directory: $ORIGINAL_DIR"

echo -e "${GREEN}Compilation complete!${NC}"
exit 0
