# Development Guide

Information for developers and contributors working on HyprUpld, including setup, coding standards, and contribution guidelines.

## Overview

HyprUpld is an open-source project that welcomes contributions from the community. This guide provides information for developers who want to contribute to the project, understand the codebase, or set up a development environment.

## Project Structure

### Repository Layout
```
hyprupld/
├── Scripts/
│   └── hyprupld.sh          # Main script (1944 lines)
├── sounds/                  # Sound files
│   ├── sstaken.mp3         # Screenshot taken sound
│   ├── clipboard.mp3       # Clipboard copy sound
│   └── link.mp3            # URL copy sound
├── docs/                    # Documentation
│   ├── README.md           # Documentation index
│   ├── QUICK_START.md      # Quick start guide
│   ├── INSTALLATION.md     # Installation guide
│   ├── COMMAND_REFERENCE.md # Command reference
│   ├── CONFIGURATION.md    # Configuration guide
│   ├── UPLOAD_SERVICES.md  # Upload services guide
│   ├── DESKTOP_SUPPORT.md  # Desktop environment support
│   ├── TROUBLESHOOTING.md  # Troubleshooting guide
│   ├── DEBUG_GUIDE.md      # Debug guide
│   ├── DEVELOPMENT.md      # This file
│   └── API_REFERENCE.md    # API reference
├── install.sh              # Installation script
├── install_macos.sh        # macOS installation script
├── compile.sh              # Compilation script
├── install_scripts.sh      # Script installation
├── cleanup.sh              # Cleanup script
├── PKGBUILD                # Arch Linux package build
├── PKGBUILD.sh             # PKGBUILD generation script
├── LICENSE                 # GPL-2.0 license
├── README.md               # Main README
├── CONTRIBUTING.md         # Contributing guidelines
└── CODE_OF_CONDUCT.md      # Code of conduct
```

### Key Files

#### Main Script (`Scripts/hyprupld.sh`)
- **Lines**: 1944
- **Language**: Bash
- **Purpose**: Core functionality
- **Key Sections**:
  - Configuration and constants (lines 1-150)
  - Function definitions (lines 151-800)
  - Main execution logic (lines 801-1944)

#### Configuration Files
- `install.sh` - Linux installation script
- `install_macos.sh` - macOS installation script
- `compile.sh` - Build and compilation script
- `PKGBUILD` - Arch Linux package definition

## Development Environment Setup

### Prerequisites

#### Required Tools
```bash
# Core development tools
git
bash (version 4.0+)
python3
curl

# Testing tools
shellcheck  # For bash script linting
```

#### Optional Tools
```bash
# Additional development tools
jq          # JSON processing (alternative to python3)
zenity      # GUI dialogs for testing
```

### Setting Up Development Environment

#### 1. Clone Repository
```bash
git clone https://github.com/PhoenixAceVFX/hyprupld.git
cd hyprupld
```

#### 2. Install Development Dependencies

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install shellcheck python3 curl zenity
```

**Arch Linux:**
```bash
sudo pacman -S shellcheck python3 curl zenity
```

**Fedora:**
```bash
sudo dnf install ShellCheck python3 curl zenity
```

**macOS:**
```bash
brew install shellcheck python3 curl
```

#### 3. Set Up Testing Environment
```bash
# Create test configuration directory
mkdir -p ~/.config/hyprupld-test

# Set up test environment variables
export HYPRUPLD_CONFIG="$HOME/.config/hyprupld-test"
export HYPRUPLD_DEBUG=1
```

#### 4. Install Script for Development
```bash
# Make script executable
chmod +x Scripts/hyprupld.sh

# Create symlink for development
sudo ln -sf "$(pwd)/Scripts/hyprupld.sh" /usr/local/bin/hyprupld-dev
```

## Code Standards

### Bash Scripting Standards

#### General Guidelines
1. **Use Bash 4.0+ features** when available
2. **Follow POSIX standards** for maximum compatibility
3. **Use meaningful variable names** in lowercase with underscores
4. **Comment complex logic** with clear explanations
5. **Use functions** to organize code logically

#### Variable Naming
```bash
# Good
readonly CONFIG_DIR="${HOME}/.config/hyprupld"
local screenshot_file="/tmp/screenshot.png"
declare -a package_managers

# Bad
readonly CONFIGDIR="${HOME}/.config/hyprupld"
local sf="/tmp/screenshot.png"
declare -a pkgmgrs
```

#### Function Naming
```bash
# Good
take_screenshot() {
    # Function implementation
}

check_system_requirements() {
    # Function implementation
}

# Bad
takeScreenshot() {
    # Function implementation
}

checkSystemRequirements() {
    # Function implementation
}
```

#### Error Handling
```bash
# Use set -e for error handling
set -o errexit
set -o nounset
set -o pipefail

# Use trap for cleanup
trap cleanup_on_exit EXIT
trap cleanup_on_error ERR

# Check command exit codes
if ! command -v tool &>/dev/null; then
    log_error "Tool not found"
    exit 1
