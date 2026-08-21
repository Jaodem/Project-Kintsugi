# System Updates

## Introduction

System update management is responsible for detecting, notifying, and applying software updates within the graphical session.

Project Kintsugi treats system updates as a lightweight, non-blocking background process that integrates seamlessly with the native OS infrastructure.

The implementation is designed to keep the system current while remaining unintrusive, modular, and independent from KDE Plasma's software center.

---

## Why This Component Matters

Regular updates are required for system security and stability.

A dedicated update management component allows Project Kintsugi to:

- stay informed about available packages;
- differentiate between standard and security updates;
- avoid heavy background daemons during the Hyprland session;
- prevent network latency from freezing the user interface;
- provide clear notifications when action is required;
- manage updates without relying on KDE Discover.

---

## Responsibilities

The system updates subsystem is responsible for:

- querying the local package cache for available updates;
- counting the number of pending standard packages;
- counting the number of pending security patches;
- triggering visual notifications when updates are found;
- providing a mechanism to view update details;
- providing a mechanism to execute the update transaction.

Repository synchronization, metadata downloading, and network fetching remain separate responsibilities handled by the base operating system.

---

## Relationship with Fedora Infrastructure

Project Kintsugi is built on Fedora Linux.

Fedora provides robust, automated infrastructure for package management through DNF5 and systemd.

The update subsystem relies on this existing architecture:

```text
Fedora systemd timers
        │
        ▼
dnf-makecache.timer
        │
        ▼
Local DNF cache (Updated in background)
        │
        ▼
Project Kintsugi scripts (Offline query)
```

This ensures that the graphical session never waits for network downloads when checking for updates.

---

## Relationship with KDE Plasma

KDE Plasma provides its own graphical software center (Discover) and relies on the PackageKit daemon for background update detection.

Project Kintsugi does not depend on Discover or PackageKit for its primary update notifications.

This is intentional.

As the Project Kintsugi session minimizes KDE Plasma dependencies, update management requires a standalone, native implementation.

However, PackageKit is intentionally left unmodified on the system to ensure that the KDE Plasma fallback session remains fully operational.

---

## Firmware Management

Firmware updates involve flashing hardware components and carry a higher risk than standard software updates.

They also frequently require network synchronization that cannot be easily forced offline.

For these reasons, Project Kintsugi excludes firmware updates from its automated notification subsystem.

Firmware management remains explicitly delegated to KDE Discover within the Plasma fallback session.

---

User Interface
Update notifications are provided through Mako.

The notification subsystem evaluates the update counts and pushes a summary to the notification daemon.

The conceptual architecture is:

```text
Systemd User Timer
       │
       ▼
check-updates.sh
       │
       ▼
Mako Notification
```

This keeps the user informed without requiring persistent widgets or continuous background polling.

---

## Design Considerations

When evaluating system update solutions, Project Kintsugi considers:

- compatibility with DNF5;
- compatibility with Flatpak;
- zero network dependency for detection;
- minimal CPU footprint in the background;
- clear distinction for security patches;
- desktop-environment independence;
- reliance on standard Fedora tools.

Preference is given to simple shell scripts querying local caches over running persistent update monitors.

---

## Separation of Concerns

Update management is not:

- a repository synchronization tool;
- a network management feature;
- a persistent background daemon;
- a firmware flashing utility.

Its responsibility is limited to querying local metadata and notifying the user.

Fedora handles the background metadata synchronization, while Kintsugi simply reads the results and presents them.

---

## Project Kintsugi Perspective

Project Kintsugi considers update management a critical operational requirement that should not compromise the performance or responsiveness of the Wayland session.

The selected architecture provides:

- offline-only detection;
- automated periodic checks;
- integration with Mako notifications;
- architectural independence from KDE Discover;
- strict separation between package updates and firmware management.

The resulting design keeps the update process visible and accessible without introducing heavy background services or network blocking.

---

## Next Step

The next document evaluates the available native detection mechanisms and command-line interfaces to establish the technical foundation for the update scripts.