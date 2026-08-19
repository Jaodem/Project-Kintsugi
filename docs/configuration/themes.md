# System Theme Configuration

## Overview

This document records the system-wide visual theme configuration applied as part of Phase 4.9 (Desktop Appearance).

The configuration establishes a consistent visual language across Qt and GTK applications while keeping the implementation compatible with the Hyprland session.

The selected visual style is based on Breeze Dark with a dark-red accent and a neutral grayscale palette. The custom KDE color scheme defines the primary application backgrounds, text colors, selection colors, focus decorations, and semantic colors used by KDE applications.

The configuration was applied and validated from within the Hyprland session using KDE System Settings. A Plasma desktop session is therefore not required to configure or maintain the KDE color scheme.

The current configuration focuses on:

- Qt application colors
- GTK application colors
- KDE color roles and state-specific colors
- Selection, focus, hover, and active-state colors
- Tooltip and header colors
- Icon theme
- Cursor theme
- Dark application preference
- Consistent red accent usage

Wallpaper management and final visual validation remain separate tasks within the Desktop Appearance phase.

---

## Applied Configuration

### Color Scheme

The active KDE color scheme is:

```text
BreezeDarkRed
```

The custom scheme is stored at:

```text
~/.local/share/color-schemes/BreezeDarkRed.colors
```

The scheme is based on Breeze Dark and replaces the default blue selection and focus accents with the project's dark-red accent.

The primary accent color is:

```text
#780606
```

This is the same accent selected for the active Hyprland window border.

### Main Colors

The visual palette uses the following values:

| Element                 |     Color |
| ----------------------- | --------: |
| View background         | `#1a1a1a` |
| View alternate          | `#242424` |
| Window background       | `#242424` |
| Window alternate        | `#2e2e2e` |
| Button background       | `#2e2e2e` |
| Button alternate        | `#3a3a3a` |
| Normal text             | `#f0f0f0` |
| Inactive text           | `#a0a0a0` |
| Selection background    | `#780606` |
| Selection alternate     | `#5c0505` |
| Selection text          | `#f0f0f0` |
| Focus decoration        | `#780606` |
| Hover decoration        | `#9a0a0a` |
| Selection hover         | `#c04040` |
| Link text               | `#9a0a0a` |
| Visited text            | `#a05a5a` |
| Negative text           | `#da4453` |
| Neutral text            | `#f67400` |
| Positive text           | `#27ae60` |


The palette intentionally retains distinct semantic colors for negative, neutral, and positive states rather than converting every semantic color to the primary red accent. The dark-red project accent is primarily used for selections, active states, focus decorations, and hover decorations.

---

## Qt Theme

Qt applications use the KDE color scheme through the KDE Qt platform theme.

The current environment reports:

```text
QT_QPA_PLATFORMTHEME=kde
```

No `QT_STYLE_OVERRIDE` is configured.

This allows KDE-aware Qt applications to use the selected KDE color scheme without introducing an additional Qt theme framework or overriding the native KDE color handling.

The configuration was validated with KDE applications including:

- Dolphin
- KWrite
- Okular
- KDE System Settings

These applications correctly reflect the selected dark-red visual language.

---

## GTK Theme

GTK applications use:

```text
Breeze-Dark
```

GTK is configured to prefer a dark appearance.

The following GTK settings are applied to both GTK 3 and GTK 4:

```text
gtk-theme-name=Breeze-Dark
gtk-application-prefer-dark-theme=true
```

GTK applications therefore use the Breeze Dark visual base while the generated color definitions incorporate the project's customized palette.

The GTK color configuration is maintained separately from the KDE color scheme. Its exact color definitions are documented independently from the KDE `.colors` file to avoid assuming that both toolkits expose identical color roles.

---

## GTK Color Overrides

GTK 3 and GTK 4 both import a custom `colors.css` file:

```text
@import 'colors.css';
```

The custom color definitions are stored at:

```text
~/.config/gtk-3.0/colors.css
~/.config/gtk-4.0/colors.css
```

The corresponding GTK style files are:

```text
~/.config/gtk-3.0/gtk.css
~/.config/gtk-4.0/gtk.css
```

The GTK color definitions can provide customized values for:

- Backgrounds
- Text
- Buttons
- Selections
- Focus decoration
- Hover decoration
- Links
- Visited links
- Error states
- Warning states
- Success states
- Inactive controls
- Tooltips
- Borders

The selection and focus colors use the project's primary dark-red accent rather than the default Breeze blue.

---

## Icon Theme

The selected icon theme is:

```text
Breeze Chameleon Dark
```

It is configured for both GTK 3 and GTK 4:

```text
gtk-icon-theme-name=Breeze Chameleon Dark
```

The custom icon theme is located at:

```text
~/.local/share/icons/Breeze Chameleon Dark
```

Using the same icon theme across GTK applications avoids introducing a separate visual icon language.

---

## Cursor Theme

The selected cursor theme is:

```text
breeze_cursors
```

The cursor size is:

```text
24
```

The current environment variables are:

```text
XCURSOR_THEME=breeze_cursors
XCURSOR_SIZE=24
```

GTK 2, GTK 3, and GTK 4 are also configured to use the same cursor theme.

This keeps cursor appearance consistent between the different application toolkits.

---

## Fonts

The GTK configuration currently uses:

```text
Noto Sans,  10
```

The font configuration is consistent across GTK 2, GTK 3, and GTK 4.

Font selection is treated as part of the existing desktop configuration rather than introducing a separate theme-specific font dependency.

---

## Configuration Files Touched

### KDE Color Scheme

- `~/.local/share/color-schemes/BreezeDarkRed.colors`

