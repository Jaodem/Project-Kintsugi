# Power Management Implementation

## Objective

The objective of this implementation was to validate and standardize the operating system power management infrastructure used by Project Kintsugi.

Rather than introducing new software, the implementation focused on verifying the components already provided by the Fedora KDE Plasma base installation.

---

## Background

Previous implementations established the graphical session, authentication, screen locking, audio, networking, desktop portals, and Bluetooth infrastructure.

Power management completes another core operating system service required by the desktop environment.

---

## Scope

This implementation included:

- validation of systemd-logind;
- validation of UPower;
- validation of Tuned;
- validation of system integration;
- validation of compatibility with the Hyprland session;
- evaluation of Tuned profiles;
- validation of the selected `desktop` profile;

The implementation did not include:

- power profile optimization;
- automatic profile switching;
- battery policy customization;
- suspend policy customization.

---

## Installed Components

No additional power management components were installed.

The implementation also installed:

- powertop

for diagnostic and validation purposes.

The implementation validated the components already present in the Fedora KDE Plasma installation.

---

## Integration

The validated architecture is:

```text
systemd-logind
        │
        ├── suspend / resume
        ├── power events
        │
UPower
        │
        ├── battery information
        │
Tuned
        │
        ├── power profiles
        │
hypridle
        │
        ├── idle detection
        │
hyprlock
```

### Power Profile Selection

Fedora's `tuned-ppd` compatibility daemon was disabled because it overrides
the manually selected Tuned profile during system startup.

The system uses Tuned directly for power profile management. The
`tuned-ppd.service` unit is masked to prevent automatic profile changes, and
the selected Tuned profile is therefore persistent across reboots.

The resulting configuration uses:

```text
tuned.service
    │
    └── selected Tuned profile: desktop

tuned-ppd.service
    │
    └── masked
```

This configuration preserves the native Fedora Tuned infrastructure while
preventing the PPD compatibility layer from replacing the manually selected
profile.

Each component maintains a clearly defined responsibility within the desktop architecture.

---

## Tuned Profile

The Fedora installation initially used the `throughput-performance` profile.

This profile is primarily designed for server workloads and favors sustained processor performance.

Multiple validation sessions were performed using:

- idle desktop workloads;
- continuous multimedia playback;
- repeated processor measurements using `turbostat`.

Based on these measurements, the active profile was changed to:

```text
desktop
```


The selected profile maintained desktop responsiveness while reducing processor operating frequencies during typical notebook workloads.

---

## Validation

The implementation was validated through:

- active systemd-logind service;
- active UPower service;
- active Tuned service;
- successful session integration;
- successful operation within the Hyprland environment;
- successful availability of Tuned power profiles;
- successful persistence of the `desktop` profile across system reboots;
- successful multimedia playback;
- repeated turbostat measurements;

---

## Results

The resulting implementation provides:

- modular power management;
- separation between power management and idle management;
- compatibility with Hyprland;
- compatibility with systemd;
- compatibility with Fedora KDE Plasma;
- notebook-oriented power policy;
- reduced processor operating frequency during typical desktop workloads;
- persistent `desktop` Tuned profile across system reboots;
- disabled `tuned-ppd` compatibility layer to prevent profile overrides;

---

## Known Limitations

The selected configuration relies on Fedora's Tuned infrastructure and its
available profiles.

The `tuned-ppd` compatibility daemon is intentionally masked because it can
override the manually selected Tuned profile during startup.

As a result, desktop environments or applications that rely specifically on
the Power Profiles D-Bus compatibility interface may not be able to change
the Tuned profile through that interface.

Future Fedora releases may introduce changes to Tuned, `tuned-ppd`, or the
Power Profiles compatibility layer that warrant re-evaluation.

---

## Conclusion

Power management has been successfully standardized for Project Kintsugi.

The validated architecture relies on the native Fedora KDE Plasma infrastructure while preserving the project's modular engineering approach.