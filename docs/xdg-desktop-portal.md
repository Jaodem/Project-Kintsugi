# XDG Desktop Portal

## Introduction

XDG Desktop Portal provides a standardized D-Bus interface that allows desktop applications to interact with the graphical environment in a secure and desktop-independent manner.

Rather than accessing compositor-specific functionality directly, applications communicate with the portal service, which delegates each request to an appropriate desktop backend.

This architecture allows applications to remain portable across different desktop environments while preserving security boundaries imposed by modern Wayland compositors.

---

## Why This Component Matters

Modern desktop applications increasingly rely on XDG Desktop Portal to perform operations that require interaction with the graphical session.

Typical examples include:

* selecting files;
* taking screenshots;
* screen sharing;
* remote desktop access;
* opening URIs;
* desktop settings integration;
* notifications;
* global shortcuts.

Without an appropriate portal backend, many applications continue to run but lose functionality or exhibit degraded integration with the desktop environment.

---

## Architecture

The XDG Desktop Portal infrastructure consists of two independent layers.

The first layer is the generic portal service:

* `xdg-desktop-portal`

This service exposes the standard D-Bus interfaces consumed by desktop applications.

The second layer consists of one or more backend implementations that provide compositor- or desktop-specific functionality.

Multiple backends may coexist simultaneously, with each one implementing only the interfaces appropriate for its environment.

---

## Backend Selection

Backend selection is performed automatically according to the current desktop session.

Each backend advertises the interfaces it implements through its corresponding `.portal` definition.

For a Hyprland session, the preferred backend is:

* `xdg-desktop-portal-hyprland`

while remaining interfaces continue to be provided by generic implementations such as:

* `xdg-desktop-portal-gtk`.

This modular design allows different backends to complement one another without conflict.

---

## Relationship with Hyprland

Hyprland itself does not implement the XDG Desktop Portal interfaces.

Instead, the compositor exposes Wayland protocols that are consumed by `xdg-desktop-portal-hyprland`, which in turn provides standardized portal interfaces to applications.

This separation preserves Hyprland's modular architecture while maintaining compatibility with modern desktop software.

---

## Separation of Responsibilities

The portal infrastructure is responsible only for providing standardized desktop interfaces.

It is not responsible for:

* window management;
* authentication;
* credential storage;
* application permissions;
* package management.

Each responsibility remains delegated to its corresponding system component.

---

## Project Kintsugi Perspective

Project Kintsugi considers XDG Desktop Portal a core infrastructure component rather than an optional desktop feature.

Although some applications can operate without a compositor-specific backend, complete Wayland integration requires an implementation capable of exposing native screenshot, screencast, input capture, and global shortcut functionality.

For this reason, the portal infrastructure is evaluated independently as part of the desktop architecture.

---

## Next Step

The next document evaluates the available portal backends and records the implementation selected for Project Kintsugi.
