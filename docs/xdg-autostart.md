# XDG Autostart

## Introduction

XDG Autostart defines the standardized mechanism used by desktop sessions to automatically start applications when a graphical session begins.

Rather than requiring desktop environments to implement their own startup mechanisms, the XDG Autostart Specification provides a common interface based on desktop entry files.

Project Kintsugi treats XDG Autostart as a core desktop infrastructure component independent from the graphical desktop environment.

---

## Why This Component Matters

A modern desktop environment requires a standardized mechanism for automatically launching user and system applications.

XDG Autostart provides the infrastructure required to:

- automatically start desktop applications;
- standardize startup behavior across desktop environments;
- allow both system-wide and user-specific startup configuration;
- maintain compatibility between desktop environments and applications.

Without this infrastructure, each desktop environment would require its own application startup mechanism.

---

## Responsibilities

XDG Autostart is responsible for:

- defining startup entries through desktop files;
- allowing applications to request automatic startup;
- supporting user-specific startup configuration;
- standardizing application startup behavior.

Process supervision, service management, and session lifecycle are separate responsibilities handled by other components.

---

## Relationship with the XDG Autostart Specification

Project Kintsugi relies on the XDG Autostart Specification as the standard mechanism for automatically starting desktop applications.

The specification defines:

- autostart directories;
- desktop entry format;
- startup conditions;
- desktop environment compatibility.

System-wide startup entries are typically stored under:

```text
/etc/xdg/autostart
```

User-specific startup entries may be stored under:

```text
~/.config/autostart
```

The specification remains independent from any specific desktop environment.

---

## Relationship with systemd

Fedora implements the XDG Autostart Specification using `systemd-xdg-autostart-generator`.

The generator translates desktop entry files into transient user services managed by `systemd --user`.

This allows autostart applications to participate in the same service lifecycle management as other user services.

---

## Relationship with Hyprland

Hyprland does not implement XDG Autostart.

Applications are started by the session infrastructure before or during the graphical session lifecycle.

Hyprland provides the Wayland compositor required for the graphical session but does not interpret XDG Autostart desktop entries.

---

## Relationship with Applications

Applications request automatic startup by installing desktop entry files that comply with the XDG Autostart Specification.

The desktop session evaluates these entries and starts eligible applications according to the specification.

Applications remain independent from the underlying startup implementation.

---

## Design Considerations

Project Kintsugi evaluates XDG Autostart using the following criteria:

- compliance with freedesktop.org specifications;
- compatibility with Fedora KDE Plasma;
- compatibility with Wayland;
- compatibility with Hyprland;
- integration with systemd;
- modular architecture;
- long-term maintainability.

Preference is given to existing operating system infrastructure whenever it satisfies the project's requirements.

---

## Separation of Concerns

XDG Autostart is not:

- a service manager;
- a process supervisor;
- a session manager;
- a compositor feature;
- an application launcher.

Its responsibility is limited to standardizing automatic application startup.

---

## Project Kintsugi Perspective

Project Kintsugi considers XDG Autostart a foundational desktop infrastructure component.

The selected implementation should rely on the XDG Autostart Specification and Fedora's native systemd integration while avoiding desktop-specific startup mechanisms.

---

## Next Step

The next document evaluates the available XDG Autostart infrastructure and explains the implementation selected for Project Kintsugi.