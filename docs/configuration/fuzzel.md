# Fuzzel Configuration

## Objective

The objective of this configuration is to define and document the visual configuration of Fuzzel used by Project Kintsugi.

Fuzzel is the primary application launcher and interactive menu interface for the Hyprland session. This document describes its visual configuration and integration with the project's system-wide visual theme.

---

## Background

Fuzzel was introduced during the initial desktop foundation as the application launcher for the Hyprland session.

The original implementation focused exclusively on installation, integration, and functional validation. Desktop appearance and visual customization were intentionally left outside the scope of the initial implementation.

During Phase 4.9, Fuzzel was revisited as part of the desktop appearance work. Its visual configuration was customized to match the Project Kintsugi color palette, typography, borders, and window styling.

---

## Scope

This configuration includes:

- Fuzzel as the application launcher and interactive menu interface;
- global visual styling through `fuzzel.ini`;
- Project Kintsugi color palette integration;
- typography;
- selection, matching, and text colors;
- border and rounding configuration.

This configuration does not include:

- workflow-specific menu behavior;
- menu positioning;
- menu width or number of visible lines;
- prompts;
- application launching behavior;
- individual menu logic.

These properties remain controlled by the scripts that invoke Fuzzel.

---

## Configuration File

The global Fuzzel configuration is stored at:

```text
~/.config/fuzzel/fuzzel.ini
```

The configuration defines the global properties shared by all Fuzzel-based menus.

Current configuration:

```ini
[main]
font=JetBrainsMono Nerd Font:weight=bold:size=12
terminal=kitty

[colors]
background=1A1A1AF2
text=F0F0F0FF
match=9A0A0AFF
selection=780606FF
selection-text=FFFFFFFF
border=780606FF

[border]
width=2
radius=10
```

---

## Visual Theme

The Fuzzel configuration follows the Project Kintsugi visual language established by the Hyprland and KDE/GTK theme configuration.

The primary visual elements are:

| Element | Color / Value |
|---------|---------------|
| **Background** | `#1A1A1A` |
| **Primary text** | `#F0F0F0` |
| **Match text** | `#9A0A0A` |
| **Selection** | `#780606` |
| **Selection text** | `#FFFFFF` |
| **Border** | `#780606` |
| **Border width** | `2px` |
| **Border radius** | `10px` |
| **Font** | `JetBrainsMono Nerd Font` |
| **Font size** | `12` |
| **Font weight** | Bold |

The dark-red accent used for selection and borders is the same primary accent used throughout the Project Kintsugi desktop theme.

---

## Workflow Integration

Fuzzel is used as a shared interaction layer across several Hyprland and Waybar workflows.

Current integrations include:

- application launcher;
- session menu;
- monitor management menu;
- wallpaper selection menu;
- Wi-Fi management menu;
- Bluetooth management menu;
- power profile menu.

The global configuration provides a consistent visual appearance across these interfaces.

Workflow-specific properties remain defined by the individual scripts. For example:

```text
--width
--lines
--anchor
--x-margin
--y-margin
--prompt
```

This separation prevents workflow-specific behavior from being coupled to the global visual configuration.

---

## Configuration Responsibility

The configuration follows the project's separation-of-responsibility principle.

```text
Fuzzel configuration
        │
        ├── Visual appearance
        │   ├── Colors
        │   ├── Font
        │   ├── Border
        │   └── Rounding
        │
        └── Menu scripts
            ├── Position
            ├── Size
            ├── Prompts
            ├── Available options
            └── Workflow behavior
```

This allows the appearance to be changed globally without modifying the individual workflow scripts.

---

## Validation

The configuration was validated through direct interactive use of the Fuzzel-based menus within the Hyprland session.

The following workflows were confirmed to use the configured visual appearance:

- session management;
- monitor management;
- wallpaper selection;
- Wi-Fi management;
- Bluetooth management;
- power profile selection.

The resulting appearance was evaluated against the existing Hyprland and system theme configuration.

The dark background, dark-red accent, typography, border, and rounding were confirmed to integrate consistently with the rest of the desktop environment.

---

## Results

The resulting Fuzzel configuration provides:

- a consistent visual appearance across Fuzzel-based workflows;
- integration with the Project Kintsugi color palette;
- consistent typography with the rest of the desktop environment;
- matching border and rounding values;
- centralized visual configuration;
- separation between appearance and workflow-specific behavior.

No additional theming framework or dependency was introduced.

---

## Reproducibility

The current Fuzzel configuration can be reproduced through:

```text
~/.config/fuzzel/fuzzel.ini
```

Fuzzel remains installed from the official Fedora repositories.

The individual workflow scripts continue to define their own invocation parameters, while the global configuration provides the shared visual appearance.

No additional configuration is required for the basic visual integration.

---

## Conclusion

Fuzzel is now visually integrated into the Project Kintsugi desktop environment.

The global configuration provides a consistent dark appearance using the project's dark-red accent, typography, border, and rounding values while preserving the existing separation between visual styling and workflow behavior.

The resulting configuration maintains the project's preference for simple, centralized, and maintainable solutions without introducing unnecessary dependencies or configuration layers.