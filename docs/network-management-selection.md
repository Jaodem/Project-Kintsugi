# Network Management Selection

## Objective

The purpose of this document is to select the network management implementation that will become the standard solution for Project Kintsugi.

The selected solution should provide reliable network connectivity while preserving the project's modular architecture, compatibility with Fedora, integration with system services, and long-term maintainability.

---

## Background

Project Kintsugi requires a network management layer capable of operating independently from the graphical desktop environment.

Hyprland does not provide built-in network management functionality, therefore this responsibility must be delegated to a dedicated system component.

The objective of this evaluation is to select a network management solution that provides complete connectivity management while avoiding unnecessary dependencies on a specific desktop environment.

---

## Evaluation Criteria

The selected implementation should satisfy the following requirements:

* compatibility with Fedora;
* support for modern wireless and wired networking;
* integration with systemd;
* persistent connection profiles;
* authentication support through Polkit;
* compatibility with Wayland desktop environments;
* active upstream maintenance;
* availability through approved package sources;
* predictable administrative interface;
* long-term maintainability.

Preference is given to solutions that provide a complete backend service while allowing graphical interfaces to remain independent.

---

## Candidate Solutions

### NetworkManager

`NetworkManager` is a widely adopted Linux network management service designed for desktop and general-purpose systems.

It provides:

* wireless network management;
* wired connection management;
* persistent connection profiles;
* VPN integration;
* hardware detection;
* D-Bus API integration;
* command-line administration through `nmcli`;
* graphical integration through independent client applications.

Its architecture separates the network backend from user-facing interfaces, allowing desktop environments to choose their preferred interaction layer.

---

### systemd-networkd

`systemd-networkd` is a network management daemon developed as part of the systemd project.

It provides:

* lightweight network configuration;
* native systemd integration;
* deterministic configuration;
* support for servers and minimal systems.

Advantages:

* minimal dependencies;
* direct systemd integration;
* simple architecture.

Limitations:

* less focused on interactive desktop usage;
* wireless management commonly requires additional components;
* fewer desktop-oriented integrations;
* less suitable for dynamic user-controlled environments.

---

### ConnMan

`ConnMan` is a lightweight network management daemon originally developed for embedded and mobile environments.

It provides:

* wireless management;
* connection profiles;
* D-Bus integration;
* low resource consumption.

Advantages:

* lightweight architecture;
* suitable for constrained systems.

Limitations:

* lower adoption on general desktop distributions;
* fewer Fedora desktop integrations;
* smaller ecosystem compared with NetworkManager.

---

## Fedora Evaluation

Package and system validation confirmed that Fedora already provides a complete NetworkManager installation.

The current system includes:

* `NetworkManager`;
* `NetworkManager-wifi`;
* `NetworkManager-bluetooth`;
* `nm-connection-editor`;
* `plasma-nm` inherited from the Fedora KDE base installation.

The active NetworkManager service was validated through:

* successful systemd service execution;
* active Wi-Fi management;
* wireless network discovery;
* persistent connection handling;
* active connection reporting;
* permission validation through NetworkManager's D-Bus interface.

The existing installation operates correctly under Hyprland without requiring Plasma components.

---

## Decision

Project Kintsugi adopts:

```text
NetworkManager
```

as the standard network management backend.

The selected architecture is:

```text
NetworkManager
        |
        |
   Network Interfaces
        |
        |
 User Interface Layer
 (future component)
```

NetworkManager provides the required functionality while maintaining a clean separation between backend infrastructure and graphical interaction.

---

## Trade-offs

Selecting NetworkManager introduces a larger dependency footprint compared with minimal solutions such as systemd-networkd.

However, this trade-off is justified by:

* better desktop integration;
* mature wireless support;
* established Fedora ecosystem integration;
* extensive tooling availability;
* compatibility with independent graphical clients;
* proven long-term maintenance.

The additional functionality aligns with the requirements of a full desktop environment.

---

## Validation

The selected implementation was validated through:

* confirmation that NetworkManager service is active;
* confirmation that NetworkManager starts correctly through systemd;
* successful Wi-Fi hardware detection;
* successful wireless network scanning;
* successful connection management;
* successful active connection reporting;
* successful permission integration through Polkit;
* successful operation without KDE Plasma network components running.

The validation confirmed that NetworkManager satisfies the requirements established during evaluation.

---

## Conclusion

Project Kintsugi standardizes on NetworkManager as the network management backend.

This decision provides a reliable and maintainable networking foundation while preserving the modular architecture of the Hyprland desktop environment.

Graphical network interaction remains an independent concern and can be evaluated separately in future desktop integration phases.
