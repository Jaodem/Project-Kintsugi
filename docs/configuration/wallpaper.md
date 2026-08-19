# Wallpaper Configuration

## Overview

Project Kintsugi uses `swaybg` as the wallpaper backend and a small set of custom scripts to manage wallpaper selection and application.

Wallpaper configuration is intentionally separated from the main Hyprland configuration.

The system supports two operating modes:

- one wallpaper shared by all monitors;
- a different wallpaper for each monitor.

---

## Components

The wallpaper system consists of:

- `swaybg` — wallpaper backend;
- `wallpaper.sh` — applies the configured wallpapers;
- `wallpaper-menu.sh` — provides interactive wallpaper selection;
- `wallpaper.conf` — stores the current wallpaper configuration;
- `fuzzel` — provides the graphical selection menus.

The wallpaper files are stored in:

```text
~/Pictures/Wallpapers/
```

---

## Configuration File

The active wallpaper configuration is stored in:

```text
~/.config/hypr/wallpaper.conf
```

The file uses a simple key-value format.

### Shared Wallpaper

When the same image is used on all monitors:

```text
mode=same
wallpaper=kintsugi-desktop.png
```

### Per-Output Wallpapers

When each monitor has its own image:

```text
mode=per-output
eDP_1=kintsugi-laptop.png
HDMI_A_1=kintsugi-desktop.png
```

The configuration uses underscores in output variable names because the file is sourced directly by the wallpaper script.

### Wallpaper Application

```text
~/.config/hypr/scripts/wallpaper.sh
```

The script reads `wallpaper.conf` and starts `swaybg` with the appropriate configuration.

The current monitor layout is:

```text
eDP-1
HDMI-A-1
```

Each output is explicitly configured when swaybg is started.

### Wallpaper Selection

Interactive wallpaper management is provided by:

```text
~/.config/hypr/scripts/wallpaper-menu.sh
```

The menu is launched with:

```text
Super + W
```

The first menu allows selecting between:

```text
Both monitors
One image per monitor
```

### Both Monitors

Selecting **Both monitors** opens a wallpaper selector.

The selected image is applied to both outputs.

The resulting configuration is:

```text
mode=same
wallpaper=<selected-image>
```

### One Image Per Monitor

Selecting One image per monitor opens two selectors.

The first selects the wallpaper for:

```text
eDP-1
```

The second selects the wallpaper for:

```text
HDMI-A-1
```

The resulting configuration is:

```text
mode=per-output
eDP_1=<selected-image>
HDMI_A_1=<selected-image>
```

---

## Fuzzel Integration

`fuzzel` is used as the graphical selection interface.

The wallpaper menu uses a compact configuration:

```text
--dmenu
--width 32
--lines 5
--minimal-lines
```

This keeps the selector small while allowing the number of visible entries to adapt to the available choices.

---

## Session Integration

Wallpaper initialization is performed when Hyprland starts.

The Hyprland configuration executes:

```text
~/.config/hypr/scripts/wallpaper.sh
```

during the Hyprland startup sequence.

This ensures that the active wallpaper configuration is restored automatically when the graphical session starts.

---

## Multi-Monitor Architecture

The wallpaper system is explicitly aware of the two configured outputs:

```text
Hyprland
   │
   ├── eDP-1
   │
   └── HDMI-A-1
        │
        ▼
      swaybg
```

This allows each display to have an independent wallpaper while keeping the configuration simple.

---

## Wallpaper Directory

Supported wallpaper files are discovered from:

```text
~/Pictures/Wallpapers/
```

The selector currently recognizes:

- PNG;
- JPG;
- JPEG;
- WebP.

Only regular files from the wallpaper directory are presented in the selection menu.

---

## Design Considerations

The wallpaper system intentionally avoids relying on Hyprland's built-in wallpaper handling.

This provides:

- independent wallpaper management;
- explicit multi-monitor support;
- simple configuration;
- interactive selection through Fuzzel;
- minimal dependencies;
- separation between compositor configuration and wallpaper management.

Hyprland is responsible for the graphical session and monitor layout, while swaybg is responsible for rendering the wallpapers.

---

## Manual Configuration

The active wallpaper can also be changed manually by editing:

```text
~/.config/hypr/wallpaper.conf
```

After modifying the configuration, apply it with:

```text
~/.config/hypr/scripts/wallpaper.sh
```

The wallpaper menu is preferred for normal daily usage because it avoids manual editing.

---

## Validation

The implementation was validated with:

- successful `swaybg` execution;
- successful wallpaper rendering on both outputs;
- successful shared-wallpaper mode;
- successful per-output wallpaper mode;
- successful Fuzzel wallpaper selection;
- successful wallpaper switching through `Super + W`;
- successful restoration during Hyprland startup.

---

## Current Configuration

The wallpaper system currently uses:

```text
Backend:        swaybg
Selector:       fuzzel
Configuration:  ~/.config/hypr/wallpaper.conf
Apply script:   ~/.config/hypr/scripts/wallpaper.sh
Menu script:    ~/.config/hypr/scripts/wallpaper-menu.sh
Shortcut:       Super + W
Directory:      ~/Pictures/Wallpapers/
```

---

## Conclusion

Project Kintsugi uses a lightweight and compositor-independent wallpaper architecture based on `swaybg`.

Wallpaper selection is handled through Fuzzel, while the active configuration is stored separately from the main Hyprland configuration.

The implementation supports both shared and per-monitor wallpapers and provides a simple graphical workflow through `Super + W`.