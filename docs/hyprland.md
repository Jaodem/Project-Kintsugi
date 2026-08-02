# Hyprland

## Introduction

Hyprland is the Wayland compositor selected for Project Kintsugi.

This decision was not based solely on appearance or popularity, but on how well the project aligns with the engineering principles established during Phase 0.

Rather than treating the compositor as a configurable window manager, Project Kintsugi considers it the central component of the graphical desktop.

Choosing a compositor is therefore one of the most significant architectural decisions in the project.

---

## The Role of Hyprland

Within Project Kintsugi, Hyprland is responsible for providing the graphical session.

As a Wayland compositor, it coordinates:

* graphical output,
* application windows,
* input devices,
* monitor management,
* and communication with Wayland clients.

Other desktop features such as notifications, application launching, wallpapers, authentication, and status bars remain independent components.

This separation reinforces the modular architecture adopted by the project.

---

## Why Hyprland

Project Kintsugi evaluated Hyprland according to its guiding principles rather than individual features.

Hyprland was selected because it provides:

* A modern Wayland-first architecture.
* Active development and a growing ecosystem.
* A modular approach that integrates well with independent desktop components.
* Extensive configuration capabilities without requiring modifications to the compositor itself.
* Strong community adoption, resulting in mature documentation and supporting tools.

These characteristics make Hyprland a suitable foundation for a desktop that prioritizes understanding, maintainability, and incremental development.

---

## Trade-offs

Every architectural decision involves compromises.

Selecting Hyprland also means accepting certain trade-offs.

Compared to more conservative compositors, Hyprland evolves rapidly.

This provides access to new capabilities but also requires keeping up with changes in the surrounding ecosystem.

Likewise, Hyprland intentionally focuses on the compositor itself rather than providing a complete desktop environment.

As a result, the remaining desktop components must be selected, integrated, and maintained independently.

Project Kintsugi considers this an advantage because understanding those integrations is one of the project's primary objectives.

---

## Project Kintsugi Perspective

Hyprland is not the final goal of Project Kintsugi.

It is the architectural foundation upon which the desktop will be built.

The project deliberately separates the choice of compositor from the selection of desktop components.

Each additional component will be evaluated independently according to its own responsibilities and how well it integrates with the rest of the system.

This approach avoids unnecessary coupling and keeps the desktop understandable, modular, and maintainable.

---

## Looking Ahead

Selecting Hyprland establishes the foundation for the implementation phase of Project Kintsugi.

The next steps are no longer about choosing a compositor, but about integrating the remaining desktop components one responsibility at a time.

Each integration will follow the same engineering process established throughout the project:

* Understand the component.
* Document the decision.
* Implement incrementally.
* Verify the result.
* Record the change in version control.

This methodology ensures that the desktop grows through deliberate engineering decisions rather than accumulated configuration.
