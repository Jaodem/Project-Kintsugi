# Screenshot Utility

## Introduction

A screenshot utility is the desktop component responsible for capturing graphical content from the current user session.

It provides a standardized way to capture either the entire desktop, an individual output, an application window, or a user-selected region.

In modern Wayland environments, screenshot functionality is intentionally separated from the compositor itself. Rather than exposing unrestricted access to the framebuffer, compositors provide secure interfaces that dedicated screenshot utilities consume to perform captures.

This separation aligns with the modular architecture promoted by Project Kintsugi.

---

## Why This Component Matters

Capturing screenshots is a fundamental desktop capability used for documentation, troubleshooting, collaboration, and communication.

Modern workflows frequently require users to:

* capture a selected screen region;
* capture the entire desktop;
* copy screenshots directly to the clipboard;
* save screenshots for future reference.

A dedicated screenshot utility provides these capabilities while respecting the security model imposed by Wayland.

---

## Responsibilities

A screenshot utility is responsible for:

* capturing graphical content from the active session;
* allowing region or output selection when supported;
* copying captured images to the clipboard;
* saving screenshots to persistent storage;
* integrating with desktop notifications when appropriate.

Its responsibility ends once the screenshot has been captured or stored.

Image editing, annotation, image management, and document organization remain the responsibility of separate applications.

---

## Relationship with Wayland

Unlike the X11 protocol, Wayland does not allow applications unrestricted access to the contents of the display.

Instead, screenshot utilities interact with compositor-provided protocols that expose controlled screenshot functionality.

This design improves desktop security while allowing users to perform legitimate capture operations.

---

## Relationship with Hyprland

Hyprland does not include a built-in screenshot application.

Instead, it provides the Wayland protocols required by external utilities designed for wlroots-based compositors.

Project Kintsugi therefore evaluates screenshot solutions independently from the compositor, selecting the implementation that best satisfies the project's architectural principles.

---

## Design Considerations

When selecting a screenshot utility, Project Kintsugi considers:

* native Wayland compatibility;
* compatibility with Hyprland;
* support for region selection;
* clipboard integration;
* predictable command-line interface;
* active upstream maintenance;
* availability through approved package sources;
* long-term maintainability.

Preference is given to lightweight utilities that integrate naturally with the existing desktop infrastructure.

---

## Separation of Concerns

A screenshot utility is not:

* an image editor;
* a graphics application;
* a clipboard manager;
* a desktop portal implementation;
* a notification daemon.

Its sole responsibility is capturing graphical content and making it available to the user.

---

## Project Kintsugi Perspective

Project Kintsugi considers screenshot functionality to be an essential desktop capability rather than a convenience feature.

The project prioritizes solutions that integrate cleanly with Wayland, preserve the modular desktop architecture, and avoid unnecessary dependencies on a full desktop environment.

The selected implementation should provide a simple, reliable workflow while remaining consistent with the project's long-term maintenance objectives.

---

## Next Step

The next document evaluates the available screenshot solutions and selects the implementation adopted by Project Kintsugi.