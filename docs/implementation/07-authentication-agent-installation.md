# Authentication Agent Installation

## Objective

The objective of this implementation was to integrate a graphical authentication agent into the Hyprland desktop session.

The authentication agent provides the graphical interface required for user authentication during privileged operations managed by Polkit.

The implementation also ensured that the graphical session was correctly integrated with systemd, allowing the authentication agent to operate reliably throughout the user session.

---

## Background

Previous implementations introduced the following desktop infrastructure:

* Hyprland
* Kitty
* Fuzzel
* Dolphin
* Waybar
* Mako

Initial testing showed that installing an authentication agent alone was insufficient. Although the agent was present, the graphical session was not correctly managed by systemd, preventing Polkit from maintaining a registered authentication agent across user sessions.

During the implementation process, the desktop session was migrated to a UWSM-managed architecture, providing proper integration with systemd user services and enabling the expected behavior of graphical authentication components.

Additionally, GNOME Keyring was introduced to provide the Secret Service implementation required by modern desktop applications such as Brave.

---

## Scope

This implementation included:

* installing the Hyprland authentication agent;
* integrating Hyprland with UWSM;
* validating systemd graphical session management;
* enabling graphical Polkit authentication;
* enabling Secret Service support through GNOME Keyring;
* validating credential persistence for desktop applications.

The implementation did not include:

* custom Polkit policies;
* Polkit rule customization;
* desktop appearance customization;
* Secret Service customization.

---

## Installed Components

The following components were installed as part of this implementation:

* hyprpolkitagent
* uwsm
* gnome-keyring
* libsecret
* seahorse

All packages were installed following the project's package policy with weak dependencies disabled.

---

## Session Integration

The final implementation follows the upstream-recommended architecture.

Hyprland is started through UWSM, which integrates the compositor with the systemd user session.

This provides:

* active `graphical-session.target`;
* proper Wayland session lifecycle management;
* automatic activation of user services;
* reliable Polkit agent registration;
* D-Bus activation of GNOME Keyring services.

No manual startup scripts were required for either the authentication agent or GNOME Keyring.

---

## Validation

The implementation was validated through the following checks:

* successful installation of all required packages;
* active `graphical-session.target`;
* active UWSM-managed Hyprland session;
* running `hyprpolkitagent.service`;
* successful graphical authentication using GParted;
* functional Secret Service (`org.freedesktop.secrets`);
* successful credential persistence in Brave.

These validation steps confirmed that both graphical authentication and desktop credential storage were functioning correctly.

---

## Results

The implementation successfully achieved its objectives.

Observed results include:

* Hyprland session managed by UWSM.
* systemd graphical session operating correctly.
* `hyprpolkitagent` running successfully.
* graphical Polkit authentication functioning correctly.
* GNOME Keyring activated through D-Bus.
* Secret Service available for desktop applications.
* Brave correctly preserving user sessions and stored credentials.
* no manual service startup required.

The authentication infrastructure is now fully integrated into the desktop environment.

---

## Architecture Notes

The implementation demonstrated that installing an authentication agent alone is not sufficient.

Reliable Polkit authentication depends on a correctly managed graphical session.

The final architecture consists of:

* Hyprland as the Wayland compositor;
* UWSM providing session management;
* systemd managing the graphical user session;
* hyprpolkitagent providing graphical Polkit authentication;
* GNOME Keyring providing the Secret Service implementation.

This architecture closely follows the upstream recommendations for modern Wayland desktop sessions.

---

## Known Issues

The following observations remain under evaluation but do not currently affect functionality:

* Hyprland reports that `hyprland-guiutils` is not installed.
* Hyprland displays a warning indicating it was not started using `start-hyprland`, despite the session being managed by UWSM.
* Some KDE-related user services remain present from the Plasma installation and may require future evaluation.

The previously pending evaluation of `xdg-desktop-portal-hyprland` has been completed successfully and is no longer considered an outstanding issue.


---

## Conclusion

The authentication infrastructure has been successfully integrated into the Hyprland desktop environment.

The final implementation provides reliable graphical authentication through Polkit while also supplying a standards-compliant Secret Service implementation for desktop applications.

The resulting architecture follows current upstream recommendations for systemd-managed Wayland sessions and provides a stable foundation for subsequent desktop infrastructure development.

---

## Next Step

With the authentication infrastructure complete, Project Kintsugi can continue implementing the remaining desktop components while preserving the established system architecture and engineering methodology based on documentation, evaluation, implementation, validation, and version control.