# XDG User Directories

## Introduction

XDG User Directories defines a standardized mechanism for identifying common user folders within a desktop environment.

Rather than relying on applications defining their own paths, the XDG specification provides a consistent interface for accessing locations such as Documents, Downloads, Music, Pictures, and Videos.

Project Kintsugi treats XDG User Directories as a core desktop infrastructure component independent from the graphical desktop environment.

---

## Why This Component Matters

A modern desktop environment requires a consistent way for applications to locate user content.

XDG User Directories provides the infrastructure required to:

- define standard user folder locations;
- expose directory paths through a standardized interface;
- maintain compatibility between applications and desktop environments;
- preserve user-specific directory configuration.

Without this infrastructure, applications may rely on inconsistent assumptions about user data locations.

---

## Responsibilities

XDG User Directories is responsible for:

- defining standard user directories;
- storing user directory configuration;
- providing command-line interfaces for querying directory locations;
- initializing and updating directory definitions during the user session.

Directory creation, file management, and application-specific storage decisions are separate responsibilities handled by other components.

---

## Relationship with the XDG Base Directory Specification

XDG User Directories complements the XDG Base Directory Specification.

While XDG Base Directory defines locations for configuration, data, and cache files, XDG User Directories defines human-readable folders intended for user content.

Both specifications provide standardized paths that allow applications to operate independently from specific desktop environments.

---

## Relationship with systemd

Project Kintsugi relies on systemd as the foundation of the user session.

XDG User Directories integrates with systemd through:

- systemd user services;
- graphical-session-pre.target;
- user session initialization.

The directory update process is executed as part of the graphical session preparation phase.

---

## Relationship with Hyprland

Hyprland does not implement XDG User Directories.

Instead, it operates within the desktop infrastructure provided by the operating system.

Applications running inside the Hyprland session consume the standardized directory information provided by the XDG infrastructure.

---

## Relationship with Applications

Applications should query XDG User Directories instead of assuming fixed paths.

This allows applications to:

- respect user configuration;
- remain independent from desktop environments;
- maintain compatibility across different Linux desktop implementations.

---

## Design Considerations

Project Kintsugi evaluates XDG User Directories using the following criteria:

- compatibility with Fedora KDE Plasma;
- compliance with freedesktop.org specifications;
- integration with systemd;
- compatibility with Wayland;
- compatibility with Hyprland;
- modular architecture;
- long-term maintainability.

Preference is given to standard operating system components whenever they satisfy the project's architectural requirements.

---

## Separation of Concerns

XDG User Directories is not:

- a file manager;
- a desktop environment;
- an application launcher;
- a storage management system;
- an application-specific configuration mechanism.

Its responsibility is limited to providing standardized user directory locations.

---

## Project Kintsugi Perspective

Project Kintsugi considers XDG User Directories a foundational desktop infrastructure component.

The selected implementation should provide a standard interface between the operating system and applications while remaining independent from the graphical environment.

---

## Next Step

The next document evaluates the available XDG User Directories implementations and explains the implementation selected for Project Kintsugi.