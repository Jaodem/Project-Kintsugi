# XDG User Directories Selection

## Objective

The purpose of this document is to select the XDG User Directories implementation for Project Kintsugi.

The selected implementation should integrate naturally with Fedora, remain compatible with Hyprland, and preserve the project's modular architecture.

---

## Background

XDG User Directories provides a standardized mechanism for defining common user folders.

The evaluation focused on identifying:

- the implementation provided by Fedora;
- the session initialization mechanism;
- the integration with systemd;
- the compatibility with the existing Project Kintsugi session architecture.

---

## Evaluation Criteria

The selected implementation should provide:

- compatibility with Fedora KDE Plasma;
- compliance with freedesktop.org specifications;
- integration with systemd;
- compatibility with Wayland;
- compatibility with Hyprland;
- modular architecture;
- active upstream maintenance;
- availability in official Fedora repositories.

---

## Evaluated Components

### xdg-user-dirs

The Fedora-provided `xdg-user-dirs` package provides:

- standard user directory definitions;
- the `xdg-user-dir` query utility;
- the `xdg-user-dirs-update` initialization tool;
- integration with graphical session startup.

Validation confirmed:

- installed package availability;
- valid user directory configuration;
- successful directory queries;
- successful systemd user service execution.

---

## Session Integration

Fedora provides two possible initialization mechanisms:

- XDG Autostart;
- systemd user services.

The provided autostart entry includes:

```text
X-systemd-skip=true
```

which prevents duplicate execution when systemd user services are available.

The validated session uses:

```bash
systemd --user
        │
        ▼
graphical-session-pre.target
        │
        ▼
xdg-user-dirs.service
```

---

## Decision

Project Kintsugi adopts the Fedora-provided xdg-user-dirs implementation.

The selected architecture is:

```bash
systemd --user
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

No additional components or custom configuration are required.

---

## Trade-offs

Using the native Fedora implementation avoids unnecessary customization while preserving compatibility with applications expecting standard XDG directory definitions.

Alternative implementations or custom directory layouts could provide different behavior but would reduce compatibility and increase maintenance requirements.

---

## Validation

The selected architecture was validated through:

- installed xdg-user-dirs package;
- enabled xdg-user-dirs.service;
- successful service execution;
- successful directory lookup through xdg-user-dir;
- valid ~/.config/user-dirs.dirs configuration;
- integration with the Hyprland session.

---

## Conclusion

Project Kintsugi standardizes on the Fedora-provided XDG User Directories infrastructure.

This approach satisfies the project's architectural goals by preserving standards compliance, systemd integration, and application compatibility.