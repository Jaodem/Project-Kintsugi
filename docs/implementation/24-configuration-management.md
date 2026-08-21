# 24 - Configuration Management Installation

## Objective

The objective of this implementation is to extract the existing, validated configurations into a version-controlled repository using GNU Stow, fulfilling Phase 6.1 of the project roadmap.

## Prerequisites

* `stow` must be installed on the system.
* The Project Kintsugi repository must be initialized and available.

## Installation

GNU Stow was installed from the standard Fedora repositories:

```bash
sudo dnf5 install stow
```

## Repository Structure

The target repository structure was created to mirror the user's `~/.config/ directory`. Each component was treated as a distinct Stow package:

```
Project-Kintsugi/
├── dotfiles/
│   ├── fuzzel/.config/fuzzel/
│   ├── hypr/.config/hypr/
│   ├── mako/.config/mako/
│   ├── systemd/.config/systemd/user/
│   └── waybar/.config/waybar/
└── resources/
    └── wallpapers/
```

## Migration and Deployment

The existing validated configurations were physically moved from their live locations in `~/.config/` to their respective package directories within the repository.

Deployment was executed using GNU Stow to generate native symbolic links pointing back to the user's home directory:

```bash
cd ~/projects/Project-Kintsugi/dotfiles
stow -t ~ fuzzel hypr mako waybar systemd
```

## Sanitization

Prior to version control, all managed scripts were audited for hardcoded absolute paths and sensitive data.

Paths referencing the specific local user (e.g., `/home/username/`) were replaced with relative variables (`$HOME` or `~/`).

Interactive scripts (such as `wifi-menu.sh`) and API-dependent scripts (`weather.sh`) were validated to confirm that no credentials, tokens, or network passphrases were hardcoded into the source files.