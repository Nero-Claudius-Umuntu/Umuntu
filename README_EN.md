# 🌹 Umuntu - Nero Claudius Edition

[English Version](README_EN.md) | [Versión en Español](README.md)

> *"Umu! How beautiful this system is!"* - Nero Claudius

A themed Linux distribution based on Ubuntu 24.04 LTS, completely customized with the **Nero Claudius** theme from the Fate/Extra series. A unique user experience that combines Ubuntu's stability with the imperial elegance of the Empress of Rome.

## ✨ Main Features

### 🎨 **Complete Visual Theme**
- **Wallpapers**: Over 40 exclusive Nero Claudius wallpapers
- **Custom Icons**: Themed cursor sets (Nero-Black, Nero-Dark, Nero-Red, Nero-White)
- **GRUB Theme**: Custom bootloader with themed background
- **Plymouth**: Boot screens with Umuntu logo
- **Neofetch**: Custom Nero ASCII art

### 🔊 **Audio Experience**
- **Sound Effects**: Custom "Nero" audio theme for system notifications and events
- **Boot Sounds**: Themed audio on system startup

### 🖼️ **Wallpapers**
- Nero in different poses and situations
- Nero Bride variants
- Battle and rest scenes
- Fate/Extra community artwork
- Animated video backgrounds

### ⚙️ **Custom Configurations**
- **Burn-my-windows**: Themed transition effects
- **GNOME Tweaks**: Custom shell configurations
- **Thumbnailers**: Support for STL files and X11 cursors

## 🚀 Installation

### Prerequisites
- Ubuntu 24.04 LTS as base
- Linux Live Kit
- Calamares Installer
- At least 4GB RAM
- 20GB free disk space

### Build Process
1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/Umuntu.git
   cd Umuntu
   ```

2. **Prepare the environment**:
   ```bash
   # Install necessary dependencies
   sudo apt update
   sudo apt install linux-live calamares
   ```

3. **Build the ISO**:
   ```bash
   # Run the build script (coming soon)
   ./build-umuntu.sh
   ```

## 📁 Project Structure

```
Umuntu/
├── boot/grub/                    # Bootloader configuration
│   ├── themes/umuntu/           # Custom GRUB theme
│   └── fonts/                   # GRUB fonts
├── usr/share/
│   ├── backgrounds/             # Nero wallpapers
│   │   ├── video/              # Animated backgrounds
│   │   └── contest/            # Additional wallpapers
│   ├── icons/                  # Themed icons and cursors
│   │   ├── Nero-Black/
│   │   ├── Nero-Dark/
│   │   ├── Nero-Red/
│   │   └── Nero-White/
│   ├── sounds/Nero/            # Themed sound effects
│   ├── plymouth/themes/        # Boot screens
│   └── neofetch/               # Custom ASCII art
├── config/                     # Application configurations
│   ├── neofetch/
│   └── burn-my-windows/
├── etc/                        # System configurations
└── Extras/                     # Additional scripts and utilities
```

## 🎯 Technical Features

- **Base**: Ubuntu 24.04.3 LTS (Noble Numbat)
- **Desktop Environment**: GNOME (customized)
- **Kernel**: Linux 6.14.0-29-generic
- **Architecture**: x86_64
- **Estimated Size**: ~2.5GB (ISO)

## 🛠️ Development Tools

### Included Scripts
- **Thumbnailers**: Support for STL files and X11 cursors
- **Configurations**: Automation scripts for applications

### Customization
- **Logo**: Custom Umuntu SVG
- **Themes**: CSS configurations for GNOME Shell
- **Sounds**: Custom audio theme indexes

## 🎨 Screenshot Gallery

*[Screenshots of the system would go here]*

## 🤝 Contributing

Contributions are welcome! If you have ideas to improve the themed experience:

1. Fork the project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## ⚠️ Disclaimer

This is a hobby project and is not officially affiliated with:
- Type-Moon
- Fate/Extra
- Ubuntu/Canonical
- Any other commercial entity

All character rights belong to their respective owners.

## 🎭 About Nero Claudius

Nero Claudius Caesar Augustus Germanicus, simply known as Nero, is a Saber-class Servant in Fate/Extra. As the fifth emperor of the Roman Empire, she is known for her extravagant personality, love for art, and her characteristic phrase "Umu!".

## 📞 Contact

- **Project**: [GitHub Repository](https://github.com/your-username/Umuntu)
- **Issues**: [GitHub Issues](https://github.com/your-username/Umuntu/issues)

---

*"Umu! How beautiful this system is! It's worthy of an empress like me!"* 🌹

---

**Note**: This repository contains only modified files to keep the size under GitHub limits. For a complete installation, an Ubuntu 24.04 LTS base is required.
