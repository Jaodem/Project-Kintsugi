# Mako Configuration

## Objective

The objective of this configuration is to define and document the notification system used by Project Kintsugi.

Mako is the selected notification daemon, providing a lightweight, Wayland-native interface for desktop notifications. This document describes its configuration, behavior, and integration with the Hyprland session.

---

## Background

Previous implementations established the notification infrastructure during Phase 1, installing Mako as the notification daemon for the Wayland session. The initial configuration was minimal, providing basic notification delivery without specific tuning for daily use.

During Phase 4.8, Mako was reviewed and validated as a workflow component. Its urgency behavior was confirmed, and its visual presentation was aligned with the Project Kintsugi theme.

---

## Scope

This configuration includes:

* Mako as the notification daemon;
* user-level systemd service management;
* urgency-based timeout behavior;
* Project Kintsugi visual styling for notifications;
* notification delivery validation;
* integration with `org.freedesktop.Notifications` over D-Bus.

This configuration does not include:

* generation of notifications (that is the responsibility of applications and services);
* system update notifications (these are handled by separate components);
* notification history or centralized notification center.

---

## Service Management

Mako runs as a user-level systemd service:

```text
mako.service
```

The service is automatically started with the user session and remains active throughout the Hyprland session.

Current service status:

```text
Active: active (running)
```

Mako provides the standard notification interface:

```text
org.freedesktop.Notifications
```

This ensures compatibility with all applications that follow the FreeDesktop notification specification.

---

## Urgency and Timeout Behavior

Mako distinguishes between three urgency levels, each with a specific timeout behavior validated through direct testing:

| Urgency | Timeout | Behavior |
|---------|---------|----------|
| **Low** | ~3 seconds | Disappears quickly; suitable for non-urgent informational messages. |
| **Normal** | ~5 seconds | Moderate duration; suitable for standard notifications. |
| **Critical** | Persistent | Remains visible until dismissed by the user; suitable for important events. |

These behaviors were validated using:

```bash
notify-send -u low "Test" "Low urgency message"
notify-send -u normal "Test" "Normal urgency message"
notify-send -u critical "Test" "Critical urgency message"
```

The current configuration implements this behavior while preserving the project's existing notification policy.

---

## Visual Theme

Mako's visual presentation is integrated with the Project Kintsugi visual theme.

The configuration reuses the existing project palette rather than introducing notification-specific colors:

| Purpose | Color |
|---------|-------|
| **Background** | `#1A1A1A` |
| **Primary text** | `#F0F0F0` |
| **Primary accent** | `#780606` |
| **Critical accent** | `#DA4453` |

The notification border uses the same `2px` size and `10px` rounding established for Hyprland window presentation.

The notification font is:

```text
JetBrainsMono Nerd Font 10
```

This is consistent with the primary desktop interface, including Waybar.

Normal notifications use the project's primary accent (`#780606`). Critical notifications use the project's negative semantic color (`#DA4453`). Low-priority notifications retain the same visual identity and differ primarily through their shorter timeout.

The resulting configuration provides visual consistency with the rest of the desktop without introducing a separate notification theme or additional theming framework.

---

## Critical Battery and Power Management

The system uses the native infrastructure provided by UPower and systemd-logind for critical battery handling.

Current UPower configuration:

```text

PercentageCritical=5.0
PercentageAction=2.0
CriticalPowerAction=Auto
```

UPower version:

```text
1.91.3
```

The `CriticalPowerAction=Auto` behavior relies on systemd-logind to determine the appropriate power action (suspend, hibernate, etc.). systemd-logind provides the necessary capabilities:

* Suspend
* Hibernate
* HybridSleep
* SuspendThenHibernate

No custom scripts or notification-based power actions were introduced. The system relies on the native infrastructure to handle critical battery events, ensuring that the system suspends before battery exhaustion occurs.

---

## Important Distinction: Notification Generation vs. Presentation

Mako is responsible for presenting notifications, not for generating them.

The notification flow is:

```text
Application / Service
        │
        │ generates notification
        ▼
org.freedesktop.Notifications
        │
        ▼
       Mako
        │
        ▼
Notification visible
```

### System Update Notifications

During the review, it was noted that KDE Discover's DiscoverNotifier does not start in a Hyprland session. This is expected behavior, as DiscoverNotifier is conditionally executed only within KDE Plasma sessions.

```text
ExecCondition=/usr/lib/systemd/systemd-xdg-autostart-condition "KDE" ""
```

In Hyprland, the service is correctly skipped:

```text
Condition check resulted in app-org.kde.discover.notifier@autostart.service being skipped.
```

This means that update notifications are not generated in the current Hyprland session. This is not a limitation of Mako, but rather a decision about which components are active in the environment.

Whether to enable update notifications in Hyprland is a separate architectural question that may be evaluated in a future phase. The current implementation deliberately does not force KDE components to run outside their intended session environment.

---

## Validation

The configuration was validated through:

- verifying that Mako is active and running as a user service;
- confirming that `org.freedesktop.Notifications` is available over D-Bus;
- sending test notifications with low, normal, and critical urgency;
- confirming that each urgency level exhibits the expected timeout behavior;
- validating the Project Kintsugi visual appearance;
- confirming that normal notifications use the primary project accent;
- confirming that critical notifications use the negative semantic color;
- reviewing the critical battery configuration and confirming that it relies on native system infrastructure.

The final configuration was validated through direct interactive use within the Hyprland session.

---

## Results

The resulting notification system provides:

* a lightweight, Wayland-native notification daemon;
* user-level systemd service management;
* appropriate urgency-based timeout behavior;
* Project Kintsugi visual integration;
* consistent typography and color usage across the desktop;
* compatibility with all FreeDesktop notification-aware applications;
* critical battery handling delegated to native system infrastructure;
* clear separation between notification generation and presentation.

---

## Known Limitations

Mako does not provide a notification history or centralized notification center. Notifications disappear after their timeout period and are not persisted.

System update notifications are not currently generated in the Hyprland session. This is a result of KDE Discover's components not being started outside KDE Plasma, not a limitation of Mako.

These areas may be addressed in future phases if a concrete need emerges.

---

## Reproducibility

The current notification configuration can be reproduced through:

```text
~/.config/mako/config
```

The service is managed through systemd and starts automatically with the user session. No additional configuration is required for basic notification functionality.

---

## Conclusion

Mako is successfully integrated as the notification daemon for Project Kintsugi.

The system provides predictable behavior for low, normal, and critical urgency notifications, with appropriate timeout handling and a visual presentation consistent with the project's established theme.

The notification appearance reuses the Project Kintsugi palette, typography, border size, and rounding rather than introducing a separate visual system.

Critical battery events are delegated to UPower and systemd-logind, avoiding the need for custom notification-based power management scripts.

The distinction between notification generation and presentation is clearly understood and maintained, with notification generation left to applications and services while Mako handles presentation.

The notification system is now validated both functionally and visually, while continuing to follow the project's philosophy of using existing system infrastructure and avoiding unnecessary complexity.