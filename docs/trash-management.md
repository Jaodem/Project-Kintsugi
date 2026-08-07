# Trash Management

## Introduction

Trash Management defines the standardized mechanism used by desktop environments to safely remove files while preserving the ability to restore them.

Rather than permanently deleting user content, the trash infrastructure provides a controlled intermediate location where deleted files can be reviewed, restored, or permanently removed.

Project Kintsugi treats Trash Management as a core desktop infrastructure component independent from the graphical desktop environment.

---

## Why This Component Matters

A modern desktop environment requires safe file deletion mechanisms that protect users from accidental data loss.

Trash Management provides the infrastructure required to:

- move deleted files to a recoverable location;
- preserve original file locations;
- restore previously deleted content;
- maintain compatibility between applications and desktop environments.

Without this infrastructure, applications would need to implement independent deletion and recovery mechanisms.

---

## Responsibilities

Trash Management is responsible for:

- providing standardized file deletion behavior;
- storing deleted files in a user-specific trash location;
- preserving metadata required for restoration;
- exposing trash functionality to desktop applications.

Permanent deletion, file management, and application-specific behavior are separate responsibilities handled by other components.

---

## Relationship with the FreeDesktop Trash Specification

Project Kintsugi relies on the FreeDesktop Trash Specification as the standard mechanism for managing deleted files.

The specification defines:

- trash locations;
- metadata storage;
- restoration information;
- compatibility between desktop environments.

User trash data is stored within:

```text
~/.local/share/Trash
```

The trash infrastructure remains independent from specific desktop environments.

---

## Relationship with KDE Frameworks

KDE Frameworks provides integration with the FreeDesktop Trash Specification through KIO.

KIO provides:

- trash URI handling;
- integration with KDE applications;
- graphical access through file managers.

Project Kintsugi uses KDE Frameworks integration because it is already provided by the Fedora KDE Plasma base system.

---

## Relationship with Hyprland

Hyprland does not implement Trash Management.

Instead, it operates within the desktop infrastructure provided by the operating system.

Applications running inside the Hyprland session consume the existing trash infrastructure provided by KDE Frameworks and FreeDesktop specifications.

---

## Relationship with Applications

Applications should use standardized desktop APIs when moving files to trash.

This allows applications to:

- preserve user expectations;
- provide restore functionality;
- remain independent from specific desktop environments.

---

## Design Considerations

Project Kintsugi evaluates Trash Management using the following criteria:

- compliance with freedesktop.org specifications;
- compatibility with Fedora KDE Plasma;
- compatibility with Wayland;
- compatibility with Hyprland;
- integration with existing desktop applications;
- modular architecture;
- long-term maintainability.

Preference is given to existing operating system infrastructure whenever it satisfies the project's requirements.

---

## Separation of Concerns

Trash Management is not:

- a file manager;
- a backup system;
- a permanent deletion mechanism;
- a storage management system;
- an application-specific feature.

Its responsibility is limited to providing a standardized recovery mechanism for deleted content.

---

## Project Kintsugi Perspective

Project Kintsugi considers Trash Management a foundational desktop infrastructure component.

The selected implementation should provide safe file deletion while remaining independent from the graphical environment.

---

## Next Step

The next document evaluates the available Trash Management infrastructure and explains the implementation selected for Project Kintsugi.