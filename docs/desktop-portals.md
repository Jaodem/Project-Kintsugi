# Desktop Portals

## Introduction

Desktop Portals provide a standardized way for applications to request access to desktop features that should not be available without user consent or desktop integration.

Rather than allowing applications unrestricted access to the graphical session, Desktop Portals define controlled interfaces through which applications can request privileged operations.

This design aligns with the security model of modern Linux desktops and plays an important role in Wayland-based environments.

For Project Kintsugi, understanding Desktop Portals is essential because many desktop features depend on them, even though users rarely interact with them directly.

---

## Why Desktop Portals Exist

Modern desktop applications often need to perform actions that involve the user's desktop environment.

Examples include:

* Selecting files.
* Capturing the screen.
* Sharing a monitor or a window.
* Opening a URI with the default application.
* Requesting desktop notifications.
* Accessing other desktop-integrated features.

Under older graphical architectures, many of these operations relied on direct access to the desktop.

Wayland intentionally limits that access.

Instead of allowing applications to inspect or control the desktop freely, applications must explicitly request access through trusted desktop interfaces.

Desktop Portals provide those interfaces.

---

## A Standard Interface

Desktop Portals are not tied to a particular desktop environment or compositor.

Instead, they define standardized interfaces that applications can use without knowing which desktop environment is currently running.

This separation provides important benefits.

Applications only need to understand the portal interfaces.

The desktop environment is responsible for deciding how those requests are handled.

As a result, applications remain independent from specific desktop implementations while desktop environments remain free to provide their own portal backends.

---

## The Role of the Desktop Environment

A portal request does not perform an action by itself.

Instead, it is forwarded to the desktop environment through an appropriate portal backend.

The desktop environment may:

* present a permission dialog,
* ask the user to select a monitor or window,
* open a native file chooser,
* or deny the request entirely.

This architecture keeps control of privileged desktop operations inside the graphical session rather than inside individual applications.

The user remains in control of operations that affect the desktop.

---

## Security Through Mediation

Desktop Portals follow the principle of mediation.

Applications request access.

The desktop environment evaluates the request.

Only after user approval or desktop policy is the requested operation performed.

This approach provides stronger isolation between applications while preserving the functionality expected from a modern desktop.

Rather than granting unrestricted access, the desktop environment becomes the trusted intermediary between applications and privileged desktop resources.

---

## Why This Matters for Project Kintsugi

Project Kintsugi aims to understand every desktop component before selecting or configuring it.

Desktop Portals illustrate that many desktop features are no longer implemented through unrestricted application access, but through well-defined interfaces that cooperate with the compositor and the desktop environment.

Later in the project, decisions such as selecting a portal backend for Hyprland will be based on this architectural understanding rather than on installation guides or default configurations.

Understanding Desktop Portals now establishes the foundation for studying screenshots, screen sharing, file selection, notifications, and other desktop components that rely on these interfaces.
