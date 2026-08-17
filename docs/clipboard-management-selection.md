# Clipboard Management Selection

## Objective

The purpose of this document is to select the Clipboard Management infrastructure for Project Kintsugi.

The selected implementation should integrate naturally with Fedora, remain compatible with Hyprland, and preserve the project's modular architecture.

---

## Background

Clipboard functionality under Wayland is based on standardized protocol mechanisms implemented by the compositor.

The evaluation focused on identifying:

- the protocol implementation;
- command-line clipboard utilities;
- optional clipboard managers;
- compatibility with the existing desktop session.

---

## Evaluation Criteria

The selected infrastructure should provide:

- compliance with Wayland standards;
- compatibility with Fedora KDE Plasma;
- compatibility with Wayland;
- compatibility with Hyprland;
- modular architecture;
- active upstream maintenance;
- availability through official Fedora repositories.

---

## Evaluated Components

### Wayland Clipboard Protocol

The Wayland protocol provides standardized clipboard communication between applications.

Validation confirmed:

- successful clipboard data transfer;
- support for multiple MIME types;
- compatibility with the Hyprland session.

---

### wl-clipboard

wl-clipboard provides command-line utilities for interacting with the Wayland clipboard.

Validation confirmed:

- package installation;
- successful clipboard write operations;
- successful clipboard read operations;
- MIME type inspection.

---

### Clipboard History Managers

Clipboard history managers provide persistent clipboard storage and history browsing.

The following components were considered:

- cliphist
- Klipper
- CopyQ

`cliphist` was selected as the clipboard history component because it provides lightweight clipboard persistence while remaining compatible with the existing Wayland and Hyprland architecture.

The implementation does not replace the native Wayland clipboard infrastructure. Instead, `cliphist` operates as an additional user-level service that stores clipboard contents observed through `wl-paste`.

This is particularly relevant for short-lived applications such as KDE Plasma's Emoji Selector, which may terminate after producing clipboard data.

---

### cliphist

`cliphist` provides persistent clipboard history for the Wayland session.

The selected implementation uses:

```text
wl-paste --type text --watch cliphist store
```

The service continuously observes clipboard changes and stores the received text in the clipboard history.

Validation confirmed:

* successful installation;
* successful clipboard history storage;
* successful retrieval through `cliphist list`;
* successful restoration through `cliphist decode`;
* compatibility with `wl-copy`;
* successful integration with the Hyprland session.

---

## Decision

Project Kintsugi adopts the native Wayland clipboard infrastructure together with `wl-clipboard` and `cliphist`.

The selected architecture is:

```text
Applications
        │
        ▼
Wayland Clipboard Protocol
        │
        ▼
Hyprland
        │
        ▼
Clipboard Selection
        │
        ├── wl-copy
        └── wl-paste
                │
                ▼
             cliphist
                │
                ▼
       Clipboard History Storage
```

The native Wayland clipboard remains responsible for normal clipboard operations.

`wl-copy` and `wl-paste` provide command-line access to the clipboard, while `cliphist` provides persistence for clipboard contents through a user-level systemd service.

This architecture preserves the existing modular design while solving the persistence problem associated with short-lived clipboard producers.

---

## Trade-offs

Using the native Wayland clipboard infrastructure together with `wl-clipboard` and `cliphist` preserves a lightweight and modular architecture while providing clipboard persistence.

The additional component introduces a small user-level background service, but avoids replacing the native clipboard implementation or introducing a full desktop clipboard manager.

The resulting architecture provides standard clipboard operations as well as persistent clipboard history when required.

---

## Validation

The selected architecture was validated through:

- verification of the wl-clipboard package;
- successful clipboard write operations;
- successful clipboard read operations;
- successful MIME type enumeration;
- successful installation and execution of cliphist;
- successful clipboard history storage through the user-level systemd service;
- successful retrieval through `cliphist list`;
- successful restoration through `cliphist decode`;
- successful integration with the Hyprland session;
- successful preservation of clipboard contents produced by short-lived applications.

---

## Conclusion

Project Kintsugi standardizes on the native Wayland clipboard infrastructure using Hyprland as the compositor, wl-clipboard as the command-line interface, and cliphist as the lightweight clipboard history and persistence layer.

This approach preserves the project's modular architecture while providing both standard clipboard operations and persistent clipboard history for applications whose clipboard contents may otherwise disappear when the application exits.