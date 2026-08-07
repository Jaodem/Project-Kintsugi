# Power Management Selection

## Objective

The purpose of this document is to select the power management infrastructure for Project Kintsugi.

The selected implementation should integrate naturally with Fedora, remain compatible with Hyprland, and preserve the project's modular architecture.

---

## Background

Power management is composed of multiple operating system services rather than a single application.

The evaluation focused on identifying which components are responsible for:

- hardware power events;
- battery information;
- system power profiles;
- integration with the graphical desktop.

---

## Evaluation Criteria

The selected infrastructure should provide:

- compatibility with Fedora KDE Plasma;
- integration with systemd;
- compatibility with Wayland;
- compatibility with Hyprland;
- modular architecture;
- active upstream maintenance;
- long-term maintainability;
- availability in official Fedora repositories.

---

## Evaluated Components

### systemd-logind

Responsible for:

- session management;
- suspend and resume;
- power button events;
- lid switch handling.

Validation confirmed correct operation.

---

### UPower

Provides:

- battery information;
- AC power state;
- standardized D-Bus interfaces for desktop applications.

Validation confirmed that UPower is active and integrated with the system.

---

### Tuned

Fedora KDE Plasma provides Tuned as the system power profile manager.

Validation confirmed:

- active system service;
- integration with systemd;
- availability of multiple power profiles.

---

### power-profiles-daemon

The package is available in the Fedora repositories but was not installed in the validated system.

No architectural requirement was identified to replace the existing Tuned-based infrastructure.

---

## Decision

Project Kintsugi adopts the Fedora-provided power management infrastructure composed of:

```text
systemd-logind
        │
        ├── hardware power events
        ├── suspend / resume
        │
UPower
        │
        ├── battery information
        │
Tuned
        │
        ├── system power profiles
```

Idle management remains implemented independently through hypridle.

---

## Trade-offs

Maintaining the existing Fedora infrastructure avoids introducing unnecessary components while preserving compatibility with future system updates.

Alternative implementations remain technically viable but do not currently provide sufficient architectural benefits to justify replacing the validated infrastructure.

---

## Validation

The selected architecture was validated through:

- active systemd-logind service;
- active UPower service;
- active Tuned service;
- successful D-Bus integration;
- available Tuned profiles;
- successful integration with the Hyprland desktop session.

---

## Tuned Profile Selection

The validated Fedora installation initially used the `throughput-performance`
profile.

Although functional, this profile is primarily intended for server-oriented
workloads.

Practical validation on notebook hardware demonstrated that the `desktop`
profile provides a more appropriate balance between responsiveness and energy
efficiency while preserving normal desktop performance.

Project Kintsugi therefore standardizes on the `desktop` Tuned profile.

---

## Conclusion

Project Kintsugi standardizes on the native Fedora KDE Plasma power management infrastructure based on systemd-logind, UPower, and Tuned.

This approach satisfies the project's architectural goals while preserving modularity and long-term maintainability.