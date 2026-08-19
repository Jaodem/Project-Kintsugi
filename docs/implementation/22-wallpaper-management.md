# Wallpaper Management Implementation

## Objective

The objective of this implementation was to establish an independent wallpaper management system for the Project Kintsugi Wayland session.

The implementation provides wallpaper rendering for multiple displays while allowing the user to switch between a shared wallpaper and independent wallpapers for each monitor.

The solution is independent from KDE Plasma's wallpaper management and does not rely on Hyprland's internal wallpaper functionality.

---

## Background

Project Kintsugi uses Hyprland as the Wayland compositor and currently operates with two displays:

- `eDP-1`;
- `HDMI-A-1`.

Initial evaluation considered both `hyprpaper` and `swaybg`.

The selected implementation uses `swaybg` because it provides the required output-specific wallpaper functionality, is lightweight, integrates naturally with shell scripts, and is available through Fedora's official repositories.

---

## Scope

This implementation included:

- evaluation of wallpaper management solutions;
- installation and validation of `swaybg`;
- validation of runtime dependencies;
- creation of a wallpaper configuration file;
- creation of the wallpaper startup script;
- creation of the graphical wallpaper selector;
- support for shared wallpapers;
- support for per-output wallpapers;
- Fuzzel integration;
- Hyprland startup integration;
- `Super + W` keyboard shortcut;
- validation on both displays.

The implementation did not include:

- KDE Plasma wallpaper integration;
- Hyprland-specific wallpaper management;
- automatic wallpaper rotation;
- random wallpaper selection;
- wallpaper transitions;
- image downloading or external wallpaper services.

---

## Selected Component

The wallpaper renderer selected for Project Kintsugi is:

```text
swaybg
```

The package was available through the official Fedora repository.

No additional repository was required.

---

## Dependency Validation

Before installation, the required runtime libraries were checked.

The following libraries were already available:

```text
libcairo.so.2
libgdk_pixbuf-2.0.so.0
libgobject-2.0.so.0
libwayland-client.so.0
```

The corresponding installed packages included:

```text
cairo
gdk-pixbuf2
glib2
```

The system therefore already provided the required graphical and Wayland runtime infrastructure.

---

## Initial Validation

The installed version was verified with:

```text
swaybg --version
```

The result was:

```text
swaybg version 1.2.2
```

A basic test using a single image confirmed that swaybg could render a wallpaper across both displays.

The output configuration was then tested explicitly:

```text
swaybg \
    -o eDP-1 -i "$HOME/Pictures/Images/Noteee.png" -m fill \
    -o HDMI-A-1 -i "$HOME/Pictures/Images/Monii.png" -m fill
```

The test confirmed that independent images could be assigned to:

```text
eDP-1
HDMI-A-1
```

---

## Wallpaper Directory

Project Kintsugi stores wallpapers in:

```text
~/Pictures/Wallpapers/
```

The initial wallpaper set used during implementation was:

```text
kintsugi-laptop.png
kintsugi-desktop.png
```

The directory is intentionally kept separate from the Hyprland configuration directory.

---

## Wallpaper Configuration

The current wallpaper state is stored in:

```text
~/.config/hypr/wallpaper.conf
```

The configuration supports two modes.

### Shared Mode

```text
mode=same
wallpaper=kintsugi-desktop.png
```

In this mode, the same image is applied to both displays.

### Per-Output Mode

```text
mode=per-output
eDP_1=kintsugi-laptop.png
HDMI_A_1=kintsugi-desktop.png
```

In this mode, each display receives its own image.

The configuration uses underscores in the output variable names because the file is sourced by the shell script.

---

## Wallpaper Script

The wallpaper renderer is controlled through:

```text
~/.config/hypr/scripts/wallpaper.sh
```

The script:

1. loads wallpaper.conf;
2. determines the selected mode;
3. validates the required configuration values;
4. constructs the appropriate swaybg command;
5. assigns the configured wallpaper to each output.

The script supports:

```text
same
per-output
```

This keeps the actual wallpaper rendering logic separate from the user interface.

---

## Wallpaper Selection Menu

A graphical wallpaper selector was created at:

```text
~/.config/hypr/scripts/wallpaper-menu.sh
```

Fuzzel provides the user interface.

The menu first asks whether the user wants:

```text
Both monitors
One image per monitor
```

For shared mode, a single wallpaper is selected.

For per-output mode, the user selects:

1. the wallpaper for eDP-1;
2. the wallpaper for HDMI-A-1.

The selected configuration is then written to:

```text
~/.config/hypr/wallpaper.conf
```

and immediately applied.

---

## Wallpaper Discovery

The selector searches:

```text
~/Pictures/Wallpapers/
```

for supported image formats:

```text
*.png
*.jpg
*.jpeg
*.webp
```

The filenames are sorted before being passed to Fuzzel.

This allows new wallpapers to be added simply by placing them in the wallpaper directory.

No additional configuration is required to make a new image available in the selector.

---

Fuzzel Integration

The wallpaper selector uses Fuzzel in dmenu mode.

