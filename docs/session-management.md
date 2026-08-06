# Session Management

## Introduction

Session management is the infrastructure responsible for creating, maintaining, and terminating the graphical desktop session.

It coordinates the lifecycle of the graphical environment, initializes the Wayland compositor, manages the relationship with the user session, and provides the execution context required by desktop services.

Unlike the compositor itself, session management focuses on orchestration rather than rendering.

---

## Why This Component Matters

A modern Linux desktop environment requires more than a graphical compositor.

The session infrastructure is responsible for:

* creating a consistent user session;
* coordinating service startup;
* managing session shutdown;
* integrating with the init system;
* providing a predictable execution environment for desktop services.

Without proper session management, user services may start inconsistently or fail to integrate with the graphical environment.

---

## Responsibilities

A session management component is responsible for:

* launching the graphical compositor;
* integrating the graphical session with the operating system;
* coordinating service startup and shutdown;
* exposing the session lifecycle to user services;
* managing environment propagation;
* providing a stable execution context.

Its responsibility ends at managing the session lifecycle.

Desktop applications, panels, notification daemons, authentication agents, and other user services remain independent components executed within the session.

---

## Relationship with systemd

Project Kintsugi adopts systemd as the service manager for both system and user services.

A complete graphical session should expose its lifecycle through systemd targets, allowing user services to participate naturally in session startup and shutdown.

This integration improves reliability, dependency management, and long-term maintainability.

---

## Relationship with Wayland

Wayland defines the communication protocol between the compositor and graphical applications.

Session management operates above the protocol layer by creating the environment in which the Wayland compositor executes.

The session manager is therefore responsible for establishing the runtime environment before graphical applications become available.

---

## Relationship with Hyprland

Hyprland is responsible for compositing and window management.

It does not provide a complete session management framework.

Project Kintsugi therefore treats session management as an independent architectural component that complements the compositor without replacing its responsibilities.

---

## Design Considerations

When evaluating session management solutions, Project Kintsugi considers:

* compatibility with Fedora;
* integration with systemd user services;
* compatibility with Wayland;
* compatibility with Hyprland;
* predictable session lifecycle;
* support for environment propagation;
* long-term maintainability;
* active upstream maintenance.

Preference is given to solutions that preserve a clean separation between compositor responsibilities and session orchestration.

---

## Separation of Concerns

Session management is not:

* a display manager;
* a window manager;
* a compositor;
* a login manager;
* a desktop environment.

Its sole responsibility is managing the lifecycle of the graphical user session.

---

## Project Kintsugi Perspective

Project Kintsugi considers session management a core infrastructure component.

The selected implementation should provide reliable integration between Hyprland, systemd, and user services while preserving the modular architecture of the desktop environment.

---

## Next Step

The next document evaluates available session management approaches and explains the implementation selected by Project Kintsugi.