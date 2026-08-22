# 25 - Automated Bootstrap Procedure

## Objective

The objective of this document is to define the exact, step-by-step procedure required to reproduce the Project Kintsugi environment starting from a fresh Fedora KDE Plasma installation.

## Prerequisites

* A base installation of Fedora Linux (KDE Plasma spin).
* An active internet connection.
* The user must have `sudo` privileges.

## Procedure

The reproduction process has been automated through a modular bash script that handles system packages, Flatpak applications, external dependencies, and GNU Stow dotfile deployment.

To execute the bootstrap procedure, perform the following steps from the default KDE Plasma session:

**1. Install Git**

The base system requires Git to clone the project repository.

```bash
sudo dnf5 install -y git
```

**2. Clone the Repository**

The project structure assumes the repository is located within a `projects` directory in the user's home folder.

```bash
mkdir -p ~/projects
git clone <repository_url> ~/projects/Project-Kintsugi
```

(Note: Replace <repository_url> with the actual remote origin once the project is published, or copy the repository directory directly if restoring from a local backup).

**3. Execute the Bootstrap Script**

Navigate to the project root and execute the automated orchestrator. The script is idempotent and will prompt for `sudo` credentials when updating the system and installing packages.

```bash
cd ~/projects/Project-Kintsugi
./scripts/bootstrap.sh
```

**4. Reboot**

Once the script reports `[INFO] Bootstrap completed successfully`, reboot the system to ensure all kernel updates, D-Bus services, and udev rules are properly applied.

```bash
systemctl reboot
```

## Validation

Upon reboot, SDDM will present the login screen.

1. Select Hyprland from the session menu in SDDM.
2. Log in using the user credentials.
3. Verify that the Kintsugi visual identity (wallpapers, Waybar, Fuzzel) is active and that the configured keybindings (Super + T for Kitty) operate correctly.


## Results

The manual configuration and validation work performed throughout Phases 1 to 5 has been successfully converted into repeatable Infrastructure as Code (IaC). The system can now be completely restored from a single script execution.