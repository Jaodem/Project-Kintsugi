# Network Management

## Introduction

Network management is the desktop component responsible for controlling and maintaining network connectivity within the user session.

It provides the infrastructure required to manage network interfaces, establish connections, store connection profiles, and expose network capabilities to desktop applications.

In a modular Linux desktop environment, network management is intentionally separated from the graphical desktop shell. The network backend operates independently from the compositor, status bar, and user interface components.

This separation allows the desktop environment to select different interaction layers without replacing the underlying network infrastructure.

---

## Why This Component Matters

Network connectivity is a fundamental requirement of a modern desktop environment.

A complete network management solution must provide reliable handling of:

* wireless connections;
* wired connections;
* connection profiles;
* authentication requirements;
* network state changes;
* hardware availability;
* permission-controlled configuration changes.

A dedicated network management service ensures that connectivity remains available independently from the graphical environment.

---

## Responsibilities

A network management component is responsible for:

* detecting available network hardware;
* managing network interfaces;
* establishing and terminating connections;
* storing persistent connection profiles;
* handling wireless network discovery;
* integrating with system authentication mechanisms;
* exposing network state information to client applications.

Its responsibility ends at providing network connectivity and management services.

Graphical interfaces, status indicators, and user interaction layers remain separate desktop components.

---

## Relationship with Linux Networking

Modern Linux desktop environments require a layer between low-level networking subsystems and user-facing applications.

Network management solutions abstract hardware-specific details while providing a consistent interface for desktop environments.

This architecture allows applications and desktop components to interact with networking functionality without directly managing hardware devices or low-level network configuration.

---

## Relationship with Hyprland

Hyprland does not provide built-in network management functionality.

The compositor is responsible only for graphical session management and does not include services for controlling network interfaces.

Project Kintsugi therefore evaluates network management independently from the compositor, selecting an implementation that provides reliable connectivity while remaining compatible with a modular Wayland desktop.

---

## Design Considerations

When selecting a network management implementation, Project Kintsugi considers:

* compatibility with Fedora;
* integration with systemd;
* support for modern wireless hardware;
* persistent connection management;
* integration with Polkit;
* compatibility with Wayland desktop environments;
* active upstream maintenance;
* availability through approved package sources;
* long-term maintainability.

Preference is given to solutions that provide a complete network backend without introducing unnecessary dependencies on a specific desktop environment.

---

## Separation of Concerns

A network management component is not:

* a desktop panel;
* a status bar module;
* a graphical network applet;
* a VPN user interface;
* a network diagnostic application.

Its sole responsibility is managing network connectivity and exposing that functionality to other components.

Graphical interaction layers may be implemented separately.

---

## Project Kintsugi Perspective

Project Kintsugi considers network management an essential desktop infrastructure component.

The project prioritizes solutions that provide reliable connectivity, integrate naturally with Linux system services, and preserve the separation between backend services and graphical desktop components.

The selected implementation should remain independent from the compositor while allowing future integration with desktop interfaces such as status bars or dedicated network management applications.

---

## Next Step

The next document evaluates available network management solutions and selects the implementation adopted by Project Kintsugi.
