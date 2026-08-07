# XDG User Directories Implementation

## Objective

The objective of this implementation was to validate and standardize the XDG User Directories infrastructure used by Project Kintsugi.

Rather than introducing new software, the implementation focused on verifying the Fedora-provided implementation and its integration with the existing systemd-based graphical session.

---

## Background

Previous implementations established the graphical session, authentication, power management, audio, networking, Bluetooth, and desktop portal infrastructure.

XDG User Directories provides another foundational service required by desktop applications.

---

## Scope

This implementation included:

- validation of the `xdg-user-dirs` package;
- validation of user directory configuration;
- validation of systemd user service integration;
- validation of directory query functionality;
- validation of compatibility with the Hyprland session.

The implementation did not include:

- custom directory layouts;
- directory renaming;
- application-specific storage configuration;
- file management integration.

---

## Installed Components

No additional components were installed.

The implementation validated the Fedora-provided:

```text
xdg-user-dirs
package.
```

---

## Integration

The validated architecture is:

```text
systemd --user
        │
        ├── graphical-session-pre.target
        │
        ▼
xdg-user-dirs.service
        │
        ▼
xdg-user-dirs-update
        │
        ▼
~/.config/user-dirs.dirs
        │
        ▼
Applications
```

The existing XDG Autostart entry remains available but is skipped when systemd user service integration is active.

---

## Validation

The implementation was validated through:

- installed xdg-user-dirs package;
- enabled systemd user service;
- successful execution of xdg-user-dirs-update;
- successful resolution of standard directories;
- valid configuration file generation;
- successful integration with the Hyprland desktop session.

---

## Results

The resulting implementation provides:

- standardized user directory definitions;
- compatibility with Fedora;
- compatibility with Hyprland;
- compatibility with systemd user sessions;
- compatibility with applications following XDG specifications;
- minimal additional system complexity.

---

## Known Limitations

The selected implementation relies on the XDG User Directories specification and Fedora's package implementation.

Future Fedora changes to directory defaults or session integration may require re-evaluation.

---

## Conclusion

XDG User Directories has been successfully standardized for Project Kintsugi.

The validated implementation relies on the native Fedora infrastructure while preserving the project's modular architecture and standards-based approach.