The menu was intentionally kept compact:

```text
--dmenu
--width 32
--lines 5
--minimal-lines
```

The number of visible entries is limited while allowing the menu to adapt when fewer entries are available.

The selector therefore follows the same lightweight interaction model used by other Project Kintsugi scripts.

---

## Hyprland Integration

The wallpaper script is started automatically when the Hyprland graphical session starts.

The startup configuration contains:

```text
hl.on("hyprland.start", function ()
  hl.exec_cmd("waybar")
  hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh")
end)
```

This means the wallpaper configuration is restored automatically without requiring manual intervention after starting the session.

Hyprland only starts the wallpaper component; `swaybg` remains responsible for rendering the wallpaper.

---

## Keyboard Shortcut

A dedicated keyboard shortcut was added to the Hyprland configuration:

```text
Super + W
```

The shortcut launches:

```text
~/.config/hypr/scripts/wallpaper-menu.sh
```

`Super + W` was selected because W provides an intuitive mnemonic for wallpaper.

The shortcut allows the wallpaper configuration to be changed without manually invoking the script from a terminal.

---

## Hyprland Wallpaper Configuration

The autogenerated Hyprland configuration originally contained the following wallpaper-related settings:

```text
misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
}
```

These settings were no longer necessary after introducing swaybg.

The wallpaper functionality was therefore removed from the active Hyprland configuration.

This prevents Hyprland from maintaining a second wallpaper mechanism alongside the independent Project Kintsugi wallpaper subsystem.

---

Final Architecture

The resulting architecture is:

```text
Hyprland
   │
┌────────┴────────┐
│                 │
Session start      Super + W
│                 │
▼                 ▼
wallpaper.sh      wallpaper-menu.sh
│                 │
│            ┌────┴────┐
│            │ Fuzzel  │
│            └────┬────┘
│                 │
│                 ▼
│         wallpaper.conf
│                 │
└────────┬────────┘
   ▼
swaybg
┌─────┴─────┐
▼           ▼
eDP-1       HDMI-A-1
```

This architecture separates user interaction, configuration, execution, and rendering.

---

## Validation

The implementation was validated incrementally without requiring a system reboot.

---

## Shared Wallpaper

The following configuration was tested:

```text
mode=same
wallpaper=kintsugi-desktop.png
```

The resulting swaybg process confirmed that the same image was assigned to both outputs.

The result was also verified visually on both displays.

---

## Per-Output Wallpapers

The following configuration was tested:

```text
mode=per-output
eDP_1=kintsugi-desktop.png
HDMI_A_1=kintsugi-laptop.png
```

The resulting swaybg process confirmed that each output received the configured image.

The result was also verified visually on both displays.

---

## Graphical Selector

The `Super + W` shortcut was tested.

The following workflow was successfully validated:

```text
Super + W
    │
    ▼
Wallpaper menu
    │
    ├── Both monitors
    │
    └── One image per monitor
              │
              ├── Select eDP-1 wallpaper
              └── Select HDMI-A-1 wallpaper
```

The selected wallpapers were applied immediately and the configuration file was updated correctly.

---

## Runtime Process

The wallpaper renderer runs as a swaybg process.

During validation, the process was confirmed with:

```text
pgrep -a swaybg
```

The process command line correctly reflected the configured outputs and wallpaper files.

The wallpaper selector terminates the existing swaybg process before starting a new one, ensuring that only the current wallpaper configuration remains active.

---

## Configuration Files

The final implementation uses:

```text
~/.config/hypr/
├── hyprland.lua
├── wallpaper.conf
└── scripts/
    ├── wallpaper.sh
    └── wallpaper-menu.sh
```

Wallpaper images are stored separately:

```text
~/Pictures/Wallpapers/
```

This separation keeps executable logic, configuration, and user assets independent.

---

## Results

The final wallpaper subsystem provides:

- wayland-native wallpaper rendering;
- independent operation from KDE Plasma;
- independent operation from Hyprland's wallpaper mechanism;
- multi-monitor support;
- shared wallpaper support;
- per-output wallpaper support;
- graphical wallpaper selection;
- automatic session startup;
- simple file-based configuration;
- fuzzel integration;
- keyboard-driven access;
- no additional package repository;
- minimal system dependencies.

---

## Known Limitations

The current implementation intentionally remains simple.

It does not currently provide:

- automatic wallpaper rotation;
- randomized wallpaper selection;
- wallpaper scheduling;
- image previews in the selector;
- per-output wallpaper collections;
- wallpaper transition effects.

These features can be considered later if they become useful, but they are not required for the current Project Kintsugi desktop architecture.

---

## Conclusion

Wallpaper management has been successfully implemented as an independent Project Kintsugi component.

`swaybg` provides the rendering backend, while shell scripts provide configuration and user interaction.

The resulting system supports both shared and per-output wallpapers and integrates cleanly with the existing Hyprland session.

The implementation avoids unnecessary KDE Plasma dependencies and keeps wallpaper management independent from the compositor's internal wallpaper functionality.

The component is therefore considered complete for the current stage of Project Kintsugi.