# Bill of Materials (BOM)

## Objective

The objective of this document is to track the specific system packages, user applications, and external dependencies required to reproduce the Project Kintsugi environment on top of a base Fedora installation.

This BOM explicitly excludes base operating system packages (e.g., kernel, glibc) and transient dependencies, focusing solely on the architectural choices made during the project phases.

## 1. System Packages (DNF5)

These packages form the core Wayland desktop environment and its supporting services.

### Third-Party Repositories (COPR)

* `lionheartp/Hyprland` - External repository for the Hyprland compositor
* `varlad/yazi` - External repository for the Yazi terminal file manager

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
* `keepassxc` - Offline password manager and Secret Service provider

### Development Tools & Containers

* `git` - Version control system
* `docker` - Container platform and runtime
* `docker-compose` - Multi-container orchestration tool
* `kubernetes-client` - Kubernetes command-line tool (kubectl)
* `python3` - Python runtime environment
* `gcc-c++` - GNU C++ compiler
* `make` - Build automation tool

### System Utilities & Monitoring

* `stow` - Symlink configuration manager
* `btop` / `htop` - Interactive process viewers
* `fastfetch` - System information display
* `yazi` - Terminal file manager
* `rclone` - Command-line cloud synchronization tool
* `input-remapper` - Daemon and GUI to map keyboard buttons

## 2. User Applications (Flatpak)

Applications installed via Flatpak to maintain separation from the core system packages.

* `io.dbeaver.DBeaverCommunity` - Database administration tool

## 3. External Dependencies

Assets and binaries installed outside the standard package managers.

### Manual Binaries

* `whatscli` - Terminal-based WhatsApp client
* `zed` - High-performance code editor
* `ytm-player` - Terminal-based YouTube Music player
* `fnm` - Fast Node Manager (Rust-based Node.js version manager)

### Typography

* `JetBrainsMono Nerd Font` - Primary font for terminal, Waybar, and system UI (`~/.local/share/fonts/`)

### Theming

* `BreezeDarkRed.colors` - Custom Qt/KDE color scheme (`~/.local/share/color-schemes/`)