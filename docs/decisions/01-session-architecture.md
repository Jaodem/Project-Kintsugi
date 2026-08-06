# Decision 01: Session Management Architecture

## Status

Accepted

---

## Date

2026-08-06

---

## Context

Project Kintsugi aims to build a modular and maintainable Hyprland desktop environment using an engineering-driven methodology.

A reliable graphical session architecture is required to coordinate the lifecycle of the Wayland compositor, integrate desktop services, and expose the graphical session to systemd user units.

Several session startup methods are available for Hyprland, each providing different levels of integration with the operating system.

The selected solution must satisfy the project's architectural principles while remaining compatible with Fedora and long-term maintenance goals.

---

## Decision

Project Kintsugi standardizes on the following session startup architecture:

```text
SDDM
 │
 ▼
UWSM
 │
 ▼
start-hyprland
 │
 ▼
Hyprland
 │
 ▼
systemd --user
 │
 ▼
graphical-session.target
```

The graphical session is started by UWSM while delegating compositor initialization to the official `start-hyprland` launcher provided by the Hyprland project.

---

## Rationale

Although current Hyprland documentation recommends launching the compositor directly through `start-hyprland` for most installations, Project Kintsugi places systemd integration at the center of its desktop architecture.

Executing `start-hyprland` through UWSM provides:

* complete integration with systemd user services;
* predictable session lifecycle management;
* proper activation of graphical session targets;
* compatibility with Hyprland's official startup mechanism;
* reliable environment propagation;
* improved service orchestration.

This approach satisfies both the project's architectural goals and Hyprland's runtime expectations.

---

## Consequences

The selected architecture provides:

* full systemd-managed graphical sessions;
* consistent startup and shutdown behavior;
* reliable activation of user services;
* compatibility with graphical desktop infrastructure;
* a modular foundation for future desktop components.

The solution introduces additional session-management infrastructure compared with launching Hyprland directly, but the added complexity is considered acceptable given the benefits obtained.

---

## Validation

The decision was validated through successful confirmation of:

* SDDM session startup;
* UWSM session initialization;
* execution of `start-hyprland`;
* active `graphical-session.target`;
* active Wayland session targets;
* successful execution of user services;
* Polkit integration;
* Secret Service integration;
* desktop portal functionality;
* absence of Hyprland startup warnings.

---

## Alternatives Considered

The following alternatives were evaluated:

* launching Hyprland directly;
* launching `start-hyprland` without UWSM;
* launching Hyprland through UWSM without the official launcher.

These alternatives were rejected because they either reduced systemd integration or failed to satisfy Hyprland's expected startup path.

---

## Related Documentation

* `docs/session-management.md`
* `docs/session-management-selection.md`
* `docs/implementation/13-session-management.md`