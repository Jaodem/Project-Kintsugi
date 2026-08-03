# Status Bar Installation

## Objective

The objective of this implementation is to introduce a status bar into the Hyprland session.

The status bar provides a persistent interface for presenting desktop and system information while preserving the modular architecture established throughout Project Kintsugi.

---

## Background

Previous implementations introduced the following foundational desktop components:

* Hyprland
* Kitty
* Fuzzel
* Dolphin

The next logical step is to provide a persistent interface capable of presenting information about the current desktop session.

Following the project's evaluation process, Waybar was selected because it provides native Wayland support, direct integration with Hyprland, and is available through the official Fedora repositories.

---

## Scope

This implementation is limited to:

* installing Waybar;
* verifying its operation under Hyprland;
* introducing a minimal configuration required for validation;
* integrating Waybar into the Hyprland startup sequence;
* validating stable operation.

Visual customization, advanced modules, themes, CSS styling, and integration with additional desktop services are outside the scope of this implementation.

---

## Installation

Waybar was installed from the official Fedora repositories.

Following the project's package policy, weak dependencies were intentionally disabled during installation.

```bash
sudo dnf install --setopt=install_weak_deps=False waybar
```

The installation required the following package dependencies:

* gtk-layer-shell
* libmpdclient
* playerctl
* playerctl-libs

These packages were installed automatically as required runtime dependencies.

---

## Minimal Configuration

A minimal Waybar configuration was created to validate the component without introducing unnecessary desktop functionality.

The initial configuration includes only the modules required to verify correct operation:

* Hyprland workspaces;
* active window title;
* clock.

Additional modules will be introduced incrementally as their corresponding desktop services are evaluated and implemented throughout the project.

---

## Hyprland Integration

Waybar was integrated into the Hyprland startup sequence using the project's Lua-based configuration.

The application is started automatically when a new Hyprland session begins, ensuring that the status bar is consistently available without requiring manual execution.

---

## Validation

The implementation is considered successful when:

* Waybar installs successfully;
* the application starts correctly under Hyprland;
* the status bar remains stable throughout the session;
* workspace information is displayed correctly;
* the active window title updates correctly;
* the clock functions correctly;
* Waybar starts automatically when the Hyprland session begins.

---

## Results

Validation confirmed the following:

* Waybar was successfully installed from the official Fedora repositories.
* Required runtime dependencies were installed successfully.
* The application started correctly under Hyprland.
* A minimal configuration operated as expected.
* Workspace information was displayed correctly.
* The active window title updated correctly.
* The clock functioned correctly.
* Waybar started automatically after logging into the Hyprland session.

During validation, some graphical icons were not displayed correctly because no icon font has yet been introduced into the desktop environment.

This behavior is expected and will be addressed during the future font implementation stage.

---

## Conclusion

The implementation objective was achieved successfully.

Project Kintsugi now includes a native Wayland status bar that integrates with Hyprland while maintaining the project's incremental and modular engineering approach.

The current configuration intentionally remains minimal and will evolve alongside the implementation of additional desktop services during subsequent phases of the project.

---

## Next Step

With the status bar successfully integrated, Project Kintsugi will continue evaluating the remaining foundational desktop components following the established engineering workflow.

Future implementations will progressively extend the desktop environment while preserving the project's principles of modularity, documentation, validation, and long-term maintainability.
