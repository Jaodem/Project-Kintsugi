# Application Launcher Installation

## Objective

The objective of this implementation is to introduce an application launcher into the Hyprland session.

The launcher provides the primary mechanism for starting graphical applications without relying on desktop-specific menus.

---

## Background

Previous implementations introduced:

- Hyprland
- Kitty

The next logical desktop component is an application launcher.

Following the project's evaluation process, Fuzzel was selected because it is available from Fedora's official repositories and aligns with the project's architectural principles.

---

## Scope

This implementation is limited to:

- installing Fuzzel;
- verifying that it launches successfully;
- integrating it with Hyprland;
- validating application launching.

Desktop appearance and visual customization are outside the scope of this implementation.

---

## Next Step

With the application launcher successfully integrated, Project Kintsugi will continue introducing the remaining desktop components following the established engineering workflow.

The next implementation will focus on another foundational desktop service while preserving the project's incremental validation process.

---

## Validation

The implementation is successful when:

- Fuzzel installs correctly;
- it launches from a Hyprland keybinding;
- applications can be started;
- the launcher remains responsive.

---

## Installation

Fuzzel was installed from the official Fedora repositories.

To preserve the project's incremental approach, weak dependencies were not installed.

```bash
sudo dnf install --setopt=install_weak_deps=False fuzzel
```

---

## Results

Validation confirmed the following:

- Fuzzel was successfully installed.
- The launcher was integrated into Hyprland.
- The launcher opened correctly using the configured keyboard shortcut.
- Applications launched successfully through Fuzzel.
- The launcher operated correctly under the Hyprland Wayland session.

---

## Conclusion

The implementation objective was achieved successfully.

Project Kintsugi now includes a lightweight Wayland-native application launcher that integrates with the existing Hyprland session while remaining fully aligned with the project's package source and architectural principles.