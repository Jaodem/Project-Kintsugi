# Screen Locker Selection

## Objective

The purpose of this document is to select the screen locker that will become the standard implementation for Project Kintsugi.

The selection follows the project's engineering methodology, emphasizing modularity, maintainability, and long-term compatibility with Hyprland.

---

## Background

Project Kintsugi has already established the core desktop infrastructure, including graphical authentication, session management, and desktop portals.

The next step is introducing automatic session locking to improve workstation security while maintaining a modular architecture.

---

## Evaluation Criteria

The selected implementation should provide:

* native Wayland support;
* compatibility with Hyprland;
* PAM authentication;
* active upstream maintenance;
* predictable behavior;
* minimal unnecessary dependencies;
* availability through the project's approved package sources;
* long-term maintainability.

The objective is selecting a reliable infrastructure component rather than maximizing visual customization.

---

## Candidate Screen Lockers

### Hyprlock

Hyprlock is the official screen locker developed for the Hyprland ecosystem.

It integrates directly with Hyprland, supports GPU-accelerated rendering, and follows the compositor's design philosophy.

---

### swaylock

Swaylock is a mature Wayland screen locker originally developed for the Sway compositor.

Although compositor-independent, it focuses on broad Wayland compatibility rather than Hyprland-specific integration.

---

### gtklock

gtklock provides a GTK-based screen locker capable of operating across multiple Wayland compositors.

Its flexibility comes at the cost of additional dependencies and a broader software stack.

---

## Fedora Evaluation

Project Kintsugi validates:

* package availability;
* package source;
* upstream maintenance;
* installation complexity;
* compatibility with Fedora 44.

Preference is given to solutions available through the project's approved package repositories.

---

## Decision

Hyprlock was selected as the standard screen locker for Project Kintsugi.

The decision is based on:

* native Hyprland integration;
* active upstream development;
* excellent Wayland compatibility;
* PAM authentication support;
* minimal dependency footprint;
* straightforward integration with Hypridle.

---

## Future Review

The decision may be revisited if:

* Hyprland architecture changes significantly;
* Fedora packaging changes;
* upstream maintenance changes;
* another implementation provides a substantially better engineering balance.

Until then, Hyprlock remains the project's standard screen locking solution.

---

## Conclusion

Selecting Hyprlock provides a secure, lightweight, and well-integrated solution that aligns closely with Project Kintsugi's modular desktop architecture.