fi
```

#### Logging Standards
```bash
# Use consistent logging format
log_debug() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S.%3N')
    local line_number="${BASH_LINENO[0]}"
    local calling_function="${FUNCNAME[1]:-main}"
    echo -e "${COLOR_GRAY}[DEBUG][${timestamp}][${calling_function}:${line_number}]${COLOR_RESET} $1"
}
```

### Documentation Standards

#### Code Comments
```bash
# Function header comment
# Take a screenshot based on the desktop environment
# Arguments: None
# Returns: 0 on success, 1 on failure
take_screenshot() {
    # Implementation
}

# Inline comments for complex logic
# Check if running under UWSM managed session
if systemctl --user is-active uwsm.service >/dev/null 2>&1; then
    is_uwsm_session=true
    log_debug "Detected UWSM managed session"
fi
```

#### README Documentation
- Use clear, concise language
- Include code examples
- Provide troubleshooting information
- Keep documentation up to date

## Testing

### Manual Testing

#### Basic Functionality Tests
```bash
# Test basic screenshot
hyprupld-dev

# Test with debug mode
hyprupld-dev -debug

# Test upload service
hyprupld-dev -imgur

# Test save functionality
hyprupld-dev -s

# Test silent mode
hyprupld-dev -silent
```

#### Platform-Specific Tests

**Linux Testing:**
```bash
# Test on different desktop environments
XDG_CURRENT_DESKTOP=GNOME hyprupld-dev -debug
XDG_CURRENT_DESKTOP=KDE hyprupld-dev -debug
XDG_CURRENT_DESKTOP=hyprland hyprupld-dev -debug

# Test on different display servers
WAYLAND_DISPLAY=wayland-0 hyprupld-dev -debug
DISPLAY=:0 hyprupld-dev -debug
```

**macOS Testing:**
```bash
# Test macOS functionality
hyprupld-dev -debug
hyprupld-dev -imgur
hyprupld-dev -s
```

#### Error Condition Tests
```bash
# Test missing dependencies
PATH="/usr/bin:/bin" hyprupld-dev -debug

# Test network failures
# Disconnect network and test upload

# Test permission issues
chmod 000 ~/.config/hyprupld/settings.json
hyprupld-dev -debug
chmod 600 ~/.config/hyprupld/settings.json
```

### Automated Testing

#### Shell Script Linting
```bash
# Run shellcheck on the main script
shellcheck Scripts/hyprupld.sh

# Run shellcheck on all bash scripts
find . -name "*.sh" -exec shellcheck {} \;
```

#### Syntax Checking
```bash
# Check bash syntax
bash -n Scripts/hyprupld.sh

# Check for common bash issues
bash -v Scripts/hyprupld.sh
```

#### Unit Testing (Manual)
```bash
# Test individual functions
source Scripts/hyprupld.sh

# Test specific functions
detect_display_server
check_system_requirements
take_screenshot
```

### Test Scripts

#### Create Test Script
```bash
#!/bin/bash
# test-hyprupld.sh

set -e

echo "Running HyprUpld tests..."

# Test 1: Basic functionality
echo "Test 1: Basic screenshot"
hyprupld-dev -silent
echo "✓ Basic screenshot test passed"

# Test 2: Debug mode
echo "Test 2: Debug mode"
hyprupld-dev -debug -silent
echo "✓ Debug mode test passed"

# Test 3: Upload service
echo "Test 3: Upload service"
hyprupld-dev -imgur -silent
echo "✓ Upload service test passed"

# Test 4: Save functionality
echo "Test 4: Save functionality"
hyprupld-dev -s -silent
echo "✓ Save functionality test passed"

echo "All tests passed!"
```

## Debugging Development

### Development Debug Mode
```bash
# Enable development debug mode
export HYPRUPLD_DEBUG=1
export HYPRUPLD_CONFIG="$HOME/.config/hyprupld-dev"

# Run with development configuration
hyprupld-dev -debug
```

### Debug Logs
```bash
# Monitor debug logs during development
tail -f ~/.config/hyprupld-dev/debug.log

# Search for specific patterns
grep "function_name" ~/.config/hyprupld-dev/debug.log
grep "ERROR" ~/.config/hyprupld-dev/debug.log
```

### Common Development Issues

#### Permission Issues
```bash
# Fix script permissions
chmod +x Scripts/hyprupld.sh

# Fix configuration directory permissions
chmod 755 ~/.config/hyprupld-dev
chmod 600 ~/.config/hyprupld-dev/settings.json
```

#### Path Issues
```bash
# Check if script is in PATH
which hyprupld-dev

# Add current directory to PATH for testing
export PATH="$PWD/Scripts:$PATH"
```

#### Configuration Issues
```bash
# Reset development configuration
rm -rf ~/.config/hyprupld-dev
mkdir -p ~/.config/hyprupld-dev

# Test with clean configuration
hyprupld-dev -debug
```

## Contributing

### Contribution Workflow

#### 1. Fork and Clone
```bash
# Fork the repository on GitHub
# Clone your fork
git clone https://github.com/your-username/hyprupld.git
cd hyprupld

