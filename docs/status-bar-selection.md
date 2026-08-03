# Status Bar Selection

## Objective

The purpose of this document is to select the status bar that will become the standard status bar for Project Kintsugi.

Rather than selecting a solution based on popularity or visual appearance, the decision follows the project's engineering principles and long-term desktop architecture.

The selected status bar should integrate naturally with Hyprland while remaining maintainable, modular, and available through the project's approved package sources.

---

## Background

Project Kintsugi has successfully introduced the core desktop components required for a functional graphical session, including the compositor, terminal emulator, application launcher, and file manager.

The next step is to provide a persistent interface that presents relevant system and session information without assuming responsibilities that belong to other desktop services.

A status bar fulfills this role by acting as the presentation layer for information produced by the operating system and the desktop session.

---

## Evaluation Criteria

The selected status bar should satisfy the following requirements:

* Native Wayland support.
* Direct integration with Hyprland.
* Modular architecture.
* Active upstream maintenance.
* High-quality documentation.
* Predictable configuration.
* Availability through the project's approved package sources.
* Long-term maintainability.
* Reasonable dependency footprint.

The objective is not to maximize customization, but to select a component that supports a stable and maintainable desktop architecture.

---

## Candidate Status Bars

### Waybar

Waybar is one of the most widely adopted status bars for Wayland compositors.

It provides native Wayland support, direct Hyprland integration, a modular architecture, and extensive configuration capabilities.

Waybar communicates with Hyprland through its IPC interface and supports a large collection of built-in modules for displaying desktop and system information.

---

### AGS (Aylur's GTK Shell)

AGS is a JavaScript-based desktop shell framework capable of building highly customizable desktop components, including status bars.

Rather than providing only a status bar, AGS functions as a general framework for constructing complete desktop interfaces.

This flexibility comes at the cost of additional complexity and a larger runtime environment.

---

### Ironbar

Ironbar is a modern Wayland-native status bar implemented in Rust.

It emphasizes performance, modularity, and clean architecture while supporting multiple Wayland compositors.

Although actively maintained, its ecosystem and documentation are currently less mature than those of Waybar.

---

### nwg-panel

nwg-panel is designed primarily for wlroots-based compositors.

It combines a traditional desktop panel with status indicators, launchers, and various desktop utilities.

Its broader scope makes it closer to a lightweight desktop shell than to a dedicated status bar.

---

## Fedora Evaluation

Project Kintsugi will verify:

* package availability;
* package source;
* maintenance status;
* installation complexity;
* compatibility with Fedora 44.

Preference will be given to solutions available through the project's approved package sources.

---

## Decision

Project Kintsugi selects Waybar as the standard status bar.

The decision is based on the project's engineering principles rather than popularity.

Waybar satisfies all mandatory evaluation criteria while providing a mature implementation, direct Hyprland integration, active upstream maintenance, and broad adoption within the Wayland ecosystem.

Its architecture aligns well with Project Kintsugi's preference for selecting components with clearly defined responsibilities.

---

## Rationale

Waybar was selected because it provides an appropriate balance between functionality, maintainability, modularity, and ecosystem maturity.

The decision is supported by the following observations:

* available from the official Fedora repositories;
* native Wayland implementation;
* direct Hyprland IPC integration;
* modular architecture;
* active upstream development;
* comprehensive documentation;
* predictable configuration model;
* long-term maintainability.

Although other candidates provide valuable capabilities, none offered a stronger overall architectural fit for the objectives of Project Kintsugi.

---

## Trade-offs

Every status bar represents a balance between:

* flexibility;
* simplicity;
* dependency footprint;
* configuration complexity;
* ecosystem maturity;
* long-term maintenance.

Project Kintsugi documents these trade-offs explicitly rather than assuming any implementation is objectively superior.

Waybar introduces a moderate level of configuration complexity, but this complexity is justified by its modular design and broad compatibility with modern Wayland desktops.

---

## Future Review

The status bar selection may be revisited if:

* Fedora packaging changes significantly;
* upstream maintenance changes;
* another implementation provides a substantially better engineering balance;
* or the project's desktop architecture evolves in a way that changes the original requirements.

Until then, Waybar will remain the standard status bar for Project Kintsugi.

---

## Validation on Fedora 44

The candidate status bars were evaluated against the package sources available on Fedora 44.

### Waybar

Waybar is available from the official Fedora repositories.

It integrates directly with Hyprland through the compositor's IPC interface and is actively maintained.

---

### AGS

AGS is available through community package sources rather than the official Fedora repositories.

Although it provides exceptional flexibility, introducing an additional package source is not justified for the current stage of the project.

---

### Ironbar

Ironbar is not currently available through the official Fedora repositories.

Its exclusion is based on package availability rather than technical capability.

---

### nwg-panel

nwg-panel is available for Fedora and remains a valid alternative for wlroots-based compositors.

However, its broader desktop-oriented scope exceeds the responsibilities assigned to the status bar within Project Kintsugi.

---

## Conclusion

A status bar is the primary presentation layer of a modern desktop session.

After evaluating the available alternatives, Project Kintsugi adopts Waybar because it provides the most appropriate balance between modularity, maintainability, native Wayland support, and integration with Hyprland while remaining available through the project's approved package sources.
