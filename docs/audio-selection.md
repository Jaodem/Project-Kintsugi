# Audio Selection

## Objective

The purpose of this document is to select the audio infrastructure that will become the standard implementation for Project Kintsugi.

The selected solution should provide a reliable multimedia foundation for the desktop environment while preserving the project's modular architecture, application compatibility, long-term maintainability, and integration with the existing Fedora and Hyprland environment.

---

## Background

Project Kintsugi requires a complete audio infrastructure capable of supporting modern Linux desktop applications while remaining independent from the compositor.

The selected implementation must provide support for:

* desktop application audio;
* microphone input;
* hardware device management;
* compatibility with common Linux audio APIs;
* integration with the systemd user session.

Modern Linux desktop environments have transitioned from traditional audio server architectures toward more integrated multimedia frameworks that provide audio, video, and device management capabilities through modular components.

The objective of this evaluation is therefore to select an architecture that satisfies current desktop requirements without introducing unnecessary complexity.

---

## Evaluation Criteria

The selected implementation should satisfy the following requirements:

* native Linux audio integration;
* compatibility with Wayland desktop environments;
* support for modern applications;
* compatibility with existing audio APIs;
* active upstream maintenance;
* integration with systemd user services;
* availability through approved package sources;
* support for desktop and professional audio workflows;
* long-term maintainability;
* modular architecture.

Preference is given to solutions that provide broad compatibility while preserving clear separation between audio services, device management, and user interface components.

---

## Candidate Solutions

### PulseAudio

PulseAudio is a traditional Linux desktop audio server widely adopted before the transition toward newer multimedia frameworks.

It provides:

* application audio routing;
* volume management;
* network audio support;
* desktop-oriented audio handling.

However, PulseAudio was designed primarily around desktop audio use cases and does not provide the same level of integration with modern multimedia workflows.

Additionally, current Linux distributions increasingly replace the PulseAudio server with PipeWire while maintaining PulseAudio API compatibility.

---

### JACK

JACK is a professional audio server designed for low-latency audio production workflows.

It provides:

* highly precise audio routing;
* professional recording capabilities;
* low-latency operation;
* advanced audio graph management.

However, JACK introduces additional complexity for general desktop environments and requires specialized configuration for typical desktop use cases.

Modern Linux audio architectures increasingly provide JACK compatibility through PipeWire rather than maintaining a separate JACK server.

---

### PipeWire + WirePlumber

PipeWire is a modern multimedia framework designed to replace both PulseAudio and JACK use cases.

It provides:

* desktop audio management;
* professional audio capabilities;
* PulseAudio API compatibility;
* JACK compatibility;
* ALSA integration;
* application stream management;
* unified multimedia architecture.

WirePlumber acts as the session manager responsible for:

* device policy;
* automatic routing;
* profile management;
* session-level decisions.

Together, PipeWire and WirePlumber provide a modular architecture suitable for modern Linux desktop environments.

---

## Fedora Evaluation

Fedora has adopted PipeWire as the default audio infrastructure for modern desktop installations.

Package validation confirmed the availability of the required components through Fedora repositories:

* `pipewire`
* `pipewire-pulseaudio`
* `pipewire-alsa`
* `pipewire-jack-audio-connection-kit`
* `wireplumber`

The current system already contained and utilized this architecture through the Fedora KDE Plasma installation.

The validation confirmed that:

* PipeWire services were active through systemd user services;
* WirePlumber was running as the session manager;
* PulseAudio compatibility was provided through PipeWire;
* ALSA devices were correctly exposed;
* applications were able to use the audio infrastructure.

---

## Decision

Project Kintsugi adopts the following audio architecture:

* PipeWire as the multimedia audio server;
* WirePlumber as the session manager;
* pipewire-pulseaudio as the PulseAudio compatibility layer;
* pipewire-alsa for ALSA application compatibility;
* pipewire-jack-audio-connection-kit for JACK compatibility.

This architecture provides a complete audio foundation while maintaining the project's modular design principles.

PulseAudio and JACK standalone servers are not selected because their functionality is already provided through PipeWire compatibility layers.

---

## Trade-offs

The selected architecture provides several advantages:

* modern upstream development;
* broad application compatibility;
* support for both desktop and professional audio workflows;
* integration with current Linux distributions;
* reduced number of independent audio services.

The main trade-off is increased architectural complexity compared with a traditional PulseAudio-only setup.

However, this complexity is contained within well-defined components and provides greater flexibility for future desktop requirements.

---

## Validation

The selected implementation was validated through:

* verification of installed packages;
* verification of active PipeWire services;
* verification of WirePlumber session management;
* successful desktop audio playback;
* successful microphone device detection;
* successful volume control;
* successful mute control;
* successful audio state persistence after system restart;
* successful analog output switching when connecting headphones.

The validation confirmed that the selected architecture satisfies the functional requirements established during evaluation.

---

## Conclusion

Project Kintsugi standardizes on PipeWire and WirePlumber as the desktop audio infrastructure.

This architecture provides a reliable, maintainable, and modern audio foundation while preserving compatibility with existing Linux audio applications.

The selected solution integrates naturally with the Fedora base system and follows the project's modular desktop architecture principles.
