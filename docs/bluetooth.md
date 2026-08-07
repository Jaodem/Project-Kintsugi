# Bluetooth

## Introduction

Bluetooth provides short-range wireless communication between the computer and compatible peripheral devices.

Within a desktop environment, Bluetooth is responsible for device discovery, pairing, connection management, and communication with supported hardware.

Project Kintsugi treats Bluetooth as an independent infrastructure component with clearly defined responsibilities.

---

## Why This Component Matters

Modern desktop environments commonly rely on Bluetooth for peripherals such as:

- audio devices;
- keyboards;
- pointing devices;
- game controllers;
- mobile devices.

Reliable Bluetooth support requires a backend responsible for hardware communication together with user-facing tools that expose device management.

---

## Responsibilities

The Bluetooth subsystem is responsible for:

- managing Bluetooth adapters;
- discovering nearby devices;
- pairing and authentication;
- establishing device connections;
- exposing Bluetooth functionality through D-Bus.

Audio routing, desktop integration, and graphical interfaces remain separate responsibilities provided by other components.

---

## Relationship with BlueZ

BlueZ provides the Linux Bluetooth protocol stack.

It implements the system daemon responsible for hardware communication and exposes Bluetooth functionality through D-Bus.

Project Kintsugi adopts BlueZ as the Bluetooth backend.

---

## Relationship with systemd

The Bluetooth daemon operates as a system service managed by systemd.

Graphical Bluetooth management applications execute as user services within the graphical session.

This separation preserves the distinction between system infrastructure and user-facing functionality.

---

## Relationship with PipeWire

Bluetooth audio devices are handled through the interaction between BlueZ, WirePlumber, and PipeWire.

BlueZ provides device connectivity while PipeWire manages audio routing and media streams.

The Bluetooth component itself is not responsible for audio processing.

---

## Relationship with Hyprland

Hyprland does not provide native Bluetooth management.

Bluetooth support is therefore implemented independently of the compositor through dedicated infrastructure and user applications.

---

## Design Considerations

When evaluating Bluetooth solutions, Project Kintsugi considers:

- compatibility with Fedora;
- compatibility with Wayland;
- integration with systemd;
- separation between backend and frontend;
- active upstream maintenance;
- long-term maintainability;
- availability in official repositories.

Preference is given to solutions that preserve a modular architecture and avoid unnecessary desktop environment dependencies.

---

## Separation of Concerns

Bluetooth is not:

- an audio subsystem;
- a desktop environment feature;
- a network management component;
- a compositor feature.

Its responsibility is limited to Bluetooth communication and device management.

---

## Project Kintsugi Perspective

Project Kintsugi considers Bluetooth a core infrastructure component.

The implementation should provide reliable device management while remaining independent from the desktop environment and integrating naturally with the existing system infrastructure.

---

## Next Step

The next document evaluates the available Bluetooth management solutions and explains the implementation selected by Project Kintsugi.