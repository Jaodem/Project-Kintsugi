# Screenshot Utility Selection

## Objective

The purpose of this document is to select the screenshot utility that will become the standard implementation for Project Kintsugi.

The selected solution should integrate naturally with Hyprland while preserving the project's modular architecture, long-term maintainability, and Wayland compatibility.

---

## Background

Project Kintsugi already established the desktop portal infrastructure together with the Hyprland-specific portal backend.

Although this infrastructure enables secure screenshot functionality under Wayland, it does not provide a user-facing screenshot application.

The objective of this evaluation is therefore to select a screenshot utility that offers a complete and predictable user workflow while integrating cleanly with the existing desktop architecture.

---

## Evaluation Criteria

The selected implementation should satisfy the following requirements:

* native Wayland support;
* compatibility with Hyprland;
* support for region selection;
* support for full-screen capture;
* clipboard integration;
* straightforward keyboard shortcut integration;
* active upstream maintenance;
* availability through approved package sources;
* minimal architectural complexity;
* long-term maintainability.

Preference is given to solutions that reuse existing Wayland utilities rather than introducing unnecessary desktop-specific dependencies.

---

## Candidate Solutions

### grim

`grim` is a lightweight screenshot utility designed for wlroots-based compositors.

It provides the core screenshot functionality but requires additional tools to implement region selection and clipboard integration.

---

### grim + slurp

Using `grim` together with `slurp` provides support for interactive region selection.

This combination has become the de facto standard for Wayland compositors based on wlroots and serves as the foundation for several higher-level screenshot utilities.

---

### grimblast

`grimblast` is a helper utility developed for the Hyprland ecosystem.

Rather than replacing existing tools, it orchestrates `grim`, `slurp`, and clipboard utilities into a simplified command-line interface suitable for keyboard shortcut integration.

It supports:

* region selection;
* full-screen capture;
* active output capture;
* clipboard operations;
* file saving;
* desktop notifications.

---

### Spectacle

Spectacle is KDE's screenshot application.

Although fully functional under Wayland, it introduces additional dependencies on the KDE desktop ecosystem and is not specifically designed for Hyprland.

---

## Fedora Evaluation

Package validation confirmed that:

* `grim` was available from the Fedora repositories;
* `slurp` was available from the Fedora repositories;
* `grimblast` was available from the approved Hyprland COPR repository;
* `Spectacle` was available from the Fedora repositories.

The selected solution therefore remained fully compatible with Project Kintsugi's package source policy.

---

## Decision

Project Kintsugi adopts the following screenshot architecture:

* `grimblast`
* `grim`
* `slurp`

This architecture preserves the modular design of the desktop while providing a simplified interface for screenshot operations.

`grimblast` acts as a lightweight orchestration layer, delegating screenshot capture to `grim` and region selection to `slurp`.

---

## Validation

The selected implementation was validated through:

* successful package installation;
* dependency verification using `grimblast check`;
* successful region capture;
* successful full-screen capture;
* successful clipboard integration;
* successful file saving;
* successful desktop notifications through Mako;
* successful keyboard shortcut integration within Hyprland.

The validation confirmed that the selected solution satisfies the functional requirements established during evaluation.

---

## Conclusion

Project Kintsugi standardizes on `grimblast` as the user-facing screenshot utility, supported by `grim` and `slurp` as the underlying capture infrastructure.

This architecture provides a lightweight, reliable, and well-integrated screenshot workflow while remaining consistent with the project's modular desktop design.