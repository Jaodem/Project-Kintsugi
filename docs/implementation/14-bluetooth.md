# Bluetooth Implementation

## Objective

The objective of this implementation was to complete the Bluetooth infrastructure by providing a graphical management interface for the existing BlueZ backend.

The implementation preserves the existing Bluetooth stack while integrating user-facing management into the graphical session.

---

## Background

Previous implementations already established the system Bluetooth infrastructure through Fedora's default BlueZ installation.

System validation confirmed:

- BlueZ installed;
- bluetooth.service active;
- Bluetooth adapter available;
- D-Bus communication operational;
- Bluetooth audio integration with PipeWire.

Only the graphical management layer remained to be implemented.

---

## Scope

This implementation included:

- evaluation of Bluetooth management solutions;
- installation of Blueman;
- validation of BlueZ integration;
- validation of systemd user session integration;
- validation of Bluetooth discovery;
- validation of pairing;
- validation of Bluetooth audio playback.

The implementation did not include:

- replacement of the Bluetooth backend;
- modification of bluetooth.service;
- desktop environment specific integrations;
- Waybar tray configuration.

---

## Installed Components

The following package was installed from the official Fedora repositories:

- blueman

No additional repositories were required.

---

## Configuration

No custom configuration was added.

Fedora already provides native session integration through:

```
systemd-xdg-autostart-generator
```

which generates a user service associated with:

```
graphical-session.target
```

Project Kintsugi intentionally reuses this integration instead of introducing custom systemd units or compositor-specific startup commands.

---

## Integration

The resulting architecture is:

```text
BlueZ
 │
 ▼
bluetooth.service
 │
 ▼
D-Bus
 │
 ▼
Blueman
 │
 ▼
systemd-xdg-autostart-generator
 │
 ▼
graphical-session.target
```

Bluetooth audio devices are subsequently managed by WirePlumber and PipeWire.

---

## Validation

The implementation was validated through:

- successful Blueman installation;
- successful execution within the graphical session;
- successful D-Bus registration;
- successful Bluetooth device discovery;
- successful pairing;
- successful device connection;
- successful Bluetooth audio playback;
- successful PipeWire integration.

---

## Results

The final Bluetooth architecture provides:

- modular backend/frontend separation;
- native Fedora integration;
- systemd-managed graphical session integration;
- desktop-environment independent device management;
- compatibility with Wayland and Hyprland.

---

## Known Limitations

Blueman reports warnings related to plugins that require X11 and legacy networking functionality.

These warnings do not affect Bluetooth operation under Wayland and were validated as non-functional issues during implementation.

Waybar tray integration has not yet been configured and will be addressed as part of the future desktop interface implementation.

---

## Conclusion

Bluetooth support has been successfully standardized for Project Kintsugi.

The implementation preserves the existing BlueZ infrastructure while providing a dedicated graphical management interface integrated with the systemd-managed graphical session.