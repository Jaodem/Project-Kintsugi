# Wallpaper Management

## Introduction

Wallpaper management is responsible for displaying and managing desktop background images within the graphical session.

Project Kintsugi treats wallpaper management as an independent desktop component rather than as a responsibility of the compositor or desktop environment.

The implementation is designed to support multiple monitors while remaining simple, modular, and independent from KDE Plasma.

---

## Why This Component Matters

The desktop wallpaper is a visible part of the graphical session, but it does not need to be tightly coupled to the compositor.

A dedicated wallpaper component allows Project Kintsugi to:

- manage wallpapers independently from Hyprland;
- support multiple displays;
- assign different images to individual outputs;
- use the same image across multiple outputs when desired;
- change wallpapers without modifying the main compositor configuration;
- provide a simple graphical selection interface.

---

## Responsibilities

The wallpaper subsystem is responsible for:

- rendering wallpaper images;
- assigning wallpapers to individual outputs;
- applying a shared wallpaper across multiple outputs;
- storing the current wallpaper selection;
- providing a user-facing wallpaper selection interface;
- starting the wallpaper service during the graphical session.

Compositor functionality, window management, workspace management, and display configuration remain separate responsibilities.

---

## Relationship with swaybg

Project Kintsugi uses `swaybg` as the wallpaper renderer.

`swaybg` is a lightweight Wayland wallpaper utility designed to work with Wayland compositors.

It provides the required functionality to assign images to specific outputs while remaining independent of a particular desktop environment or compositor.

The wallpaper subsystem therefore follows this architecture:

```text
Wallpaper configuration
        │
        ▼
wallpaper.sh
        │
        ▼
swaybg
        │
        ├── eDP-1
        └── HDMI-A-1
```

---

## Relationship with Hyprland

Hyprland provides the graphical compositor and manages the Wayland session.

It does not need to render or manage the wallpapers directly.

Instead, Hyprland is responsible only for starting the wallpaper component during the graphical session and providing the keybinding used to access the wallpaper selector.

This preserves the separation between compositor functionality and wallpaper management.

---

## Multi-Monitor Support

Project Kintsugi uses two display outputs:

- eDP-1;
- HDMI-A-1.

The wallpaper subsystem supports two operating modes.

---

## Shared Wallpaper

A single image can be assigned to both displays:

```text
eDP-1    ──┐
           ├── wallpaper.png
HDMI-A-1 ──┘

```
---

## Per-Output Wallpapers

Each display can use an independent image:

```text
eDP-1    ── kintsugi-laptop.png
HDMI-A-1 ── kintsugi-desktop.png
```

This allows the wallpaper configuration to reflect the physical role of each display.

---

## User Interface

Wallpaper selection is provided through Fuzzel.

The user-facing selector provides two options:

```text
Wallpaper
├── Both monitors
└── One image per monitor
```

When selecting a single wallpaper, the image is chosen once and applied to both displays.

When selecting per-output wallpapers, the user selects an image independently for each display.

The wallpaper selector is accessible through:

```text
Super + W
```

This keeps wallpaper management accessible without requiring manual editing of configuration files for normal use.

---

## Configuration

The current wallpaper selection is stored separately from the main Hyprland configuration.

The configuration defines:

- the selected operating mode;
- the wallpaper used in shared mode;
- the wallpaper assigned to each output in per-output mode.

The wallpaper renderer does not contain permanent wallpaper selections.

This separation allows the user interface to modify the current selection without modifying the compositor configuration.

---

## Startup

The wallpaper subsystem is started automatically as part of the Hyprland graphical session.

The startup sequence is:

```text
Hyprland session
      │
      ▼
wallpaper.sh
      │
      ▼
swaybg
      │
      ├── eDP-1
      └── HDMI-A-1
```

The wallpaper configuration is read when the script starts, allowing the current selection to be restored automatically.

---

## Design Considerations

When evaluating wallpaper solutions, Project Kintsugi considers:

- compatibility with Wayland;
- compatibility with Hyprland;
- multi-monitor support;
- per-output configuration;
- availability in Fedora repositories;
- minimal dependencies;
- desktop-environment independence;
- active upstream maintenance;
- simple configuration;
- ease of automation.

Preference is given to lightweight components that provide the required functionality without introducing unnecessary desktop environment dependencies.

---

## Separation of Concerns

Wallpaper management is not:

- a compositor responsibility;
- a window management responsibility;
- a workspace management feature;
- a desktop environment feature;
- a display configuration system.

Its responsibility is limited to rendering and managing desktop background images.

Hyprland provides the session and triggers the component, while swaybg performs the actual rendering.

---

## KDE Plasma Independence

KDE Plasma provides its own wallpaper management functionality through the Plasma desktop environment.

Project Kintsugi does not depend on Plasma's wallpaper system.

This is intentional.

As the Project Kintsugi session progressively removes KDE Plasma dependencies, wallpaper management remains available through an independent Wayland component.

This allows wallpaper functionality to remain operational even as other KDE Plasma components are removed.

---

## Project Kintsugi Perspective

Project Kintsugi considers wallpaper management a lightweight desktop component that should remain independent from both the desktop environment and the compositor whenever practical.

The selected architecture provides:

- Wayland-native wallpaper rendering;
- independent per-monitor wallpapers;
- shared wallpaper support;
- graphical wallpaper selection;
- automatic session startup;
- minimal compositor coupling;
- independence from KDE Plasma.

The resulting design keeps wallpaper management simple while providing the flexibility required for a multi-monitor Wayland session.

---

## Next Step

The next document evaluates the available wallpaper management solutions and explains the implementation selected by Project Kintsugi.