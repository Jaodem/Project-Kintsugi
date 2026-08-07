# XDG MIME Applications

## Introduction

XDG MIME Applications defines a standardized mechanism for associating file types and URI schemes with desktop applications.

Rather than relying on applications or desktop environments defining their own associations, the XDG specification provides a common interface for resolving which application should handle a specific content type.

Project Kintsugi treats XDG MIME Applications as a core desktop infrastructure component independent from the graphical desktop environment.

---

## Why This Component Matters

A modern desktop environment requires a consistent mechanism for launching applications based on file types and URI schemes.

XDG MIME Applications provides the infrastructure required to:

- associate MIME types with applications;
- resolve default applications;
- maintain user-specific application preferences;
- provide interoperability between different desktop environments.

Without this infrastructure, applications may implement incompatible mechanisms for handling file associations.

---

## Responsibilities

XDG MIME Applications is responsible for:

- defining associations between MIME types and applications;
- resolving default applications;
- providing a standardized configuration mechanism;
- allowing applications to query supported handlers.

Application installation, application availability, and user preferences are separate responsibilities handled by other components.

---

## Relationship with Desktop Entries

XDG MIME Applications relies on Desktop Entry files to identify available applications.

Desktop Entries provide:

- application identifiers;
- supported MIME types;
- execution commands;
- application metadata.

The MIME association system uses these identifiers to resolve the application responsible for handling specific content.

---

## Relationship with the XDG Base Directory Specification

XDG MIME Applications uses the XDG configuration hierarchy.

User-specific associations are stored within:

```text
~/.config/mimeapps.list
```

System-wide defaults may be provided through standard XDG configuration locations.

This allows application associations to remain independent from specific desktop environments.

---

## Relationship with Desktop Environments

Desktop environments may provide additional integration layers for managing application associations.

KDE Plasma provides its own MIME integration mechanisms while remaining compatible with the underlying XDG standards.

Project Kintsugi relies on the XDG specification as the base infrastructure rather than depending on a specific desktop environment.

---

## Relationship with Hyprland

Hyprland does not implement MIME application handling.

Instead, it operates within the desktop infrastructure provided by the operating system.

Applications running inside the Hyprland session use the XDG MIME Applications infrastructure to resolve default handlers.

---

## Design Considerations

Project Kintsugi evaluates XDG MIME Applications using the following criteria:

- compliance with freedesktop.org specifications;
- compatibility with Fedora KDE Plasma;
- compatibility with Wayland;
- compatibility with Hyprland;
- integration with existing desktop applications;
- modular architecture;
- long-term maintainability.

Preference is given to standard operating system mechanisms whenever they satisfy the project's architectural requirements.

---

## Separation of Concerns

XDG MIME Applications is not:

- an application launcher;
- a package manager;
- an application installer;
- a desktop environment;
- a file manager.

Its responsibility is limited to resolving application associations.

---

## Project Kintsugi Perspective

Project Kintsugi considers XDG MIME Applications a foundational desktop infrastructure component.

The selected implementation should provide a standard interface between applications and the operating system while preserving user control over application preferences.

---

## Next Step

The next document evaluates the available XDG MIME Applications infrastructure and explains the implementation selected for Project Kintsugi.