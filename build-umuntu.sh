#!/bin/bash

# Umuntu Build Script - Nero Claudius Edition
# "Umu! ¡Qué hermoso es este script de construcción!" - Nero Claudius

set -e

# Colors for output
RED='\033[0;31m'
GOLD='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
UMUNTU_VERSION="1.0.0"
BASE_ISO="ubuntu-24.04.3-desktop-amd64.iso"
WORK_DIR="/tmp/umuntu-build"
OUTPUT_DIR="./output"
ISO_NAME="umuntu-${UMUNTU_VERSION}-nero-claudius-edition.iso"

# Function to print colored output
print_status() {
    echo -e "${GOLD}[UMUNTU]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check dependencies
check_dependencies() {
    print_status "Checking dependencies..."
    
    local deps=("squashfs-tools" "genisoimage" "isohybrid" "xorriso" "7z")
    local missing_deps=()
    
    for dep in "${deps[@]}"; do
        if ! command_exists "$dep"; then
            missing_deps+=("$dep")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing dependencies: ${missing_deps[*]}"
        print_info "Install them with: sudo apt install ${missing_deps[*]}"
        exit 1
    fi
    
    print_success "All dependencies are installed"
}

# Function to create work directory
setup_work_dir() {
    print_status "Setting up work directory..."
    
    if [ -d "$WORK_DIR" ]; then
        print_info "Cleaning existing work directory..."
        sudo rm -rf "$WORK_DIR"
    fi
    
    mkdir -p "$WORK_DIR"
    mkdir -p "$OUTPUT_DIR"
    
    print_success "Work directory created: $WORK_DIR"
}

# Function to extract base ISO
extract_base_iso() {
    print_status "Extracting base ISO..."
    
    if [ ! -f "$BASE_ISO" ]; then
        print_error "Base ISO not found: $BASE_ISO"
        print_info "Please download Ubuntu 24.04.3 LTS desktop ISO and place it in the current directory"
        exit 1
    fi
    
    # Extract ISO
    7z x "$BASE_ISO" -o"$WORK_DIR/extracted" -y >/dev/null 2>&1
    
    # Extract filesystem
    print_status "Extracting filesystem..."
    sudo unsquashfs -f -d "$WORK_DIR/chroot" "$WORK_DIR/extracted/casper/filesystem.squashfs" >/dev/null 2>&1
    
    print_success "Base ISO extracted successfully"
}

# Function to copy Umuntu files
copy_umuntu_files() {
    print_status "Copying Umuntu theme files..."
    
    # Copy all Umuntu files to chroot
    sudo cp -r boot "$WORK_DIR/chroot/"
    sudo cp -r usr "$WORK_DIR/chroot/"
    sudo cp -r etc "$WORK_DIR/chroot/"
    sudo cp -r config "$WORK_DIR/chroot/"
    
    # Set proper permissions
    sudo chown -R root:root "$WORK_DIR/chroot/boot"
    sudo chown -R root:root "$WORK_DIR/chroot/usr"
    sudo chown -R root:root "$WORK_DIR/chroot/etc"
    sudo chown -R root:root "$WORK_DIR/chroot/config"
    
    print_success "Umuntu files copied successfully"
}

# Function to update package lists and install additional packages
update_packages() {
    print_status "Updating packages and installing additional software..."
    
    # Create a script to run inside chroot
    cat > "$WORK_DIR/chroot/update_packages.sh" << 'EOF'
#!/bin/bash
set -e

# Update package lists
apt update

# Install additional packages for Umuntu
apt install -y \
    neofetch \
    plymouth-themes \
    grub2-common \
    calamares \
    calamares-settings-ubuntu \
    burn-my-windows \
    gnome-tweaks \
    gnome-shell-extensions

# Clean up
apt autoremove -y
apt autoclean
EOF
    
    # Make script executable and run it
    sudo chmod +x "$WORK_DIR/chroot/update_packages.sh"
    sudo chroot "$WORK_DIR/chroot" /update_packages.sh
    
    # Clean up
    sudo rm "$WORK_DIR/chroot/update_packages.sh"
    
    print_success "Packages updated successfully"
}

# Function to configure system
configure_system() {
    print_status "Configuring Umuntu system..."
    
    # Create configuration script
    cat > "$WORK_DIR/chroot/configure_umuntu.sh" << 'EOF'
#!/bin/bash
set -e

# Set Umuntu as default distribution
echo "Umuntu ${UMUNTU_VERSION} (Nero Claudius Edition)" > /etc/os-release

# Configure GRUB theme
if [ -d "/boot/grub/themes/umuntu" ]; then
    echo "GRUB_THEME=/boot/grub/themes/umuntu/theme.txt" >> /etc/default/grub
fi

# Configure Plymouth theme
if [ -d "/usr/share/plymouth/themes/umuntu-nero" ]; then
    plymouth-set-default-theme umuntu-nero
fi

# Configure Neofetch
if [ -f "/usr/share/neofetch/UmuntuLogo_ascii.txt" ]; then
    cp /usr/share/neofetch/UmuntuLogo_ascii.txt /etc/neofetch/
fi

# Configure GNOME settings
if [ -d "/usr/share/gnome-background-properties" ]; then
    # Set Umuntu wallpapers as default
    gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/Nero-wallpaper_1.jpg"
fi

# Configure sound theme
if [ -d "/usr/share/sounds/Nero" ]; then
    gsettings set org.gnome.desktop.sound theme-name "Nero"
fi

# Configure icon theme
if [ -d "/usr/share/icons/Nero-Red" ]; then
    gsettings set org.gnome.desktop.interface icon-theme "Nero-Red"
fi

# Configure cursor theme
if [ -d "/usr/share/icons/Nero-Red" ]; then
    gsettings set org.gnome.desktop.interface cursor-theme "Nero-Red"
fi

# Update GRUB configuration
update-grub

# Update initramfs
update-initramfs -u

# Clean up
rm -f /etc/machine-id
rm -f /var/lib/dbus/machine-id
rm -f /etc/ssh/ssh_host_*
rm -f /etc/hostname
rm -f /etc/hosts
rm -f /etc/resolv.conf
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /var/log/*
rm -rf /var/cache/apt/archives/*
rm -rf /var/lib/apt/lists/*
EOF
    
    # Make script executable and run it
    sudo chmod +x "$WORK_DIR/chroot/configure_umuntu.sh"
    sudo chroot "$WORK_DIR/chroot" /configure_umuntu.sh
    
    # Clean up
    sudo rm "$WORK_DIR/chroot/configure_umuntu.sh"
    
    print_success "System configured successfully"
}

# Function to create new filesystem
create_filesystem() {
    print_status "Creating new filesystem..."
    
    # Create new squashfs with proper compression and exclusions
    sudo mksquashfs "$WORK_DIR/chroot" "$WORK_DIR/filesystem.squashfs" \
        -comp xz \
        -e boot/grub/grub.cfg \
        -e boot/grub/grubenv \
        -e dev/* \
        -e proc/* \
        -e run/* \
        -e sys/* \
        -e tmp/* \
        -e var/log/* \
        -e var/cache/apt/archives/* \
        -e var/lib/apt/lists/* \
        -e var/lib/dbus/machine-id \
        -e etc/machine-id \
        -e etc/ssh/ssh_host_* \
        >/dev/null 2>&1
    
    # Ensure casper directory exists
    sudo mkdir -p "$WORK_DIR/extracted/casper"
    
    # Copy to extracted ISO
    sudo cp "$WORK_DIR/filesystem.squashfs" "$WORK_DIR/extracted/casper/"
    
    # Update file sizes
    sudo du -sx --block-size=1 "$WORK_DIR/chroot" | cut -f1 > "$WORK_DIR/extracted/casper/filesystem.size"
    
    # Verify the file exists and is accessible
    if [ -f "$WORK_DIR/extracted/casper/filesystem.squashfs" ]; then
        print_success "New filesystem created and verified"
    else
        print_error "Failed to create filesystem.squashfs"
        exit 1
    fi
}

# Function to create new ISO
create_iso() {
    print_status "Creating Umuntu ISO..."
    
    # Generate new checksums
    cd "$WORK_DIR/extracted"
    sudo find . -type f -print0 | sudo xargs -0 md5sum | sudo tee md5sum.txt >/dev/null 2>&1
    
    # Create new ISO
    sudo xorriso -as mkisofs \
        -iso-level 3 \
        -full-iso9660-filenames \
        -volid "Umuntu ${UMUNTU_VERSION} Nero Claudius Edition" \
        -appid "Umuntu ${UMUNTU_VERSION} Nero Claudius Edition" \
        -publisher "Umuntu Team" \
        -preparer "Umuntu Build Script" \
        -eltorito-boot isolinux/isolinux.bin \
        -eltorito-catalog isolinux/boot.cat \
        -no-emul-boot \
        -boot-load-size 4 \
        -boot-info-table \
        -eltorito-alt-boot \
        -e boot/grub/efi.img \
        -no-emul-boot \
        -isohybrid-gpt-basdat \
        -isohybrid-apm-hfsplus \
        -output "$OUTPUT_DIR/$ISO_NAME" \
        . >/dev/null 2>&1
    
    cd - >/dev/null
    
    print_success "Umuntu ISO created: $OUTPUT_DIR/$ISO_NAME"
}

# Function to clean up
cleanup() {
    print_status "Cleaning up..."
    
    if [ -d "$WORK_DIR" ]; then
        sudo rm -rf "$WORK_DIR"
    fi
    
    print_success "Cleanup completed"
}

# Function to show build info
show_build_info() {
    print_status "Build completed successfully!"
    echo
    print_info "ISO: $OUTPUT_DIR/$ISO_NAME"
    print_info "Version: $UMUNTU_VERSION"
    print_info "Base: Ubuntu 24.04.3 LTS"
    print_info "Theme: Nero Claudius Edition"
    echo
    print_success "🌹 Umu! ¡Qué hermoso es este sistema! ¡Es digno de una emperatriz como yo! 🌹"
}

# Main build function
main() {
    echo "🌹 Umuntu Build Script - Nero Claudius Edition 🌹"
    echo "=================================================="
    echo
    
    check_dependencies
    setup_work_dir
    extract_base_iso
    copy_umuntu_files
    update_packages
    configure_system
    create_filesystem
    create_iso
    cleanup
    show_build_info
}

# Run main function
main "$@"
