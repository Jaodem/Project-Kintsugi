# Wallpaper Selection

## Objective

The purpose of this document is to select the wallpaper management architecture for Project Kintsugi.

The selected implementation should provide reliable wallpaper rendering while supporting multiple displays, per-output configuration, and independent operation from KDE Plasma and Hyprland's internal wallpaper mechanisms.

---

## Background

Project Kintsugi requires wallpaper management for a Wayland session using Hyprland.

The system uses multiple displays, including:

- `eDP-1`;
- `HDMI-A-1`.

The wallpaper solution must therefore support both a shared wallpaper across displays and independent wallpapers for each output.

The selected solution should remain lightweight and avoid introducing unnecessary dependencies on a desktop environment.

---

## Evaluation Criteria

The selected implementation should provide:

- compatibility with Fedora;
- compatibility with Wayland;
- compatibility with Hyprland;
- multi-monitor support;
- per-output wallpaper support;
- simple configuration;
- minimal dependencies;
- desktop-environment independence;
- active upstream maintenance;
- availability in Fedora repositories;
- easy integration with shell scripts.

---

## Existing Infrastructure

Project Kintsugi already provides:

- a Hyprland-based Wayland session;
- two configured display outputs;
- Fuzzel as the application launcher and menu interface;
- a user configuration directory under `~/.config/hypr/`.

The wallpaper implementation should integrate with this existing infrastructure without requiring KDE Plasma components.

---

## Candidate Approaches

### Hyprland Wallpaper Functionality

Hyprland provides mechanisms for managing its default wallpaper and compositor background.

Advantages:

- integrated with the compositor;
- no separate wallpaper application required;
- simple for basic configurations.

Limitations:

- couples wallpaper management to the compositor;
- provides less architectural separation;
- does not align as well with Project Kintsugi's goal of progressively reducing compositor-specific responsibilities;
- makes the wallpaper subsystem dependent on Hyprland functionality.

Project Kintsugi therefore does not use Hyprland's internal wallpaper mechanism as the primary wallpaper implementation.

---

### hyprpaper

`hyprpaper` is a lightweight wallpaper utility from the Hypr ecosystem.

Advantages:

- designed for Wayland;
- designed primarily for Hyprland;
- supports multiple outputs;
- supports dynamic wallpaper control;
- lightweight architecture.

Limitations:

- stronger association with the Hypr ecosystem;
- Fedora availability in the evaluated environment was provided through a COPR repository rather than the standard Fedora repository;
- introduces Hypr-specific dependencies that are unnecessary for the required functionality.

During evaluation on Fedora 44, the available package was:

```text
hyprpaper 0.8.4-2.fc44
```

from:

```text
copr:copr.fedorainfracloud.org:lionheartp:Hyprland
```

Project Kintsugi prefers to avoid an additional repository when an equivalent solution is available through Fedora's official repositories.

---

## swaybg

`swaybg` is a lightweight wallpaper utility for Wayland compositors.

Advantages:

- Wayland-native;
- compositor independent;
- supports multiple outputs;
- supports per-output wallpaper configuration;
- simple command-line interface;
- easy to integrate with shell scripts;
- available in the official Fedora repositories;
- minimal dependency footprint;
- does not depend on KDE Plasma.

The evaluated Fedora package was:

```text
swaybg 1.2.2-1.fc44
```

from the Fedora repository.

`swaybg` also directly supports output-specific configuration through the -o option, allowing Project Kintsugi to assign different images to individual monitors.

---

## Dependency Evaluation

The required runtime libraries for `swaybg` were already present on the system.

The evaluated dependencies included:

- Cairo;
- GDK Pixbuf;
- GLib;
- Wayland client libraries.

The required runtime libraries were already installed before the wallpaper implementation.

This allowed `swaybg` to be introduced without unnecessary additional system dependencies.

---

## Multi-Monitor Evaluation

The most important requirement was the ability to assign different wallpapers to different outputs.

The implementation was tested using:

```text
swaybg \
    -o eDP-1 -i "$HOME/Pictures/Images/Noteee.png" -m fill \
    -o HDMI-A-1 -i "$HOME/Pictures/Images/Monii.png" -m fill
```

The result confirmed that each monitor could display an independent image.

Shared wallpaper operation was also tested by assigning the same image to both outputs.

Both operating modes therefore meet the project's requirements.

---

## Decision

Project Kintsugi adopts:

```text
Fuzzel
   │
   ▼
wallpaper-menu.sh
   │
   ▼
wallpaper.conf
   │
   ▼
wallpaper.sh
   │
   ▼
swaybg
   ├── eDP-1
   └── HDMI-A-1
```

`swaybg` is responsible for wallpaper rendering.

The surrounding shell scripts provide configuration management and user interaction.

---

## Wallpaper Modes

The selected architecture provides two modes.

### Shared Wallpaper

A single image is assigned to both outputs:

```text
mode=same
wallpaper=wallpaper.png
```

### Per-Output Wallpapers

Each output receives an independent image:

```text
mode=per-output
eDP_1=laptop.png
HDMI_A_1=desktop.png
```

This allows the user to switch between simple and multi-monitor-specific configurations without changing the underlying wallpaper renderer.

---

## User Interface

Fuzzel is used as the graphical selector.

The wallpaper menu provides:

```text
Wallpaper
├── Both monitors
└── One image per monitor
```

The user can therefore change wallpapers without manually editing wallpaper.conf.

The selector is exposed through:

```text
Super + W
```

This provides a simple workflow while retaining a transparent, file-based configuration underneath.

---

## Trade-offs

Compared with `hyprpaper`, `swaybg` provides less Hyprland-specific integration.

However, this is considered an advantage for Project Kintsugi's architecture.

The selected solution:

- avoids unnecessary compositor coupling;
- is available in Fedora's official repositories;
- requires no additional COPR repository;
- supports the required multi-monitor configuration;
- integrates naturally with shell scripts;
- remains usable if the compositor is changed in the future.

The project therefore prioritizes architectural independence over compositor-specific integration.

---

## Validation

The selected implementation was validated through:

- successful installation of `swaybg`;
- successful execution under Hyprland;
- successful wallpaper rendering;
- successful shared wallpaper configuration;
- successful per-output wallpaper configuration;
- successful operation on `eDP-1`;
- successful operation on `HDMI-A-1`;
- successful integration with the wallpaper startup script;
- successful integration with Fuzzel;
- successful wallpaper selection through `Super + W`.

---

## Conclusion

Project Kintsugi standardizes on `swaybg` as the wallpaper rendering backend.

The solution provides the required multi-monitor functionality while maintaining a lightweight and modular architecture.

The final design separates:

- user interaction through Fuzzel;
- wallpaper state through `wallpaper.conf`;
- execution logic through `wallpaper.sh`;
- wallpaper rendering through `swaybg`;
- session startup through Hyprland.

This architecture provides the required functionality without introducing unnecessary dependencies on KDE Plasma, Hyprland-specific wallpaper functionality, or additional package repositories.