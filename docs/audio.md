# Audio

## Introduction

Audio is the desktop component responsible for providing multimedia audio services within the user session.

It manages the communication between applications, audio devices, and the underlying hardware while providing a unified interface for playback, recording, and multimedia session management.

Modern Linux desktop environments no longer rely on a single audio server implementation. Instead, current architectures separate audio processing, application compatibility, hardware access, and device policy management into independent components.

This separation aligns with the modular architecture promoted by Project Kintsugi.

---

## Why This Component Matters

Audio functionality is a fundamental capability of a complete desktop environment.

Modern workflows require reliable support for:

* multimedia playback;
* microphone input;
* application audio streams;
* volume management;
* audio device switching;
* compatibility with different application audio interfaces.

A dedicated audio infrastructure provides these capabilities while maintaining a clear separation between applications, session management, and hardware access.

---

## Responsibilities

An audio infrastructure is responsible for:

* providing a unified audio service for desktop applications;
* managing communication between applications and audio devices;
* exposing compatibility layers for different audio APIs;
* handling playback and recording streams;
* managing audio device availability and routing;
* preserving multimedia session state.

Its responsibility ends at providing audio services and managing audio streams.

User interface elements such as volume indicators, keyboard shortcuts, desktop widgets, and graphical mixers remain the responsibility of separate desktop components.

---

## Relationship with Linux Audio Architecture

Linux audio systems consist of multiple layers with different responsibilities.

The hardware layer is managed through ALSA, which provides kernel-level audio device access.

Modern desktop environments commonly use PipeWire as the multimedia server layer, providing audio processing, application communication, and compatibility with different audio APIs.

A session manager such as WirePlumber is responsible for device policy, automatic routing, and session-level decisions.

This separation provides a flexible architecture where each component maintains a clearly defined responsibility.

---

## Relationship with Wayland

Wayland does not define an audio protocol.

Audio functionality is therefore independent from the compositor and operates through dedicated multimedia services.

Applications communicate with the audio infrastructure through supported APIs, while the compositor remains responsible only for graphical session management.

This separation allows Project Kintsugi to evaluate audio independently from Hyprland.

---

## Relationship with Hyprland

Hyprland does not provide built-in audio management.

Instead, audio functionality is provided by independent Linux multimedia components that operate alongside the compositor.

Project Kintsugi therefore evaluates audio solutions separately from Hyprland, selecting the implementation that best satisfies the project's requirements for modularity, compatibility, and long-term maintainability.

---

## Design Considerations

When selecting an audio infrastructure, Project Kintsugi considers:

* native Linux integration;
* compatibility with Wayland desktop environments;
* support for modern applications;
* compatibility with existing audio APIs;
* integration with systemd user services;
* active upstream maintenance;
* availability through approved package sources;
* long-term maintainability.

Preference is given to solutions that provide broad compatibility while maintaining a simple and modular architecture.

---

## Separation of Concerns

An audio infrastructure is not:

* a volume control interface;
* a desktop status bar module;
* a graphical mixer application;
* a Bluetooth management component;
* a media player;
* an application-specific audio configuration.

Its sole responsibility is providing the underlying multimedia audio services required by the desktop environment.

---

## Project Kintsugi Perspective

Project Kintsugi considers audio functionality to be an essential desktop infrastructure component.

The project prioritizes solutions that integrate naturally with modern Linux systems, preserve application compatibility, and maintain a clear separation between hardware access, multimedia services, and user interface components.

The selected implementation should provide a reliable foundation for desktop audio while remaining consistent with the project's modular architecture and long-term maintenance objectives.

---

## Next Step

The next document evaluates the available Linux audio solutions and selects the implementation adopted by Project Kintsugi.
