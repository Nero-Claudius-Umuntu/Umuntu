#!/bin/bash
# Post-installation script for Umuntu
# This script configures the system after installation

set -e

echo "Starting post-installation configuration..."

# Configure locale
echo "Configuring system locale..."
if [ -f /etc/calamares/scripts/setup-locale.sh ]; then
    chmod +x /etc/calamares/scripts/setup-locale.sh
    /etc/calamares/scripts/setup-locale.sh
fi

# Update package database
echo "Updating package database..."
apt-get update

# Install additional packages
echo "Installing additional packages..."
apt-get install -y grub-efi-amd64 grub-efi-amd64-signed shim-signed

# Configure GRUB
echo "Configuring GRUB..."
if [ -d /boot/efi ]; then
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Umuntu --recheck
else
    grub-install --target=i386-pc /dev/sda
fi

# Update GRUB configuration
echo "Updating GRUB configuration..."
update-grub

# Configure initramfs
echo "Configuring initramfs..."
update-initramfs -u

# Set up user directories
echo "Setting up user directories..."
if [ -n "$USER" ]; then
    mkdir -p /home/$USER/{Desktop,Documents,Downloads,Music,Pictures,Videos}
    chown -R $USER:$USER /home/$USER
fi

# Configure system services
echo "Configuring system services..."
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups

# Clean up
echo "Cleaning up..."
apt-get autoremove -y
apt-get autoclean

echo "Post-installation configuration completed successfully!"
