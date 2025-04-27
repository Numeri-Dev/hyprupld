# Maintainer: Bubblegum <bubblegum@arch-linux.pro>
pkgname=hyprupld
pkgver=0.0.0.r0.gxxxxxxx
pkgrel=1
pkgdesc="Hyprland screenshot and screen recording utility"
arch=('x86_64')
url="https://github.com/PhoenixAceVFX/hyprupld"
license=('GPL2')
depends=('bash' 'fuse2' 'glib2' 'cairo' 'pango')
makedepends=('git' 'wget' 'imagemagick' 'cmake')
source=("git+$url.git")
sha256sums=('SKIP')

pkgver() {
  cd "$srcdir/$pkgname"
  git describe --long --tags | sed 's/\([^-]*-g\)/r\1/;s/-/./g' || \
  printf "0.0.0.r%s.g%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
  cd "$srcdir/$pkgname"
  chmod +x compile.sh
  ./compile.sh
}

package() {
  cd "$srcdir/$pkgname"
  
  # Create the necessary directories in the package
  install -dm755 "$pkgdir/usr/bin"
  install -dm755 "$pkgdir/usr/local/share/hyprupld/sounds"
  
  # Install the compiled AppImages to the package directory
  for binary in Compiled/*; do
    if [ -f "$binary" ]; then
      local base_name=$(basename "$binary")
      # Skip hidden files
      [[ "$base_name" == .* ]] && continue
      
      # Normalize binary name
      dest_name="${base_name/-x86_64/}"
      dest_name="${dest_name/.AppImage/}"
      
      # Install binary with appropriate permissions
      install -Dm755 "$binary" "$pkgdir/usr/bin/$dest_name"
    fi
  done
  
  # Install sound files
  if [ -d "sounds" ]; then
    install -Dm644 sounds/*.mp3 "$pkgdir/usr/local/share/hyprupld/sounds/"
  fi
}
