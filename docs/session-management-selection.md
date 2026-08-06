# Session Management Selection

## Objective

The purpose of this document is to select the session management architecture for Project Kintsugi.

The selected implementation should provide reliable integration between Hyprland, systemd, and the graphical user session while preserving the project's modular design and long-term maintainability.

---

## Background

Hyprland provides a Wayland compositor but intentionally avoids implementing a complete desktop session manager.

Project Kintsugi therefore evaluates session management independently from the compositor in order to establish a reproducible and maintainable graphical session.

The selected solution must integrate naturally with Fedora while supporting user services managed through systemd.

---

## Evaluation Criteria

The selected implementation should provide:

* compatibility with Fedora;
* compatibility with Hyprland;
* integration with systemd user services;
* predictable session lifecycle;
* environment propagation;
* compatibility with graphical desktop services;
* active upstream maintenance;
* long-term maintainability.

---

## Candidate Approaches

### Hyprland Direct Launch

Launching the compositor directly provides the simplest execution path.

Advantages:

* minimal startup path;
* official upstream support.

Limitations:

* limited session lifecycle management;
* reduced integration with systemd-managed user services.

---

### start-hyprland

`start-hyprland` is the official launcher provided by the Hyprland project.

It prepares the runtime environment before executing the compositor and provides the recommended startup path for standard installations.

Advantages:

* official upstream launcher;
* runtime environment preparation;
* watchdog integration;
* compatibility with Hyprland runtime expectations.

Limitations:

* does not provide the session management capabilities required by Project Kintsugi.

---

### Universal Wayland Session Manager (UWSM)

UWSM provides session orchestration for Wayland compositors through systemd user services.

Advantages:

* native systemd integration;
* user service lifecycle management;
* environment propagation;
* consistent startup and shutdown behavior.

Limitations:

* additional architectural complexity;
* intended for users requiring advanced session integration.

---

### UWSM with start-hyprland

This approach combines UWSM session orchestration with the official Hyprland launcher.

The resulting architecture preserves systemd session management while satisfying Hyprland's runtime expectations.

---

## Upstream Recommendation

Current Hyprland documentation recommends launching the compositor through `start-hyprland` for most installations.

UWSM remains supported but is described as an advanced solution intended for users requiring systemd-managed graphical sessions.

Project Kintsugi intentionally prioritizes systemd integration as a primary architectural requirement.

---

## Fedora Evaluation

Validation confirmed that Fedora provides complete compatibility between:

* systemd user services;
* UWSM;
* Hyprland;
* graphical-session.target;
* user service activation.

The session was validated using the official `start-hyprland` launcher executed through UWSM.

---

## Decision

Project Kintsugi adopts:

```text
UWSM
        │
        ▼
start-hyprland
        │
        ▼
Hyprland
```

as the standard graphical session architecture.

This approach combines the official Hyprland startup sequence with full systemd session management.

---

## Trade-offs

Compared with launching Hyprland directly, the selected solution introduces additional session-management infrastructure.

However, the additional complexity provides:

* complete systemd integration;
* reliable user service lifecycle management;
* improved environment propagation;
* compatibility with systemd-managed desktop components;
* predictable startup behavior.

These characteristics align with Project Kintsugi's architectural goals.

---

## Validation

The selected architecture was validated through:

* successful startup from SDDM;
* successful execution of `start-hyprland`;
* successful UWSM session creation;
* active `graphical-session.target`;
* active Wayland session targets;
* successful user service integration;
* successful Polkit operation;
* successful Secret Service integration;
* successful desktop portal integration;
* absence of Hyprland startup warnings.

---

## Conclusion

Project Kintsugi standardizes on UWSM executing the official `start-hyprland` launcher.

The selected architecture provides reliable integration between Hyprland and systemd while preserving the project's modular infrastructure and long-term maintainability.