The KDE color scheme is the source of truth for the KDE-specific color roles documented in this file.

### GTK 2

- `~/.gtkrc-2.0`

### GTK 3

- `~/.config/gtk-3.0/settings.ini`
- `~/.config/gtk-3.0/gtk.css`
- `~/.config/gtk-3.0/colors.css`

### GTK 4

- `~/.config/gtk-4.0/settings.ini`
- `~/.config/gtk-4.0/gtk.css`
- `~/.config/gtk-4.0/colors.css`

### KDE Global Configuration

- `~/.config/kdeglobals`

The active KDE color scheme is recorded in `kdeglobals` as:

```text
ColorScheme=BreezeDarkRed
AccentColor=120,6,6
LastUsedCustomAccentColor=120,6,6
```

---

## KDE System Settings in Hyprland

KDE System Settings can be launched directly from the Hyprland session.

The relevant executable is:

```text
/usr/bin/systemsettings
```

The KDE System Settings desktop entry is also available from the application launcher.

The configuration interface can therefore be used without starting a Plasma desktop session.

This is useful for maintaining KDE-related configuration while keeping Hyprland as the active compositor and desktop session.

No Plasma session is required as part of the system theme architecture.

---

## Design Decisions

### Shared Visual Language

Qt and GTK applications use visually compatible Breeze-based themes rather than independent application-specific themes.

This reduces visual differences between applications while preserving native toolkit behaviour.

### Dark Base

Breeze Dark was selected as the common dark visual base.

The existing Breeze visual language is retained instead of introducing a third-party theme with additional dependencies.

### Project Accent

The project uses:

```text
#780606
```

as its primary visual accent.

A brighter red variant is used for hover and link-related states:

```text
#9a0a0a
```

The primary accent is used for:

- Hyprland active window borders
- KDE selection backgrounds
- KDE focus decorations
- KDE active states

The brighter variant is used for:

- KDE hover decorations
- KDE link colors
- Additional visual emphasis where required

This provides a consistent relationship between the compositor and application interfaces while allowing different interaction states to remain visually distinguishable.

### Semantic Colors

Semantic colors are intentionally preserved.

Positive, negative, and neutral states remain visually distinct:

```text
Positive  #27ae60
Negative  #da4453
Neutral   #f67400
```

The positive green value is retained because converting semantic success indicators to red would reduce their semantic clarity.

### Native Toolkit Configuration

No additional Qt theme framework was introduced.

In particular, qt5ct, qt6ct, and Kvantum are not currently required.

KDE's native color scheme handling is preferred because it integrates directly with KDE applications and can be configured from KDE System Settings while running under Hyprland.

### Minimal Dependencies

No additional GTK theme management utility was introduced.

GTK configuration is handled through the existing configuration files and gsettings.

No GNOME-specific theming stack is required.

### Reversible Configuration

The custom color scheme and GTK overrides are stored in user configuration directories.

The configuration can therefore be modified or removed without changing system-wide theme files.

---

## Current Theme Components

| Component         | Current Selection       |
| ----------------- | ----------------------- |
| Desktop session   | Hyprland                |
| Qt color scheme   | Breeze Dark Red         |
| KDE color scheme  | `BreezeDarkRed`         |
| GTK theme         | `Breeze-Dark`            |
| GTK icon theme    | `Breeze Chameleon Dark` |
| Cursor theme      | `breeze_cursors`         |
| Cursor size       | `24`                     |
| Primary accent    | `#780606`               |
| Hover accent      | `#9a0a0a`               |
| Base text         | `#f0f0f0`               |
| Inactive text     | `#a0a0a0`               |
| View background   | `#1a1a1a`               |
| Window background | `#242424`               |
| Button background | `#2e2e2e`               |


---

## Validation

The theme configuration was reviewed from within the Hyprland session.

The following applications were used to verify the visual result:

- Dolphin
- KWrite
- Okular
- Firefox
- KDE System Settings

The following aspects were checked:

- Dark application backgrounds
- Text contrast
- Selection colors
- Focus decorations
- Hover decorations
- Link colors
- Icon appearance
- Cursor appearance
- Consistency between Qt and GTK applications

Text selection was specifically reviewed because the default Breeze blue selection was visually inconsistent with the project's dark-red accent.

The KDE color scheme was adjusted so that selection backgrounds use:

```text
#780606
```

rather than the default blue accent.

GTK selection colors were also configured to use the same red visual language.

---

## Known Limitations

- Applications may implement their own colors and therefore may not fully follow the system theme.
- Firefox can contain UI elements whose appearance depends on its own toolkit integration and application-specific styling.
- GTK and Qt do not expose exactly the same set of theme roles, so some visual differences between toolkits may remain.
- Semantic colors such as positive, negative, and neutral states intentionally remain distinct from the primary project accent.
- Wallpaper selection and management are not part of this configuration.
- Final visual validation remains pending until the remaining Desktop Appearance components have been completed.
- Some KDE color roles, particularly inactive header and window-manager states, retain Breeze-derived colors because changing them would not provide a meaningful visual benefit.

---

## Notes

- The theme configuration was performed while running Hyprland.
- KDE System Settings is used as a configuration tool and does not imply that Plasma is the active desktop environment.
- The system currently contains both KDE and GTK theme configuration, but Hyprland remains the active session.
- The primary project accent is shared with the Hyprland window border configuration.
- The custom KDE color scheme is user-local and does not modify the system Breeze theme.
- GTK 3 and GTK 4 use matching custom color definitions.
- Icon and cursor configuration is already present and was included in the consistency review.
- Wallpaper management is intentionally deferred to the remaining Desktop Appearance work.