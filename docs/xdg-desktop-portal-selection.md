# XDG Desktop Portal Backend Selection

## Objective

The purpose of this document is to select the XDG Desktop Portal backend that will become the standard implementation for Project Kintsugi.

The selected backend should integrate naturally with Hyprland while preserving the project's modular architecture and long-term maintainability.

---

## Background

Project Kintsugi already included the generic portal service together with the KDE and GTK portal backends inherited from the Plasma installation.

Although functional, this configuration lacked the Hyprland-specific backend responsible for implementing native Wayland interfaces such as Screenshot, ScreenCast, GlobalShortcuts and InputCapture.

The objective was therefore to evaluate whether the Hyprland backend should become part of the standard desktop architecture.

---

## Evaluation Criteria

The selected backend should satisfy the following requirements:

* native Hyprland support;
* compatibility with Wayland;
* active upstream maintenance;
* availability through approved package sources;
* predictable behavior;
* minimal architectural complexity;
* long-term maintainability.

---

## Available Backends

### xdg-desktop-portal-hyprland

Provides Hyprland-native implementations for:

* Screenshot
* ScreenCast
* GlobalShortcuts
* InputCapture

It is developed by the Hyprland project and integrates directly with compositor-specific Wayland protocols.

---

### xdg-desktop-portal-gtk

Provides several generic portal implementations shared across multiple desktop environments.

It complements compositor-specific backends by implementing interfaces that are not provided by Hyprland itself.

---

### xdg-desktop-portal-kde

Provides a complete KDE implementation of the portal interfaces.

Although installed as part of the Plasma environment, it is not the preferred backend for a native Hyprland session.

---

## Fedora Evaluation

Package validation confirmed that:

* `xdg-desktop-portal` was already installed;
* `xdg-desktop-portal-gtk` was already installed;
* `xdg-desktop-portal-kde` was already installed;
* `xdg-desktop-portal-hyprland` was available from the approved Hyprland COPR repository.

The package introduced only the expected runtime dependencies together with the optional weak dependency `hyprpicker`.

---

## Decision

Project Kintsugi adopts the following portal architecture:

* `xdg-desktop-portal`
* `xdg-desktop-portal-hyprland`
* `xdg-desktop-portal-gtk`

The KDE backend may remain installed while Plasma is present, but it is no longer considered part of the target Hyprland architecture.

---

## Validation

The implementation was validated by confirming:

* successful installation;
* active `xdg-desktop-portal.service`;
* active `xdg-desktop-portal-hyprland.service`;
* successful initialization of the Hyprland backend;
* successful PipeWire connection;
* successful screencopy initialization;
* successful screenshot creation using `grim`;
* successful execution of `hyprland-share-picker`.

These tests confirmed that the backend correctly integrates with the running Hyprland session.

---

## Conclusion

Project Kintsugi standardizes on the Hyprland portal backend together with the generic GTK backend.

This architecture follows upstream recommendations while preserving the modular desktop design adopted throughout the project.
