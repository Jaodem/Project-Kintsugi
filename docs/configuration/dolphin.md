# Dolphin Configuration

## Overview

This document records the configuration applied to Dolphin as part of Phase 4.7 (Core Applications – File Manager).

Dolphin is the standard file manager for Project Kintsugi. The goal of this configuration pass was to make it comfortable for daily use under Hyprland while keeping changes minimal and reversible.

---

## Applied Configuration

### General Behaviour

- Default view: **DetailTree**
- Sorting: by name, directories first, hidden files last
- Menu bar: disabled
- Embedded terminal panel (F4): **disabled**
- External terminal (“Open Terminal Here” / `Alt+Shift+F4`): **Kitty**

### Keyboard Integration

- Hyprland bind: `Super + E` → launches Dolphin
- No custom shortcuts were added inside Dolphin itself

### MIME Associations

| Type                        | Default Application |
|----------------------------|---------------------|
| Directories (`inode/directory`) | Dolphin            |
| Plain text / Markdown      | KWrite              |
| PDF                        | Okular              |
| Images (PNG, JPEG, WebP…)  | Gwenview            |
| Video                      | mpv                 |
| Archives (zip, tar, etc.)  | Ark                 |

---

## Configuration Files Touched

- `~/.config/dolphinrc`
- `~/.config/kdeglobals` (TerminalApplication + sorting)
- `~/.config/mimeapps.list`

---

## Known Issues

- **Color scheme persistence**: When using Breeze Dark, the text color of files and folders in the main view can become black (unreadable) after closing and reopening Dolphin. The sidebar remains correct. This is a known limitation of running KDE applications outside a full Plasma session and will be addressed in the dedicated theming phase.

---

## Notes

- The embedded Konsole terminal was intentionally disabled to reduce dependence on Plasma components.
- No plugins or advanced Dolphin features were enabled.
- Further visual refinement is deferred to the theming phase.