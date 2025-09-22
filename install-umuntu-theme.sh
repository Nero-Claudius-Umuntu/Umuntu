#!/bin/bash

# Umuntu Theme Installer - Nero Claudius Edition
# "Umu! ¡Qué hermoso es este instalador de tema!" - Nero Claudius

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

# Function to check if running as root
check_root() {
    if [ "$EUID" -eq 0 ]; then
        print_error "Please do not run this script as root"
        print_info "This script will ask for sudo when needed"
        exit 1
    fi
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check dependencies
check_dependencies() {
    print_status "Checking dependencies..."
    
    local deps=("sudo" "gsettings" "plymouth" "grub")
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

# Function to backup current configuration
backup_config() {
    print_status "Creating backup of current configuration..."
    
    local backup_dir="$HOME/.umuntu-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    
    # Backup current GRUB configuration
    if [ -f "/etc/default/grub" ]; then
        sudo cp /etc/default/grub "$backup_dir/grub.backup"
    fi
    
    # Backup current Plymouth theme
    if [ -f "/etc/plymouth/plymouthd.conf" ]; then
        sudo cp /etc/plymouth/plymouthd.conf "$backup_dir/plymouthd.conf.backup"
    fi
    
    print_success "Backup created in: $backup_dir"
}

# Function to install Umuntu theme
install_theme() {
    print_status "Installing Umuntu theme..."
    
    # Copy theme files
    sudo cp -r usr/share/backgrounds/* /usr/share/backgrounds/ 2>/dev/null || true
    sudo cp -r usr/share/icons/* /usr/share/icons/ 2>/dev/null || true
    sudo cp -r usr/share/sounds/* /usr/share/sounds/ 2>/dev/null || true
    sudo cp -r usr/share/plymouth/themes/* /usr/share/plymouth/themes/ 2>/dev/null || true
    sudo cp -r usr/share/neofetch/* /usr/share/neofetch/ 2>/dev/null || true
    sudo cp -r boot/grub/themes/* /boot/grub/themes/ 2>/dev/null || true
    sudo cp -r usr/share/gnome-background-properties/* /usr/share/gnome-background-properties/ 2>/dev/null || true
    
    print_success "Theme files installed"
}

# Function to configure GRUB
configure_grub() {
    print_status "Configuring GRUB theme..."
    
    if [ -d "/boot/grub/themes/umuntu" ]; then
        # Backup current GRUB configuration
        sudo cp /etc/default/grub /etc/default/grub.backup
        
        # Add Umuntu theme configuration
        if ! grep -q "GRUB_THEME" /etc/default/grub; then
            echo "GRUB_THEME=/boot/grub/themes/umuntu/theme.txt" | sudo tee -a /etc/default/grub
        fi
        
        # Update GRUB
        sudo update-grub
        
        print_success "GRUB theme configured"
    else
        print_error "GRUB theme not found"
    fi
}

# Function to configure Plymouth
configure_plymouth() {
    print_status "Configuring Plymouth theme..."
    
    if [ -d "/usr/share/plymouth/themes/umuntu-nero" ]; then
        sudo plymouth-set-default-theme umuntu-nero
        sudo update-initramfs -u
        
        print_success "Plymouth theme configured"
    else
        print_error "Plymouth theme not found"
    fi
}

# Function to configure GNOME
configure_gnome() {
    print_status "Configuring GNOME settings..."
    
    # Set wallpaper
    if [ -f "/usr/share/backgrounds/Nero-wallpaper_1.jpg" ]; then
        gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/Nero-wallpaper_1.jpg"
        gsettings set org.gnome.desktop.background picture-options "zoom"
    fi
    
    # Set icon theme
    if [ -d "/usr/share/icons/Nero-Red" ]; then
        gsettings set org.gnome.desktop.interface icon-theme "Nero-Red"
    fi
    
    # Set cursor theme
    if [ -d "/usr/share/icons/Nero-Red" ]; then
        gsettings set org.gnome.desktop.interface cursor-theme "Nero-Red"
    fi
    
    # Set sound theme
    if [ -d "/usr/share/sounds/Nero" ]; then
        gsettings set org.gnome.desktop.sound theme-name "Nero"
    fi
    
    # Set GTK theme
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    
    print_success "GNOME settings configured"
}

# Function to configure Neofetch
configure_neofetch() {
    print_status "Configuring Neofetch..."
    
    if [ -f "/usr/share/neofetch/UmuntuLogo_ascii.txt" ]; then
        mkdir -p "$HOME/.config/neofetch"
        cp /usr/share/neofetch/UmuntuLogo_ascii.txt "$HOME/.config/neofetch/"
        cp /usr/share/neofetch/config.conf "$HOME/.config/neofetch/" 2>/dev/null || true
        
        # Add to bashrc
        if ! grep -q "neofetch" "$HOME/.bashrc"; then
            echo "neofetch" >> "$HOME/.bashrc"
        fi
        
        print_success "Neofetch configured"
    else
        print_error "Neofetch theme not found"
    fi
}

# Function to show completion message
show_completion() {
    print_status "Installation completed successfully!"
    echo
    print_info "🌹 Umuntu - Nero Claudius Edition Theme Installed! 🌹"
    echo
    print_info "What was installed:"
    print_info "  • GRUB theme with Nero's colors"
    print_info "  • Plymouth boot theme"
    print_info "  • GNOME desktop customization"
    print_info "  • Nero sound theme"
    print_info "  • Nero icon and cursor themes"
    print_info "  • Nero wallpapers"
    print_info "  • Neofetch with Umuntu logo"
    echo
    print_info "To apply all changes, please reboot your system."
    echo
    print_success "🌹 Umu! ¡Qué hermoso es este sistema! ¡Es digno de una emperatriz como yo! 🌹"
}

# Main installation function
main() {
    echo "🌹 Umuntu Theme Installer - Nero Claudius Edition 🌹"
    echo "====================================================="
    echo
    
    check_root
    check_dependencies
    backup_config
    install_theme
    configure_grub
    configure_plymouth
    configure_gnome
    configure_neofetch
    show_completion
}

# Run main function
main "$@"
