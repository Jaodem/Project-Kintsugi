# Project Architecture

> Complex systems become understandable when built one layer at a time.

## Overview

Project Kintsugi is designed around a layered and modular architecture.

Each layer has a single responsibility and should remain as independent as possible from the others.

This approach allows individual components to evolve without requiring major changes across the entire system.

The objective is not only to build an efficient desktop, but also to understand how every component fits into the overall architecture.

---

# Layered Architecture

| Layer | Responsibility | Examples |
|--------|----------------|----------|
| Hardware | Physical platform where the system runs | Intel CPU, Intel GPU, Laptop, Displays |
| Operating System | Provides the core operating system and hardware management | Fedora, Linux Kernel, systemd, DNF, NetworkManager, PipeWire |
| Display Protocol | Defines communication between applications and the compositor | Wayland |
| Compositor | Manages windows, workspaces, input, and rendering | Hyprland |
| Desktop Services | Provide independent desktop functionality | Waybar, SwayNC, Hyprlock, Hypridle, Walker |
| Applications | Tools used for daily work | Kitty, Brave, Zed, Dolphin, DBeaver, VLC |

---

# Design Principles

The architecture follows a small set of engineering principles.

- Every layer has a single responsibility.
- Components should remain loosely coupled whenever possible.
- Desktop functionality should be modular.
- Applications should remain independent from the desktop environment.
- Configuration should be reproducible through version control.

---

# Component Relationships

The system is organized as a stack of independent layers.

```text
User
│
Applications
│
Desktop Services
│
Hyprland
│
Wayland
│
Fedora
│
Hardware
```

Each layer depends only on the services provided by the layer below it.

This separation makes the system easier to understand, maintain, and evolve.

---

# Future Evolution

Project Kintsugi is expected to evolve continuously.

Components may be replaced whenever a better solution exists, provided the replacement aligns with the project's philosophy and architectural principles.

The architecture itself should remain stable, even if individual components change over time.
