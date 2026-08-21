# System Updates Selection

## Objective

The purpose of this document is to select the update detection mechanism for Project Kintsugi.

The selected implementation should provide reliable update counts while remaining offline, non-blocking, and independent from KDE Plasma's PackageKit backend.

---

## Background

Project Kintsugi requires a way to detect pending package updates and security patches.

The system uses Fedora's default package managers:

- DNF5 for system packages;
- Flatpak for containerized applications.

The update solution must support these formats without introducing network-induced freezes during the Hyprland session.

The selected solution should remain lightweight and avoid introducing heavy persistent daemons.

---

## Evaluation Criteria

The selected implementation should provide:

- compatibility with DNF5;
- compatibility with Flatpak;
- ability to differentiate security updates;
- strictly offline execution;
- execution from shell scripts;
- minimal background resource usage;
- independence from KDE Plasma;
- accurate numerical parsing for notifications.

---

## Existing Infrastructure

Project Kintsugi operates on a Fedora base system utilizing systemd.

The base system already provides:

- `dnf-makecache.timer` and `dnf-makecache.service`;
- a local DNF5 repository metadata cache;
- `packagekit.service` (used by KDE Discover);
- `fwupdmgr` for firmware management.

The update implementation must integrate with this infrastructure without disrupting the KDE Plasma fallback session.

---

## Candidate Approaches

### PackageKit Daemon

PackageKit provides the backend for KDE Discover.

Advantages:

- already present on the system;
- unifies different package managers.

Limitations:

- activates on demand via D-Bus;
- auto-terminates after inactivity;
- introduces unnecessary complexity for simple text-based parsing.

Project Kintsugi therefore leaves PackageKit untouched to preserve Plasma functionality, but does not use it for Hyprland update notifications.

---

### Firmware Management (fwupd)

Firmware updates were evaluated for inclusion in the Kintsugi update notifications.

The command `fwupdmgr get-updates` was tested.

Limitations:

- does not support an `--offline` flag;
- forces network synchronization if the cache has expired;
- violates the zero-network-latency requirement.

Project Kintsugi therefore excludes firmware from the custom update scripts. Firmware management is delegated exclusively to KDE Discover in the fallback session.

---

### Native CLI (Offline Mode)

DNF5 and Flatpak provide command-line interfaces that can query local caches.

Advantages:

- supports offline-only execution (`-C` / `--updates`);
- relies on the existing `dnf-makecache.timer` for network fetches;
- extremely lightweight;
- easy to integrate with bash and systemd timers.

Limitations:

- DNF5 injects human-readable headers that require strict programmatic filtering.

---

## Decision

Project Kintsugi adopts the native CLI offline mode for update detection.

The solution relies on the operating system to download metadata in the background. Kintsugi scripts will exclusively query the local results.

---

## Selected Command-Line API

### Standard System Updates

Standard DNF5 updates are queried silently from the local cache.

The output is filtered by architecture extensions to ignore DNF5 headers:

```bash
dnf5 check-upgrade -C --quiet | grep -E '\.(x86_64|noarch|i686|aarch64)' | wc -l
```

### Security Updates

Security-specific updates are isolated using the `--security` flag while remaining offline:

```bash
dnf5 check-upgrade --security -C --quiet | grep -E '\.(x86_64|noarch|i686|aarch64)' | wc -l
```

### Flatpak Updates

Flatpak updates are queried silently using remote tracking data already cached locally:

```bash
flatpak remote-ls --updates | wc -l
```

---

## Validation

The selected API was validated through terminal execution.

The DNF5 cache queries completed in approximately 3 seconds. This confirmed that while the query is local, it must be executed asynchronously (e.g., via a systemd timer) to avoid blocking UI rendering.

Initial parsing attempts using `awk` failed due to unexpected formatting and escape characters in the DNF5 header. The filtering logic was adjusted to use explicit architecture matching (`grep -E '\.(x86_64|noarch)'`), which provided a perfectly accurate package count.

Flatpak remote listing behaved cleanly without extraneous headers and successfully returned accurate integer counts.

The `fwupdmgr --offline` command was confirmed to fail, validating the decision to exclude firmware.

---

## Conclusion

Project Kintsugi standardizes on querying the local DNF5 and Flatpak caches directly via their respective CLIs.

The solution leverages Fedora's native `dnf-makecache.timer` for network operations, ensuring Kintsugi's scripts remain strictly offline.

The final design establishes the exact commands required to build the detection scripts, providing accurate counts for standard packages, security patches, and Flatpaks.

The project is now ready to proceed with the technical implementation of the bash scripts and systemd timers.