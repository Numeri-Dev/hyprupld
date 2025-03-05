# Maintainer: Your Name <your.email@example.com>
pkgname=hyprupld
pkgver=r0.g0000000
pkgrel=1
pkgdesc="A simple screenshot and file uploader for Hyprland"
arch=('any')
url="https://github.com/PhoenixAceVFX/hyprupld"
license=('GPL2')
depends=('curl' 'xclip' 'fyi' 'zenity' 'jq' 'imagemagick')
makedepends=('git')
source=("$pkgname::git+https://github.com/PhoenixAceVFX/hyprupld.git")
sha256sums=('SKIP')

pkgver() {
    cd "$srcdir/$pkgname"
    printf "r%s.g%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

prepare() {
    cd "$srcdir/$pkgname"
    chmod +x compile.sh install_scripts.sh
    
    # Create AppStream metadata directory
    mkdir -p "$srcdir/$pkgname/appdata"
    
    # Create AppStream metadata file
    cat > "$srcdir/$pkgname/appdata/hyprupld.appdata.xml" << 'EOL'
<?xml version="1.0" encoding="UTF-8"?>
<component type="desktop-application">
  <id>io.github.phoenixacevfx.hyprupld</id>
  <name>HyprUpld</name>
  <summary>A simple screenshot and file uploader for Hyprland</summary>
  <metadata_license>GPL-2.0</metadata_license>
  <project_license>GPL-2.0</project_license>
  <description>
    <p>
      Complex scripts that have a wide spectrum of support for image uploading.
      Supports multiple desktop environments and upload services.
    </p>
  </description>
  <categories>
    <category>Utility</category>
  </categories>
  <url type="homepage">https://github.com/PhoenixAceVFX/hyprupld</url>
  <url type="bugtracker">https://github.com/PhoenixAceVFX/hyprupld/issues</url>
  <developer_name>PhoenixAceVFX</developer_name>
</component>
EOL
}

build() {
    cd "$srcdir/$pkgname"
    # Unset SOURCE_DATE_EPOCH to avoid conflicts with AppImage build
    unset SOURCE_DATE_EPOCH
    ./compile.sh
}

package() {
    cd "$srcdir/$pkgname"
    
    # Create the installation directories
    install -dm755 "$pkgdir/usr/local/bin"
    install -dm755 "$pkgdir/usr/share/$pkgname"
    install -dm755 "$pkgdir/usr/share/metainfo"
    
    # Install AppStream metadata
    install -Dm644 "appdata/hyprupld.appdata.xml" "$pkgdir/usr/share/metainfo/hyprupld.appdata.xml"
    
    # Run the install script with custom INSTALL_DIR
    INSTALL_DIR="$pkgdir/usr/local/bin" ./install_scripts.sh
    
    # Install documentation
    install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
    
    # Install config directories
    install -dm755 "$pkgdir/etc/hyprupld"
    install -dm755 "$pkgdir/usr/share/$pkgname/config"
} 