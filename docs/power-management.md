# Power Management

## Introduction

Power management is responsible for coordinating the operating system components that monitor power-related hardware events, expose power information, and apply system power policies.

Rather than being a single application, power management is a collection of cooperating services with clearly separated responsibilities.

Project Kintsugi treats power management as a core infrastructure component independent of the graphical desktop environment.

---

## Why This Component Matters

A modern desktop environment requires reliable integration between the operating system, hardware, and the graphical session.

Power management provides the infrastructure required to:

- monitor batteries and external power sources;
- detect power-related hardware events;
- manage suspend and resume operations;
- expose power information to desktop applications;
- apply system power profiles.

Without this infrastructure, desktop components cannot reliably react to changes in system power state.

---

## Responsibilities

Power management is responsible for:

- exposing battery and AC power information;
- handling suspend and resume requests;
- handling hardware power events;
- managing system power profiles;
- providing standardized D-Bus interfaces for desktop applications.

Idle detection, screen locking, and desktop notifications are separate responsibilities implemented by other components.

---

## Relationship with systemd

Project Kintsugi relies on systemd as the foundation of the operating system.

Power management integrates with systemd through:

- systemd-logind;
- system suspend and resume;
- user session lifecycle.

Systemd remains responsible for user sessions and hardware-triggered power events.

---

## Relationship with Hyprland

Hyprland does not implement power management.

Instead, it operates within the infrastructure provided by the operating system.

Desktop power-related functionality is therefore provided by dedicated services rather than the compositor itself.

---

## Relationship with hypridle

hypridle is responsible for idle detection and idle-triggered actions.

It is not responsible for battery management, hardware power events, or power profile selection.

Power management and idle management are complementary but independent architectural components.

---

## Design Considerations

Project Kintsugi evaluates power management using the following criteria:

- compatibility with Fedora KDE Plasma;
- integration with systemd;
- compatibility with Wayland;
- compatibility with Hyprland;
- modular architecture;
- long-term maintainability;
- availability through official Fedora repositories.

Preference is given to components already integrated into the operating system whenever they satisfy the project's architectural requirements.

---

## Separation of Concerns

Power management is not:

- a screen locker;
- an idle daemon;
- a battery widget;
- a desktop panel;
- a compositor.

Its responsibility is limited to managing operating system power infrastructure.

---

## Project Kintsugi Perspective

Project Kintsugi considers power management a foundational infrastructure component.

The selected implementation should integrate naturally with Fedora while remaining independent from the desktop environment.

---

## Next Step

The next document evaluates the available power management infrastructure and explains the implementation selected for Project Kintsugi.