# XDG Autostart Implementation

## Objective

The objective of this implementation was to validate and standardize the XDG Autostart infrastructure used by Project Kintsugi.

Rather than introducing additional software, the implementation focused on verifying Fedora's native implementation based on the XDG Autostart Specification and systemd.

---

## Background

Previous implementations established the graphical session, authentication, networking, desktop portals, power management, XDG infrastructure, clipboard management, and other foundational desktop services.

XDG Autostart provides the standardized mechanism used to automatically launch desktop applications during session startup.

---

## Scope

This implementation included:

- validation of the XDG Autostart Specification;
- validation of system autostart directories;
- validation of systemd-xdg-autostart-generator;
- validation of generated user services;
- validation of compatibility with the Hyprland session.

The implementation did not include:

- creating user-specific autostart entries;
- replacing Fedora's startup infrastructure;
- introducing desktop-specific startup mechanisms.

---

## Installed Components

No additional components were installed.

The implementation validated the existing Fedora infrastructure:

```text
XDG Autostart Specification
systemd-xdg-autostart-generator
systemd --user
```

---

## Integration

The validated architecture is:

```text
Applications
        │
        ▼
XDG Autostart Specification
        │
        ▼
.desktop files
        │
        ▼
systemd-xdg-autostart-generator
        │
        ▼
systemd --user
        │
        ▼
Application Processes
```

---

## Validation

The implementation was validated through:

- verification of `/etc/xdg/autostart`;
- verification that `~/.config/autostart` is not currently present;
- inspection of generated systemd user services;
- verification of desktop entry source mapping;
- successful integration with the Hyprland session.

---

## Results

The resulting implementation provides:

- standardized application autostart;
- compatibility with Fedora KDE Plasma;
- compatibility with Wayland;
- compatibility with Hyprland;
- integration with `systemd --user`;
- minimal additional system complexity.

---

## Known Limitations

The current implementation relies on system-provided desktop entries.

User-specific startup customization requires creating desktop entry files under `~/.config/autostart`.

Future changes to the systemd implementation of the XDG Autostart Specification may require re-evaluation.

---

## Conclusion

XDG Autostart has been successfully standardized for Project Kintsugi.

The validated implementation relies on Fedora's native integration between the XDG Autostart Specification and `systemd --user`, preserving the project's modular architecture and standards-based approach.