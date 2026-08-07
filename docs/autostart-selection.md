# XDG Autostart Selection

## Objective

The purpose of this document is to select the XDG Autostart infrastructure for Project Kintsugi.

The selected implementation should integrate naturally with Fedora, remain compatible with Hyprland, and preserve the project's modular architecture.

---

## Background

Automatic application startup is standardized through the XDG Autostart Specification.

The evaluation focused on identifying:

- the implementation provided by Fedora;
- startup directory structure;
- integration with systemd;
- compatibility with the existing desktop session.

---

## Evaluation Criteria

The selected infrastructure should provide:

- compliance with freedesktop.org specifications;
- compatibility with Fedora KDE Plasma;
- compatibility with Wayland;
- compatibility with Hyprland;
- integration with systemd;
- modular architecture;
- active upstream maintenance;
- availability through official Fedora repositories.

---

## Evaluated Components

### XDG Autostart Specification

The specification defines:

- autostart directories;
- desktop entry format;
- startup behavior;
- desktop interoperability.

Validation confirmed:

- existing system autostart directory;
- standard desktop entry format;
- compatibility with the Hyprland session.

---

### systemd-xdg-autostart-generator

Fedora implements XDG Autostart through `systemd-xdg-autostart-generator`.

Validation confirmed:

- automatic generation of user service units;
- desktop entry source tracking;
- integration with `systemd --user`.

---

### User Autostart Directory

Validation confirmed that:

```text
~/.config/autostart
```

does not currently exist.

No architectural requirement was identified to create the directory because the system-wide configuration already satisfies the project's requirements.

---

## Decision

Project Kintsugi adopts the Fedora implementation of the XDG Autostart Specification.

The selected architecture is:

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

No additional startup framework is required.

---

## Trade-offs

Using Fedora's native implementation avoids introducing desktop-specific startup mechanisms and allows autostart applications to integrate naturally with the user service manager.

The trade-off is that startup behavior follows the systemd user service model, which may differ from older desktop-specific implementations.

---

## Validation

The selected architecture was validated through:

- verification of the system autostart directory;
- verification of the absence of user-specific autostart entries;
- successful generation of user services from desktop entries;
- verification of generated systemd user units;
- successful integration with the Hyprland session.

---

## Conclusion

Project Kintsugi standardizes on the Fedora implementation of the XDG Autostart Specification using `systemd-xdg-autostart-generator` and `systemd --user`.

This approach satisfies the project's architectural goals while preserving modularity and standards compliance.