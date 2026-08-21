# System Updates Implementation

## Objective

The objective of this implementation was to establish an automated, non-blocking system update notification mechanism for the Project Kintsugi Wayland session.

The implementation detects available system packages, security patches, and Flatpak updates without requiring network access during execution.

The solution operates independently of KDE Plasma's PackageKit backend and avoids introducing persistent background daemons.

---

## Background

Project Kintsugi requires a lightweight method to notify the user of pending updates.

Previous investigation (Phase 5.1) confirmed that Fedora's native `dnf-makecache.timer` handles background repository synchronization effectively.

The implementation therefore focuses exclusively on querying the local DNF5 and Flatpak caches and passing the results to the Mako notification daemon.

Firmware updates are explicitly excluded from this implementation and remain delegated to KDE Discover.

---

## Scope

This implementation included:

- creation of the update detection bash script;
- integration with DNF5 local cache;
- integration with Flatpak remote-ls;
- separation of security and standard packages;
- integration with Mako via `notify-send`;
- creation of a systemd user service;
- creation of a systemd user timer;
- validation of the script and notification rendering;
- validation of the systemd timer scheduling.

The implementation did not include:

- a graphical user interface for update management;
- automatic installation of updates;
- firmware (fwupd) integration;
- modifications to PackageKit.

---

## Update Detection Script

The detection logic was implemented in a dedicated bash script located at:

```text
~/.config/hypr/scripts/check-updates.sh
```

The script performs the following operations:

1. Queries the local DNF5 cache for security updates.
2. Queries the local DNF5 cache for all standard updates.
3. Queries Flatpak for pending application updates.
4. Calculates the total number of updates.
5. Constructs a formatted notification message.
6. Triggers `notify-send` if updates are available.

The DNF5 queries use the `-C` (cache-only) and `--quiet` flags to ensure rapid, offline execution. Text parsing is handled through strict architecture extensions to avoid DNF5 header interference.

---

## Notification Integration

The script sends the formatted summary to the Mako notification daemon.

Notification urgency is handled dynamically:

- If security patches are detected, the notification urgency is set to `critical`.
- If only standard or Flatpak updates are detected, the urgency is set to `normal`.

This ensures that critical security updates are visually highlighted by the notification daemon.

---

## Systemd Automation

Execution is automated through systemd `--user`, ensuring the script runs in the background without tying up a terminal or the Hyprland configuration.

### Service Definition

A systemd oneshot service was created at:

```text
~/.config/systemd/user/kintsugi-updates.service
```

The service is responsible for executing the bash script.

### Timer Definition

A systemd timer was created at:

```text
~/.config/systemd/user/kintsugi-updates.timer
```

The timer schedules the execution of the service:

- 10 minutes after the graphical session starts (OnBootSec=10min).
- Every 24 hours while the session remains active (OnUnitActiveSec=24h).

This scheduling avoids placing unnecessary load on the system during the initial Hyprland boot sequence.

---

## Validation

The implementation was validated incrementally in the live environment.

### Script Execution

The script was executed manually from the terminal.

The resulting notification successfully displayed:

- The correct total count of cached updates.
- The correct categorization of security patches versus standard packages.
- The critical urgency border applied by Mako due to the presence of security patches.

### Systemd Integration

The systemd components were validated by reloading the user daemon and enabling the timer.

The scheduling was confirmed using:

```text
systemctl --user list-timers --all
```

The output verified that the `kintsugi-updates.timer` was active, linked correctly within the `timers.target.wants` directory, and successfully completed its initial execution.

---

## Conclusion
The system updates notification mechanism has been successfully implemented as an independent Project Kintsugi component.

A shell script handles the local cache querying, while systemd manages the execution scheduling.

The resulting system provides accurate, offline-capable update notifications without introducing unnecessary dependencies on KDE Plasma or blocking the Wayland session.

The component is therefore considered complete for the detection and notification phase.