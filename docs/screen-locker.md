# Screen Locker

## Introduction

A screen locker is the desktop component responsible for protecting an active user session when the workstation is left unattended.

Rather than managing user sessions or authentication policies itself, the screen locker provides a secure graphical interface that prevents interaction with the desktop until the user successfully authenticates.

In a traditional desktop environment, screen locking is typically integrated into the desktop shell.

In a compositing window manager such as Hyprland, screen locking is implemented as an independent component that must be selected, configured, and maintained separately.

Understanding this separation is fundamental to building a modular desktop environment.

---

## Why This Component Matters

Leaving an unlocked desktop unattended represents both a security and privacy risk.

A screen locker provides protection by requiring user authentication before restoring access to the graphical session.

Modern desktop environments also integrate screen locking with idle detection and power management, allowing systems to automatically lock after periods of inactivity.

Without a screen locker, the desktop remains fully accessible until the user manually logs out or powers off the system.

---

## Responsibilities

A screen locker is responsible for:

* preventing interaction with the graphical session;
* displaying a secure authentication interface;
* validating user credentials through PAM;
* restoring the desktop after successful authentication.

Its responsibility ends once the user session has been unlocked.

Session management, power management, authentication policy, and user account management remain the responsibility of other system components.

---

## Relationship with PAM

Screen lockers authenticate users through the Pluggable Authentication Modules (PAM) framework.

Rather than implementing password verification themselves, they delegate authentication to the operating system through PAM.

This ensures consistent authentication behavior across graphical and non-graphical environments.

---

## Relationship with Hyprland

Hyprland intentionally does not include a screen locker.

Instead, it provides the interfaces required for external screen locking utilities to integrate with the compositor.

Project Kintsugi evaluates the available alternatives independently before selecting the implementation that best aligns with its architectural principles.

---

## Design Considerations

When selecting a screen locker, Project Kintsugi considers:

* native Wayland support;
* compatibility with Hyprland;
* PAM integration;
* active upstream maintenance;
* predictable behavior;
* availability through the project's approved package sources;
* long-term maintainability;
* clear separation of responsibilities.

Preference is given to implementations designed specifically for modern Wayland environments.

---

## Separation of Concerns

A screen locker is not:

* a session manager;
* an idle daemon;
* a power management service;
* an authentication framework;
* a desktop environment.

Its sole responsibility is protecting an active graphical session until the user successfully authenticates.

---

## Project Kintsugi Perspective

Project Kintsugi considers screen locking to be a fundamental security component rather than a cosmetic desktop feature.

Although a desktop can technically operate without one, automatic session protection is considered essential for a complete workstation environment.

---

## Next Step

The next document evaluates the available screen locker implementations before selecting the standard solution for Project Kintsugi.