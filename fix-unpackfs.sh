#!/bin/bash

# Umuntu UnpackFS Fix Script - Nero Claudius Edition
# "Umu! ¡Qué hermoso es este fix!" - Nero Claudius

set -e

# Colors for output
RED='\033[0;31m'
GOLD='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Function to find filesystem.squashfs
find_filesystem() {
    print_status "Searching for filesystem.squashfs..."
    
    local possible_locations=(
        "/cdrom/casper/filesystem.squashfs"
        "/cdrom/casper/filesystem.squash"
        "/cdrom/live/filesystem.squashfs"
        "/cdrom/live/filesystem.squash"
        "/media/cdrom/casper/filesystem.squashfs"
        "/media/cdrom/casper/filesystem.squash"
        "/media/cdrom/live/filesystem.squashfs"
        "/media/cdrom/live/filesystem.squash"
        "/mnt/cdrom/casper/filesystem.squashfs"
        "/mnt/cdrom/casper/filesystem.squash"
        "/mnt/cdrom/live/filesystem.squashfs"
        "/mnt/cdrom/live/filesystem.squash"
    )
    
    for location in "${possible_locations[@]}"; do
        if [ -f "$location" ]; then
            print_success "Found filesystem.squashfs at: $location"
            echo "$location"
            return 0
        fi
    done
    
    print_error "filesystem.squashfs not found in any expected location"
    return 1
}

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="/cdrom/casper/filesystem.squashfs"
    
    print_status "Creating symlink from $source to $target"
    
    # Create directory if it doesn't exist
    sudo mkdir -p "$(dirname "$target")"
    
    # Remove existing symlink if it exists
    if [ -L "$target" ]; then
        sudo rm "$target"
    fi
    
    # Create symlink
    sudo ln -s "$source" "$target"
    
    print_success "Symlink created successfully"
}

# Function to update Calamares configuration
update_calamares_config() {
    local filesystem_path="$1"
    
    print_status "Updating Calamares configuration..."
    
    # Create backup
    sudo cp /etc/calamares/modules/unpackfs.conf /etc/calamares/modules/unpackfs.conf.backup
    
    # Update configuration
    cat > /tmp/unpackfs.conf << EOF
---
# Umuntu UnpackFS Configuration - Nero Claudius Edition
# "Umu! ¡Qué hermoso es este unpackfs!" - Nero Claudius

unpack:
    -   source: "$filesystem_path"
        sourcefs: "squashfs"
        destination: ""
        exclude:
            - "boot/*"
            - "dev/*"
            - "proc/*"
            - "run/*"
            - "sys/*"
            - "tmp/*"
            - "var/log/*"
            - "var/cache/apt/archives/*"
            - "var/lib/apt/lists/*"
EOF
    
    sudo mv /tmp/unpackfs.conf /etc/calamares/modules/unpackfs.conf
    
    print_success "Calamares configuration updated"
}

# Function to verify installation
verify_installation() {
    print_status "Verifying installation..."
    
    if [ -f "/cdrom/casper/filesystem.squashfs" ]; then
        print_success "filesystem.squashfs is accessible at expected location"
        return 0
    else
        print_error "filesystem.squashfs is not accessible at expected location"
        return 1
    fi
}

# Main function
main() {
    echo "🌹 Umuntu UnpackFS Fix Script - Nero Claudius Edition 🌹"
    echo "========================================================"
    echo
    
    # Find filesystem.squashfs
    local filesystem_path
    if filesystem_path=$(find_filesystem); then
        # Create symlink
        create_symlink "$filesystem_path"
        
        # Update Calamares configuration
        update_calamares_config "$filesystem_path"
        
        # Verify installation
        if verify_installation; then
            print_success "UnpackFS fix completed successfully!"
            echo
            print_info "The filesystem.squashfs is now accessible at the expected location"
            print_info "Calamares should now be able to unpack the filesystem correctly"
            echo
            print_success "🌹 Umu! ¡Qué hermoso es este fix! ¡Es digno de una emperatriz como yo! 🌹"
        else
            print_error "Verification failed. Please check the installation manually."
            exit 1
        fi
    else
        print_error "Could not find filesystem.squashfs. Please check your ISO."
        exit 1
    fi
}

# Run main function
main "$@"
