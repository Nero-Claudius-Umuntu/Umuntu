#!/bin/bash

# Umuntu Calamares Diagnostic Script - Nero Claudius Edition
# "Umu! ¡Qué hermoso es este diagnóstico!" - Nero Claudius

set -e

# Colors for output
RED='\033[0;31m'
GOLD='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
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

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to check if running from live environment
check_live_environment() {
    print_status "Checking live environment..."
    
    if [ -f "/etc/lsb-release" ]; then
        local distro=$(grep DISTRIB_ID /etc/lsb-release | cut -d= -f2)
        print_info "Running on: $distro"
    fi
    
    if [ -d "/cdrom" ] || [ -d "/media/cdrom" ] || [ -d "/mnt/cdrom" ]; then
        print_success "Live environment detected"
        return 0
    else
        print_warning "Not running in live environment"
        return 1
    fi
}

# Function to check filesystem.squashfs locations
check_filesystem_locations() {
    print_status "Checking filesystem.squashfs locations..."
    
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
    
    local found_locations=()
    
    for location in "${possible_locations[@]}"; do
        if [ -f "$location" ]; then
            found_locations+=("$location")
            print_success "Found: $location"
        fi
    done
    
    if [ ${#found_locations[@]} -eq 0 ]; then
        print_error "No filesystem.squashfs found in any expected location"
        return 1
    else
        print_info "Found ${#found_locations[@]} filesystem.squashfs file(s)"
        return 0
    fi
}

# Function to check Calamares configuration
check_calamares_config() {
    print_status "Checking Calamares configuration..."
    
    if [ -f "/etc/calamares/modules/unpackfs.conf" ]; then
        print_success "Calamares unpackfs.conf found"
        
        # Check if the configuration points to a valid file
        local source_file=$(grep "source:" /etc/calamares/modules/unpackfs.conf | head -1 | sed 's/.*source: *"\([^"]*\)".*/\1/')
        if [ -n "$source_file" ]; then
            if [ -f "$source_file" ]; then
                print_success "Source file exists: $source_file"
            else
                print_error "Source file not found: $source_file"
                return 1
            fi
        else
            print_warning "Could not determine source file from configuration"
        fi
    else
        print_error "Calamares unpackfs.conf not found"
        return 1
    fi
}

# Function to check disk space
check_disk_space() {
    print_status "Checking disk space..."
    
    local available_space=$(df / | tail -1 | awk '{print $4}')
    local available_gb=$((available_space / 1024 / 1024))
    
    print_info "Available disk space: ${available_gb}GB"
    
    if [ $available_gb -lt 5 ]; then
        print_warning "Low disk space. At least 5GB recommended for installation."
    else
        print_success "Sufficient disk space available"
    fi
}

# Function to check permissions
check_permissions() {
    print_status "Checking permissions..."
    
    if [ "$EUID" -eq 0 ]; then
        print_warning "Running as root. This may cause permission issues."
    else
        print_success "Not running as root (good for Calamares)"
    fi
    
    # Check if user can access Calamares
    if command -v calamares >/dev/null 2>&1; then
        print_success "Calamares is available"
    else
        print_error "Calamares not found"
        return 1
    fi
}

# Function to provide solutions
provide_solutions() {
    print_status "Providing solutions..."
    echo
    
    print_info "If you're having issues with unpackfs, try these solutions:"
    echo
    print_info "1. Run the fix script:"
    print_info "   sudo ./fix-unpackfs.sh"
    echo
    print_info "2. Check if the ISO is properly mounted:"
    print_info "   ls -la /cdrom/casper/"
    echo
    print_info "3. Manually create symlink:"
    print_info "   sudo mkdir -p /cdrom/casper"
    print_info "   sudo ln -s /path/to/actual/filesystem.squashfs /cdrom/casper/filesystem.squashfs"
    echo
    print_info "4. Update Calamares configuration:"
    print_info "   sudo nano /etc/calamares/modules/unpackfs.conf"
    echo
    print_info "5. Check Calamares logs:"
    print_info "   journalctl -u calamares"
    echo
}

# Function to generate report
generate_report() {
    local report_file="/tmp/umuntu-calamares-diagnostic-$(date +%Y%m%d-%H%M%S).txt"
    
    print_status "Generating diagnostic report..."
    
    {
        echo "Umuntu Calamares Diagnostic Report"
        echo "Generated: $(date)"
        echo "=================================="
        echo
        
        echo "System Information:"
        uname -a
        echo
        
        echo "Disk Space:"
        df -h
        echo
        
        echo "Mounted Filesystems:"
        mount | grep -E "(cdrom|media|mnt)"
        echo
        
        echo "Filesystem.squashfs Search:"
        find /cdrom /media /mnt -name "filesystem.squash*" 2>/dev/null || echo "No files found"
        echo
        
        echo "Calamares Configuration:"
        if [ -f "/etc/calamares/modules/unpackfs.conf" ]; then
            cat /etc/calamares/modules/unpackfs.conf
        else
            echo "Configuration file not found"
        fi
        echo
        
        echo "Calamares Logs (last 50 lines):"
        journalctl -u calamares --no-pager -n 50 2>/dev/null || echo "No logs available"
        
    } > "$report_file"
    
    print_success "Diagnostic report generated: $report_file"
}

# Main diagnostic function
main() {
    echo "🌹 Umuntu Calamares Diagnostic Script - Nero Claudius Edition 🌹"
    echo "================================================================="
    echo
    
    local issues=0
    
    # Run all checks
    if ! check_live_environment; then
        ((issues++))
    fi
    
    if ! check_filesystem_locations; then
        ((issues++))
    fi
    
    if ! check_calamares_config; then
        ((issues++))
    fi
    
    check_disk_space
    check_permissions
    
    echo
    print_status "Diagnostic completed"
    
    if [ $issues -eq 0 ]; then
        print_success "No issues found! Calamares should work correctly."
        echo
        print_success "🌹 Umu! ¡Qué hermoso es este diagnóstico! ¡Es digno de una emperatriz como yo! 🌹"
    else
        print_warning "Found $issues issue(s). See solutions below."
        echo
        provide_solutions
    fi
    
    # Generate report
    generate_report
}

# Run main function
main "$@"
