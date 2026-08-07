# Clipboard Management

## Introduction

Clipboard Management defines the standardized mechanism used by desktop applications to exchange data during a user session.

Rather than implementing copy and paste functionality independently, applications rely on the clipboard infrastructure provided by the Wayland protocol and the session compositor.

Project Kintsugi treats Clipboard Management as a core desktop infrastructure component independent from individual applications.

---

## Why This Component Matters

A modern desktop environment requires a standardized mechanism for transferring data between applications.

Clipboard Management provides the infrastructure required to:

- exchange data between applications;
- preserve interoperability across desktop software;
- support multiple data formats through MIME types;
- maintain compatibility with the Wayland protocol.

Without this infrastructure, applications would require application-specific data transfer mechanisms.

---

## Responsibilities

Clipboard Management is responsible for:

- providing clipboard data exchange;
- exposing clipboard selections;
- supporting multiple MIME types;
- enabling interoperability between applications.

Clipboard history, clipboard synchronization, and application-specific data handling are separate responsibilities implemented by optional components.

---

## Relationship with the Wayland Protocol

Project Kintsugi relies on the Wayland data transfer protocol for clipboard functionality.

The protocol defines:

- clipboard selections;
- data transfer negotiation;
- MIME type advertisement;
- communication between clients.

Clipboard operations are standardized by the protocol rather than by individual desktop environments.

---

## Relationship with Hyprland

Hyprland implements the Wayland clipboard protocol as part of its responsibilities as a Wayland compositor.

However, Hyprland is not a clipboard manager.

It does not provide:

- clipboard history;
- clipboard synchronization;
- clipboard persistence;
- user-facing clipboard utilities.

Its responsibility is limited to implementing the protocol required for communication between Wayland clients.

---

## Relationship with Clipboard Utilities

Project Kintsugi uses wl-clipboard as the standard command-line interface for interacting with the Wayland clipboard.

The utilities provide:

- clipboard read operations;
- clipboard write operations;
- MIME type inspection.

They operate on top of the clipboard infrastructure already provided by the Wayland session.

---

## Relationship with Applications

Applications interact with the clipboard through the Wayland protocol.

Applications may expose multiple MIME types simultaneously, allowing different target applications to consume the most appropriate representation of the copied data.

---

## Design Considerations

Project Kintsugi evaluates Clipboard Management using the following criteria:

- compliance with Wayland standards;
- compatibility with Fedora KDE Plasma;
- compatibility with Wayland;
- compatibility with Hyprland;
- modular architecture;
- long-term maintainability.

Preference is given to existing operating system infrastructure whenever it satisfies the project's requirements.

---

## Separation of Concerns

Clipboard Management is not:

- a clipboard history manager;
- a synchronization service;
- a desktop widget;
- an application launcher;
- an application-specific feature.

Its responsibility is limited to standardized data exchange between applications.

---

## Project Kintsugi Perspective

Project Kintsugi considers Clipboard Management a foundational desktop infrastructure component.

The selected implementation should rely on the Wayland protocol while avoiding unnecessary clipboard management software.

---

## Next Step

The next document evaluates the available Clipboard Management infrastructure and explains the implementation selected for Project Kintsugi.