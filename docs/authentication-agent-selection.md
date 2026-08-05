# Authentication Agent Selection

## Objective

The purpose of this document is to select the authentication agent that will become the standard graphical authentication component for Project Kintsugi.

Rather than selecting an implementation based on desktop environment or popularity, the decision follows the project's engineering principles and long-term desktop architecture.

The selected authentication agent should integrate naturally with Polkit while remaining lightweight, maintainable, and available through the project's approved package sources.

---

## Background

Project Kintsugi has successfully established the fundamental components required for a functional graphical desktop, including the compositor, terminal emulator, application launcher, file manager, status bar, and notification daemon.

The next step is to introduce a graphical authentication mechanism capable of handling privileged operations requested by applications and system services.

The authentication agent should integrate cleanly with the existing desktop architecture while remaining independent from the compositor itself.

---

## Evaluation Criteria

The selected authentication agent should satisfy the following requirements:

* Compatibility with Polkit.
* Compatibility with Wayland sessions.
* Active upstream maintenance.
* High-quality documentation.
* Predictable behavior.
* Availability through the project's approved package sources.
* Minimal unnecessary dependencies.
* Long-term maintainability.
* Clear separation of responsibilities.

The objective is not to maximize features, but to select a reliable infrastructure component that integrates naturally into the desktop environment.

---

## Candidate Authentication Agents

### HyprpolkitAgent

HyprpolkitAgent is a lightweight authentication agent developed specifically for Hyprland.

It is designed to integrate naturally with Wayland sessions while providing a minimal graphical interface for Polkit authentication requests.

Its narrow scope closely aligns with the modular philosophy adopted by Project Kintsugi.

---

### polkit-gnome

polkit-gnome is one of the most widely deployed authentication agents in the Linux ecosystem.

Although originally developed for GNOME, it is desktop-independent and is commonly used by lightweight window managers and compositors.

Its maturity and broad compatibility make it a reliable alternative.

---

### lxqt-policykit

LXQt PolicyKit Agent provides authentication dialogs for the LXQt desktop environment.

Although intended for LXQt, it can operate independently in other desktop environments while maintaining a relatively small dependency footprint.

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

The final selection will be made after validating package availability and integration characteristics on Fedora 44.

The selected authentication agent must satisfy the project's engineering principles while preserving the modular desktop architecture established throughout Phase 1.

---

## Trade-offs

Every authentication agent represents a balance between:

* desktop integration;
* dependency footprint;
* maintainability;
* ecosystem maturity;
* Wayland compatibility;
* long-term support.

Project Kintsugi documents these trade-offs explicitly rather than assuming any implementation is objectively superior.

---

## Future Review

The authentication agent selection may be revisited if:

* Fedora packaging changes significantly;
* upstream maintenance changes;
* another implementation provides a substantially better engineering balance;
* or the project's desktop architecture evolves in a way that changes the original requirements.

Until then, the selected authentication agent will remain the standard implementation for Project Kintsugi.

---

## Validation on Fedora 44

The candidate authentication agents will be evaluated against the package sources available on Fedora 44.

Package availability, maintenance status, and integration characteristics will be documented before the final decision is made.

---

## Conclusion

Graphical authentication is a fundamental infrastructure service within a modern desktop environment.

Selecting an authentication agent carefully ensures that privileged graphical operations can be performed consistently while preserving the modular architecture and long-term maintainability of Project Kintsugi.
