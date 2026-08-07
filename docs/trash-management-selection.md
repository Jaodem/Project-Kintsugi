# Trash Management Selection

## Objective

The purpose of this document is to select the Trash Management infrastructure for Project Kintsugi.

The selected implementation should integrate naturally with Fedora, remain compatible with Hyprland, and preserve the project's modular architecture.

---

## Background

Trash Management is based on the FreeDesktop Trash Specification.

The evaluation focused on identifying:

- the implementation provided by Fedora KDE Plasma;
- the storage mechanism;
- application integration;
- compatibility with the existing desktop session.

---

## Evaluation Criteria

The selected infrastructure should provide:

- compliance with freedesktop.org specifications;
- compatibility with Fedora KDE Plasma;
- compatibility with Wayland;
- compatibility with Hyprland;
- integration with desktop applications;
- modular architecture;
- active upstream maintenance;
- availability through official Fedora repositories.

---

## Evaluated Components

### FreeDesktop Trash Specification

The specification defines:

- trash storage locations;
- metadata files;
- restoration information;
- desktop interoperability.

Validation confirmed:

- existing trash directory structure;
- valid trash metadata generation;
- compatibility with desktop applications.

---

### KDE Frameworks KIO

KDE Frameworks provides trash integration through KIO.

Validation confirmed:

- successful trash URI handling;
- successful integration with Dolphin;
- compatibility with the Hyprland session.

---

### GVFS

GVFS provides trash integration for GIO-based applications.

Validation confirmed that:

```text
gvfs
```
is not installed.

No architectural requirement was identified to introduce GVFS because the selected KDE-based infrastructure already provides the required desktop functionality.

---

## Decision

Project Kintsugi adopts the Fedora KDE Plasma trash infrastructure.

The selected architecture is:
```text
Applications
        │
        ▼
FreeDesktop Trash Specification
        │
        ▼
~/.local/share/Trash
        │
        ▼
KDE Frameworks KIO
        │
        ▼
Dolphin / KDE Applications
```

No additional trash management components are required.

---

## Trade-offs

Using the existing KDE infrastructure avoids introducing parallel desktop integration layers.

The trade-off is that GIO trash URI operations provided through GVFS are not available unless GVFS is installed.

This limitation does not affect the validated desktop workflow because KDE applications use KIO integration.

---

## Validation

The selected architecture was validated through:

- existing FreeDesktop trash directory structure;
- successful file deletion through GIO;
- successful creation of trash metadata;
- successful access through KIO;
- successful opening of trash through Dolphin;
- compatibility with the Hyprland session.

---

## Conclusion

Project Kintsugi standardizes on the Fedora KDE Plasma Trash Management infrastructure based on the FreeDesktop Trash Specification and KDE Frameworks KIO.

This approach satisfies the project's architectural goals while preserving modularity and avoiding unnecessary components.