# Configuration Management

## Objective

The objective of this component is to define the standard method for persisting, tracking, and restoring the configurations and scripts that form the Project Kintsugi environment.

## Scope

The configuration management scope includes:
* Hyprland configurations and related workflow scripts
* Waybar configurations and scripts
* Notification daemon (Mako) configurations
* Application launcher (Fuzzel) configurations
* User-level systemd services and timers
* Wallpapers and visual resources required by the desktop session

The scope explicitly excludes:
* Personal user data (documents, projects)
* Sensitive credentials or API tokens
* System-wide configurations located outside the user's `$HOME` directory.

## Architecture

The project uses a symlink-based deployment architecture managed by `GNU Stow`.

The source of truth for all configurations is the `dotfiles/` directory located within the `Project-Kintsugi` Git repository. 

Stow mirrors the directory structure inside each package directory to the target environment (the user's `$HOME` directory). Modifying a configuration file in its standard `~/.config/` location directly edits the file tracked in the repository.

Sensitive data is strictly excluded from version control and is loaded dynamically from untracked environmental files during script execution.

## Validation

The implementation was validated by:

* Inspecting the target directories (e.g., ls -la ~/.config/hypr) and verifying that valid symbolic links were created.
* Confirming that the Hyprland session, Waybar interfaces, and systemd user services continued to operate correctly using the symbolically linked configurations.
* Verifying that the Git repository correctly tracked the new structures without exposing sensitive local data.

## Results

The core system configurations have been successfully decoupled from the local machine state and are now centrally managed, modular, and version-controlled.