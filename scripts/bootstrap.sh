#!/bin/bash

# ==============================================================================
# Project Kintsugi - Automated Installation Bootstrap
# ==============================================================================

# Fail fast: exit on error, undefined variables, or pipe failures
set -euo pipefail

# Color definitions for logging
readonly C_INFO='\033[0;32m' # Green
readonly C_ERR='\033[0;31m'  # Red
readonly C_NONE='\033[0m'    # Reset

# Calculate absolute path to the project root
readonly PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Logging utilities
log_info() { printf "${C_INFO}[INFO]${C_NONE} %s\n" "$1"; }
log_err() { printf "${C_ERR}[ERROR]${C_NONE} %s\n" "$1" >&2; }

# ==============================================================================
# Modules
# ==============================================================================

enable_repositories() {
    log_info "Enabling third-party COPR repositories..."
    
    # Enable COPR plugin for DNF5
    sudo dnf5 install -y dnf5-command-copr
    
    # Enable required external repositories for desktop and file management
    sudo dnf5 copr enable -y lionheartp/Hyprland
    sudo dnf5 copr enable -y varlad/yazi
}

install_dnf_packages() {
    log_info "Installing base system packages via DNF5..."
    
    # Core packages defined in the BOM (Phase 6.2)
    local core_packages=(
        # Compositor & Session
        hyprland hypridle hyprlock sddm sddm-wayland-plasma polkit-kde
        
        # Core Desktop Components
        waybar fuzzel mako swaybg xdg-desktop-portal-hyprland
        
        # Desktop Utilities
        kitty dolphin grimblast cliphist brightnessctl playerctl
        
        # Daily Applications
        brave-browser kwrite okular mpv keepassxc
        
        # System Utilities & Monitoring
        stow btop fastfetch yazi rclone input-remapper
    )

    log_info "Updating system repositories..."
    sudo dnf5 upgrade -y

    log_info "Installing core packages..."
    sudo dnf5 install -y "${core_packages[@]}"
}

install_flatpak_apps() {
    log_info "Installing user applications via Flatpak..."
    
    # Ensure Flathub repository is enabled
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    
    local flatpak_apps=(
        io.dbeaver.DBeaverCommunity
    )
    
    sudo flatpak install -y flathub "${flatpak_apps[@]}"
}

install_external_dependencies() {
    log_info "Installing external dependencies (manual binaries)..."
    
    # Zed Editor
    if ! command -v zed >/dev/null 2>&1; then
        log_info "Installing Zed Editor..."
        curl -f https://zed.dev/install.sh | sh
    else
        log_info "Zed Editor is already installed. Skipping."
    fi

    # Nerd Fonts
    local font_dir="$HOME/.local/share/fonts"
    if [ ! -d "$font_dir" ] || [ -z "$(ls -A "$font_dir" | grep 'NerdFont')" ]; then
        log_info "Notice: Nerd Fonts must be deployed via Stow before Waybar starts."
    fi
}

configure_wayland_session() {
    log_info "Configuring custom Wayland session for Hyprland..."
    
    local session_file="/usr/share/wayland-sessions/hyprland-kintsugi.desktop"
    
    # Create the custom Kintsugi session
    cat <<EOF | sudo tee "$session_file" > /dev/null
[Desktop Entry]
Name=Hyprland (Project Kintsugi)
Comment=Hyprland via UWSM using the official start-hyprland wrapper
Exec=/usr/bin/uwsm start -F /usr/bin/start-hyprland
Type=Application
DesktopNames=Hyprland
EOF

    # Remove the problematic default sessions silently if they exist
    sudo rm -f /usr/share/wayland-sessions/hyprland-uwsm.desktop
    sudo rm -f /usr/share/wayland-sessions/hyprland.desktop
}

deploy_dotfiles() {
    log_info "Deploying configurations using GNU Stow..."
    
    local dotfiles_dir="${PROJECT_ROOT}/dotfiles"
    
    if ! command -v stow >/dev/null 2>&1; then
        log_err "GNU Stow is not installed. Halting deployment."
        exit 1
    fi

    # Handle existing default files on a fresh install to prevent Stow conflicts
    if [ -f "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
        log_info "Backing up default .bashrc to .bashrc.bak..."
        mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
    fi

    log_info "Linking dotfiles packages..."
    cd "$dotfiles_dir"
    
    # -R (restow) ensures idempotency: it relinks safely if run multiple times
    stow -R -t ~ bash fuzzel hypr mako systemd theme waybar zed
    
    # Return to previous directory
    cd - > /dev/null
}

# ==============================================================================
# Main Execution
# ==============================================================================

main() {
    log_info "Starting Project Kintsugi automated bootstrap..."

    # Modules
    enable_repositories
    install_dnf_packages
    install_flatpak_apps
    install_external_dependencies
    configure_wayland_session
    deploy_dotfiles

    log_info "Bootstrap completed successfully."
}

# Invoke main with all arguments
main "$@"