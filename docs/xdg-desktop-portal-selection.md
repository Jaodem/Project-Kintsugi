# XDG Desktop Portal Backend Selection

## Objective

The purpose of this document is to select the XDG Desktop Portal backend architecture that will become the standard implementation for Project Kintsugi.

The selected solution should integrate naturally with Hyprland while preserving the project's modular architecture, compatibility with modern Wayland applications, and long-term maintainability.

---

## Background

Project Kintsugi is built on Fedora using Hyprland as its Wayland compositor.

The desktop portal infrastructure enables applications to interact with the graphical session through standardized D-Bus interfaces instead of compositor-specific implementations.

Fedora already provides the generic portal service together with multiple backend implementations. The objective of this evaluation is to determine which backend architecture best aligns with Project Kintsugi's engineering principles.

---

## Evaluation Criteria

The selected solution should satisfy the following requirements:

* native Hyprland support;
* compatibility with modern Wayland applications;
* active upstream maintenance;
* availability through approved package sources;
* minimal configuration complexity;
* modular architecture;
* long-term maintainability.

The objective is selecting a reliable desktop infrastructure rather than maximizing desktop-specific functionality.

---

## Candidate Backends

### xdg-desktop-portal-hyprland

Provides Hyprland-native implementations for compositor-specific interfaces, including:

* Screenshot
* ScreenCast
* GlobalShortcuts
* InputCapture

It is developed as part of the Hyprland ecosystem and integrates directly with the compositor through Wayland protocols.

---

### xdg-desktop-portal-gtk

Provides generic desktop portal implementations shared across multiple desktop environments.

Typical responsibilities include:

* FileChooser
* AppChooser
* Print
* Notification
* Settings
* Access

It complements compositor-specific backends by implementing interfaces outside the scope of Hyprland.

---

### xdg-desktop-portal-kde

Provides a comprehensive KDE implementation of the XDG Desktop Portal interfaces.

While appropriate for Plasma sessions, its preferred desktop is KDE and it is not selected for native Hyprland sessions.

The package may remain installed while Plasma is still present on the system.

---

## Fedora Evaluation

Evaluation confirmed that Fedora provides the required portal infrastructure for a Hyprland session.

The detected configuration consists of:

* `xdg-desktop-portal`
* `xdg-desktop-portal-hyprland`
* `xdg-desktop-portal-gtk`

The system also includes `xdg-desktop-portal-kde` as part of the existing Plasma installation.

Hyprland distributes the following portal preference configuration:

```ini
[preferred]
default=hyprland;gtk
```

This configuration instructs the portal service to use the Hyprland backend whenever available while delegating unsupported interfaces to the GTK backend.

No additional portal configuration was required.

---

## Decision

Project Kintsugi adopts the following portal architecture:

* `xdg-desktop-portal`
* `xdg-desktop-portal-hyprland`
* `xdg-desktop-portal-gtk`

This architecture follows Fedora's default Hyprland configuration and the upstream recommendations for modern Wayland environments.

The KDE backend may remain installed while the Plasma desktop environment is present, but it is not considered part of the target Hyprland architecture.

---

## Validation

The selected architecture was validated by confirming:

* active `xdg-desktop-portal.service`;
* active `xdg-desktop-portal-hyprland.service`;
* active `xdg-desktop-portal-gtk.service`;
* successful initialization of the Hyprland backend;
* successful screen sharing through the ScreenCast portal;
* successful multi-monitor selection;
* successful file selection through the FileChooser portal;
* correct backend selection for the Hyprland session;
* no functional issues observed during validation.

These tests confirmed that the selected portal architecture integrates correctly with the current Hyprland session.

---

## Conclusion

Project Kintsugi standardizes on the combination of the generic XDG Desktop Portal service, the Hyprland backend, and the GTK backend.

This architecture provides a modular, standards-compliant, and well-integrated solution for modern Wayland desktops while remaining fully compatible with Fedora and the project's long-term maintenance objectives.