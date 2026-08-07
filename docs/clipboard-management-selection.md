# Clipboard Management Selection

## Objective

The purpose of this document is to select the Clipboard Management infrastructure for Project Kintsugi.

The selected implementation should integrate naturally with Fedora, remain compatible with Hyprland, and preserve the project's modular architecture.

---

## Background

Clipboard functionality under Wayland is based on standardized protocol mechanisms implemented by the compositor.

The evaluation focused on identifying:

- the protocol implementation;
- command-line clipboard utilities;
- optional clipboard managers;
- compatibility with the existing desktop session.

---

## Evaluation Criteria

The selected infrastructure should provide:

- compliance with Wayland standards;
- compatibility with Fedora KDE Plasma;
- compatibility with Wayland;
- compatibility with Hyprland;
- modular architecture;
- active upstream maintenance;
- availability through official Fedora repositories.

---

## Evaluated Components

### Wayland Clipboard Protocol

The Wayland protocol provides standardized clipboard communication between applications.

Validation confirmed:

- successful clipboard data transfer;
- support for multiple MIME types;
- compatibility with the Hyprland session.

---

### wl-clipboard

wl-clipboard provides command-line utilities for interacting with the Wayland clipboard.

Validation confirmed:

- package installation;
- successful clipboard write operations;
- successful clipboard read operations;
- MIME type inspection.

---

### Clipboard History Managers

Clipboard history managers provide persistent clipboard storage and history browsing.

The following components were evaluated:

- cliphist
- Klipper
- CopyQ

Validation confirmed that none of these components are installed.

No architectural requirement was identified to introduce a clipboard history manager because the existing clipboard infrastructure already satisfies the project's requirements.

---

## Decision

Project Kintsugi adopts the native Wayland clipboard infrastructure.

The selected architecture is:

```text
Applications
        │
        ▼
Wayland Clipboard Protocol
        │
        ▼
Hyprland
        │
        ▼
Clipboard Selection
        │
        ├── wl-copy
        └── wl-paste
```

No clipboard history manager is required.

---

## Trade-offs

Using the native Wayland clipboard infrastructure avoids introducing additional background services and preserves a minimal desktop architecture.

The trade-off is that clipboard history is not available unless an optional history manager is installed in the future.

This limitation does not affect standard clipboard operations.

---

## Validation

The selected architecture was validated through:

- verification of the wl-clipboard package;
- successful clipboard write operations;
- successful clipboard read operations;
- successful MIME type enumeration;
- verification that no clipboard history manager is installed;
- compatibility with the Hyprland session.

---

## Conclusion

Project Kintsugi standardizes on the native Wayland clipboard infrastructure using Hyprland as the protocol implementation and wl-clipboard as the command-line interface.

This approach satisfies the project's architectural goals while preserving modularity and avoiding unnecessary components.