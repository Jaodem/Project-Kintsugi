# Bill of Materials (BOM)

## Objective

The objective of this document is to track the specific system packages, user applications, and external dependencies required to reproduce the Project Kintsugi environment on top of a base Fedora installation.

This BOM explicitly excludes base operating system packages (e.g., kernel, glibc) and transient dependencies, focusing solely on the architectural choices made during the project phases.

## 1. System Packages (DNF5)

These packages form the core Wayland desktop environment and its supporting services.

### Compositor & Session

* `hyprland` - Core Wayland compositor
* `hypridle` - Idle management daemon
* `hyprlock` - Screen locker
* `sddm` - Display manager
* `sddm-wayland-plasma` - Wayland support for SDDM
* `polkit-kde` - Authentication agent

### Core Desktop Components

* `waybar` - Primary status bar presentation layer
* `fuzzel` - Application launcher and interactive menu interface
* `mako` - Notification daemon
* `swaybg` - Wallpaper backend daemon
* `xdg-desktop-portal-hyprland` - Desktop portal implementation

### Desktop Utilities

* `kitty` - Terminal emulator
* `dolphin` - Graphical file manager
* `grimblast` - Screenshot utility
* `cliphist` - Clipboard history manager
* `brightnessctl` - Hardware brightness control
* `playerctl` - MPRIS media player control

### Daily Applications

* `brave-browser` - Primary web browser
* `kwrite` - Lightweight text editor
* `okular` - Document and PDF viewer
* `mpv` - Minimalist media player

### System Utilities & Monitoring

* `stow` - Symlink configuration manager
* `btop` / `htop` - Interactive process viewers
* `fastfetch` - System information display
* `yazi` - Terminal file manager
* `rclone` - Command-line cloud synchronization tool

## 2. User Applications (Flatpak)

Applications installed via Flatpak to maintain separation from the core system packages.

* `io.dbeaver.DBeaverCommunity` - Database administration tool

## 3. External Dependencies

Assets and binaries installed outside the standard package managers.

### Manual Binaries

* `whatscli` - Terminal-based WhatsApp client
* `zed` - High-performance code editor
* `ytm-player` - Terminal-based YouTube Music player

### Typography

* `JetBrainsMono Nerd Font` - Primary font for terminal, Waybar, and system UI (`~/.local/share/fonts/`)

### Theming

* `BreezeDarkRed.colors` - Custom Qt/KDE color scheme (`~/.local/share/color-schemes/`)