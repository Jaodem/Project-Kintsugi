# Bluetooth Selection

## Objective

The purpose of this document is to select the Bluetooth management architecture for Project Kintsugi.

The selected implementation should provide reliable Bluetooth functionality while preserving the project's modular architecture and long-term maintainability.

---

## Background

Fedora already provides the BlueZ Bluetooth stack as part of the operating system.

Project Kintsugi therefore evaluates only the user-facing management layer required to operate the existing Bluetooth infrastructure.

The selected solution should integrate naturally with BlueZ without introducing unnecessary dependencies on a desktop environment.

---

## Evaluation Criteria

The selected implementation should provide:

- compatibility with Fedora;
- compatibility with Wayland;
- compatibility with Hyprland;
- integration with systemd;
- separation between backend and frontend;
- active upstream maintenance;
- long-term maintainability;
- availability in official repositories.

---

## Existing Infrastructure

System validation confirmed that the following infrastructure was already operational:

- BlueZ installed;
- bluetooth.service active;
- Bluetooth adapter detected;
- D-Bus integration functional;
- PipeWire Bluetooth audio integration operational.

No replacement of the Bluetooth backend was required.

---

## Candidate Approaches

### bluetoothctl

The official BlueZ command-line interface.

Advantages:

- official upstream tool;
- minimal dependencies;
- scriptable;
- suitable for troubleshooting.

Limitations:

- command-line only;
- less convenient for daily device management.

---

### Blueman

Blueman provides a graphical management interface for BlueZ.

Advantages:

- dedicated Bluetooth management interface;
- pairing and device management;
- integration with BlueZ through D-Bus;
- desktop-environment independent.

Limitations:

- additional GTK dependency.

---

## Fedora Evaluation

Fedora provides Blueman through the official repositories.

The package integrates naturally with the existing BlueZ infrastructure and supports execution within modern Wayland sessions.

---

## Decision

Project Kintsugi adopts:

```text
BlueZ
        │
        ▼
Blueman
```

BlueZ remains responsible for Bluetooth communication while Blueman provides the graphical management interface.

This separation preserves a modular architecture and clearly defined component responsibilities.

---

## Trade-offs

Compared with relying exclusively on bluetoothctl, the selected solution introduces an additional graphical application.

However, it provides:

- improved usability;
- dedicated pairing management;
- desktop-independent operation;
- clean separation between backend and frontend.

These characteristics align with Project Kintsugi's architectural goals.

---

## Validation

The selected architecture was validated through:

- successful Blueman installation;
- successful integration with BlueZ;
- successful systemd user session integration;
- successful device discovery;
- successful pairing;
- successful device connection;
- successful Bluetooth audio playback through PipeWire.

---

## Conclusion

Project Kintsugi standardizes on BlueZ as the Bluetooth backend and Blueman as the graphical management interface.

The resulting architecture provides reliable Bluetooth functionality while preserving the project's modular desktop design.