# Session Management Implementation

## Objective

The objective of this implementation was to establish the standard graphical session architecture for Project Kintsugi.

The implementation integrates Hyprland with systemd user services through UWSM while preserving compatibility with the official Hyprland startup mechanism.

---

## Background

Previous implementations established the core desktop infrastructure, including:

* Hyprland;
* authentication services;
* screen locking;
* desktop portals;
* screenshot utilities;
* audio infrastructure;
* network management.

The graphical session architecture required additional refinement to align the runtime environment with both Hyprland and systemd recommendations.

---

## Scope

This implementation included:

* evaluation of available session startup methods;
* validation of UWSM integration;
* validation of the official `start-hyprland` launcher;
* validation of systemd session targets;
* validation of graphical user services;
* removal of Hyprland startup warnings;
* validation of long-term session stability.

The implementation did not include:

* replacement of the display manager;
* modifications to the Fedora login infrastructure;
* removal of the existing Plasma desktop environment.

---

## Installed Components

The implementation validated the existing session infrastructure and added the following runtime dependency:

* hyprland-guiutils;
* hyprtoolkit.

The packages were installed from the same approved package source used for Hyprland.

---

## Configuration

A dedicated Wayland session entry was created to execute:

```
uwsm start -F /usr/bin/start-hyprland
```

This configuration combines UWSM session orchestration with the official Hyprland launcher.

The implementation also disabled the automatic execution of KDE's Xwayland Video Bridge within the Hyprland session to eliminate unnecessary background components inherited from the Fedora KDE installation.

---

## Integration

The resulting architecture is:

```
SDDM
 │
 ▼
UWSM
 │
 ▼
start-hyprland
 │
 ▼
Hyprland
 │
 ▼
graphical-session.target
 │
 ├── hyprpolkitagent
 ├── hypridle
 ├── mako
 ├── xdg-desktop-portal
 └── user services
```

The graphical session lifecycle is fully exposed through systemd user targets.

---

## Validation

The implementation was validated through:

* successful startup from SDDM;
* successful execution of `start-hyprland`;
* active `wayland-wm@start-hyprland.service`;
* active `graphical-session.target`;
* active Wayland session targets;
* successful Polkit authentication;
* successful Secret Service activation;
* successful desktop portal integration;
* successful user service execution;
* absence of Hyprland startup warnings.

---

## Results

The final session architecture provides:

* complete systemd integration;
* official Hyprland startup path;
* reliable user service lifecycle management;
* predictable session startup;
* modular desktop infrastructure.

---

## Known Limitations

The Fedora KDE base installation still provides certain KDE user services that may execute within the Hyprland session.

These services do not affect the functionality of the selected session architecture and will be re-evaluated if the Plasma desktop environment is removed in a future project phase.

---

## Conclusion

Session management has been successfully standardized for Project Kintsugi.

The selected architecture combines the official Hyprland launcher with systemd-managed session orchestration, providing a reliable and maintainable foundation for the remaining desktop infrastructure.