# Add upstream remote
git remote add upstream https://github.com/PhoenixAceVFX/hyprupld.git
```

#### 2. Create Feature Branch
```bash
# Create and switch to feature branch
git checkout -b feature/your-feature-name

# Or create bugfix branch
git checkout -b fix/your-bug-description
```

#### 3. Make Changes
```bash
# Make your changes
# Test thoroughly
# Update documentation if needed

# Stage changes
git add Scripts/hyprupld.sh
git add docs/  # If documentation was updated

# Commit with descriptive message
git commit -m "Add feature: description of what was added

- Detailed description of changes
- Any breaking changes
- Testing performed"
```

#### 4. Test Changes
```bash
# Run tests
./test-hyprupld.sh

# Test on different platforms if possible
# Test with different desktop environments
```

#### 5. Push and Create Pull Request
```bash
# Push to your fork
git push origin feature/your-feature-name

# Create pull request on GitHub
# Include detailed description of changes
# Include test results
```

### Code Review Guidelines

#### Before Submitting
1. **Test thoroughly** on multiple platforms
2. **Follow coding standards** outlined above
3. **Update documentation** if needed
4. **Add tests** for new functionality
5. **Check for security issues**

#### Pull Request Requirements
1. **Clear description** of changes
2. **Test results** from different platforms
3. **Screenshots** for UI changes (if applicable)
4. **Documentation updates** (if needed)
5. **No breaking changes** without discussion

### Contribution Areas

#### High Priority
- **Bug fixes** for existing functionality
- **Security improvements**
- **Performance optimizations**
- **Documentation improvements**

#### Medium Priority
- **New upload services**
- **Desktop environment support**
- **Feature enhancements**
- **Testing improvements**

#### Low Priority
- **Cosmetic changes**
- **Minor optimizations**
- **Additional tools support**

## Release Process

### Version Management
```bash
# Current version format
VERSION="hyprupld-dev"  # Development version
VERSION="hyprupld-20240115-143022"  # Release version
```

### Release Checklist
1. **Update version** in script
2. **Test thoroughly** on all supported platforms
3. **Update documentation** if needed
4. **Create release notes**
5. **Tag release** in git
6. **Create GitHub release**
7. **Update package managers** (if applicable)

### Release Script
```bash
#!/bin/bash
# release.sh

set -e

# Get version from user
read -p "Enter version (e.g., 20240115-143022): " VERSION

# Update version in script
sed -i "s/VERSION=.*/VERSION=\"hyprupld-${VERSION}\"/" Scripts/hyprupld.sh

# Test the release
./test-hyprupld.sh

# Commit version change
git add Scripts/hyprupld.sh
git commit -m "Release version hyprupld-${VERSION}"

# Tag release
git tag -a "v${VERSION}" -m "Release version ${VERSION}"

# Push changes
git push origin main
git push origin "v${VERSION}"

echo "Release ${VERSION} created successfully!"
```

## Security Considerations

### Code Security
1. **Validate all inputs** from users
2. **Sanitize file paths** and URLs
3. **Use secure methods** for storing credentials
4. **Avoid command injection** vulnerabilities
5. **Check file permissions** before operations

### Security Testing
```bash
# Test with malicious inputs
hyprupld-dev -debug -zipline "'; rm -rf /; '" "malicious_key"

# Test file path injection
hyprupld-dev -debug -s  # Try to select malicious path

# Test credential handling
# Check if credentials are logged in debug mode
```

## Performance Optimization

### Profiling
```bash
# Profile script execution
time hyprupld-dev -debug

# Profile specific functions
bash -x hyprupld-dev -debug 2>&1 | grep "real\|user\|sys"

# Monitor resource usage
/usr/bin/time -v hyprupld-dev -debug
```

### Optimization Areas
1. **Reduce external command calls**
2. **Cache frequently used data**
3. **Optimize file operations**
4. **Minimize network requests**
5. **Use efficient data structures**

## Documentation Development

### Documentation Standards
1. **Keep documentation up to date** with code changes
2. **Use clear, concise language**
3. **Include code examples**
4. **Provide troubleshooting information**
5. **Cross-reference related sections**

### Documentation Testing
```bash
# Check for broken links in documentation
find docs/ -name "*.md" -exec grep -l "\[.*\](" {} \; | while read file; do
    grep -o "\[.*\]([^)]*)" "$file" | while read link; do
        # Extract URL and test
        url=$(echo "$link" | sed 's/.*(\([^)]*\)).*/\1/')
        if [[ "$url" != http* ]]; then
            if [[ ! -f "docs/$url" ]]; then
                echo "Broken link in $file: $url"
            fi
        fi
    done
done
```

## Community Guidelines

### Communication
1. **Be respectful** and professional
2. **Provide constructive feedback**
3. **Help other contributors**
4. **Follow the code of conduct**

### Getting Help
1. **Check existing documentation**
2. **Search existing issues**
3. **Create detailed bug reports**
4. **Provide reproduction steps**

### Recognition
- **Contributors** are recognized in the README
- **Significant contributions** are acknowledged in release notes
- **Long-term contributors** may be invited to join the maintainer team

---

**Note**: This development guide is a living document. Please update it as the project evolves and new best practices emerge. 