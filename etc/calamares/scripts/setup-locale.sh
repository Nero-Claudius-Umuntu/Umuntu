#!/bin/bash
# Setup locale script for Umuntu
# This script configures the system locale and language settings

set -e

# Default locale (English for maximum compatibility)
DEFAULT_LOCALE="en_US.UTF-8"

# Detect system locale and set appropriate fallback
if [ -n "$LANG" ]; then
    SYSTEM_LOCALE="$LANG"
else
    SYSTEM_LOCALE="$DEFAULT_LOCALE"
fi

# Configure locale
echo "Configuring system locale..."

# Generate locale if it doesn't exist
if ! locale -a | grep -q "en_US.utf8"; then
    echo "Generating en_US.UTF-8 locale..."
    locale-gen en_US.UTF-8
fi

# Set default locale
echo "LANG=$DEFAULT_LOCALE" > /etc/default/locale
echo "LANGUAGE=$DEFAULT_LOCALE" >> /etc/default/locale
echo "LC_ALL=$DEFAULT_LOCALE" >> /etc/default/locale

# Update locale
update-locale LANG=$DEFAULT_LOCALE
update-locale LANGUAGE=$DEFAULT_LOCALE

# Configure keyboard layout (default to US English)
echo "Configuring keyboard layout..."
echo "XKBMODEL=\"pc105\"" > /etc/default/keyboard
echo "XKBLAYOUT=\"us\"" >> /etc/default/keyboard
echo "XKBVARIANT=\"\"" >> /etc/default/keyboard
echo "XKBOPTIONS=\"\"" >> /etc/default/keyboard

# Configure timezone (default to UTC)
echo "Configuring timezone..."
echo "UTC" > /etc/timezone
ln -sf /usr/share/zoneinfo/UTC /etc/localtime

echo "Locale configuration completed successfully!"
