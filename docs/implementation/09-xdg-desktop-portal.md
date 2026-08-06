# XDG Desktop Portal

## Objective

The objective of this implementation was to validate and adopt the XDG Desktop Portal infrastructure used by the Hyprland desktop environment.

Rather than introducing a custom configuration, the implementation focused on verifying that the existing Fedora configuration satisfied the architectural and functional requirements established by Project Kintsugi.

---

## Background

Previous phases of Project Kintsugi established the core desktop infrastructure, including session management through UWSM, graphical authentication, Secret Service integration, and automatic screen locking.

Desktop portal functionality is required to provide standardized desktop integration for modern Wayland applications, including screen sharing, screenshots, file selection, and other desktop services.

Because the system originated from a Fedora KDE Plasma installation, the existing portal infrastructure required evaluation before being adopted as part of the project's target architecture.

---

## Scope

This implementation included:

* verifying the installed portal infrastructure;
* validating backend selection for the Hyprland session;
* inspecting portal configuration;
* validating systemd user services;
* validating screen sharing functionality;
* validating file chooser functionality;
* confirming compatibility with the current Hyprland session.

The implementation did not include:

* replacing the existing portal configuration;
* creating custom `portals.conf` files;
* removing KDE portal components;
* modifying Fedora's default backend selection.

---

## Installed Components

The following portal components were present on the system:

* xdg-desktop-portal
* xdg-desktop-portal-hyprland
* xdg-desktop-portal-gtk
* xdg-desktop-portal-kde

The KDE backend remains installed because the system still includes a Plasma desktop session.

Its presence does not affect the Hyprland session, which uses its own backend selection configuration.

---

## Configuration

Fedora provides the following Hyprland portal configuration:

```ini
[preferred]
default=hyprland;gtk
```

This configuration automatically selects:

* `xdg-desktop-portal-hyprland` for compositor-specific interfaces;
* `xdg-desktop-portal-gtk` for generic desktop interfaces not implemented by the Hyprland backend.

No additional configuration was required.

---

## Service Integration

Validation confirmed the following active user services:

* `xdg-desktop-portal.service`
* `xdg-desktop-portal-hyprland.service`
* `xdg-desktop-portal-gtk.service`
* `xdg-document-portal.service`

The services are activated through the user systemd instance and integrate correctly with the graphical session managed by UWSM.

No manual service management or startup scripts were required.

---

## Validation

The implementation was validated by confirming:

* active portal services;
* correct backend selection for a Hyprland session;
* successful initialization of the Hyprland backend;
* successful screen sharing using the WebRTC ScreenCast API;
* successful multi-monitor selection;
* successful file selection using the FileChooser portal;
* expected portal activity recorded by `xdg-desktop-portal-hyprland`;
* no functional errors observed during validation.

---

## Results

Observed results include:

* the generic portal service operating correctly;
* the Hyprland backend handling compositor-specific interfaces;
* the GTK backend providing generic desktop interfaces;
* successful screen sharing from Brave;
* successful file selection through the desktop portal;
* correct backend selection using Fedora's default Hyprland configuration;
* no additional configuration required.

---

## Architecture Notes

The resulting portal architecture consists of:

* `xdg-desktop-portal` providing the standard D-Bus interfaces;
* `xdg-desktop-portal-hyprland` implementing Hyprland-specific functionality;
* `xdg-desktop-portal-gtk` implementing generic desktop interfaces;
* `systemd --user` managing portal services;
* Hyprland exposing the compositor functionality consumed by the backend.

Each component maintains a clearly defined responsibility while preserving the modular desktop architecture adopted by Project Kintsugi.

---

## Conclusion

The existing Fedora XDG Desktop Portal configuration satisfies the architectural and functional requirements established by Project Kintsugi.

Validation confirmed that the default combination of the generic portal service, the Hyprland backend, and the GTK backend provides complete integration for modern Wayland desktop applications.

No modifications to the default portal configuration were required, and the existing implementation has been adopted as the project's standard desktop portal architecture.

---

## Next Step

With desktop portal integration validated, Project Kintsugi can continue evaluating the remaining desktop infrastructure components required to complete Phase 1, including power management, audio, Bluetooth, and network management.