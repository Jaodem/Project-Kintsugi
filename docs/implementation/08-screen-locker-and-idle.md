# Screen Locker and Idle Management

## Objective

The objective of this implementation was to integrate automatic screen locking and idle management into the Hyprland desktop environment.

The implementation introduces secure session locking together with automatic idle detection while preserving the modular architecture established throughout Project Kintsugi.

---

## Background

Previous implementations established the desktop session, graphical authentication, Secret Service support, and desktop portal infrastructure.

The remaining security-related desktop component was automatic session protection during user inactivity.

This implementation introduces both the screen locker and the idle daemon recommended by the Hyprland ecosystem.

---

## Scope

This implementation included:

* installing Hyprlock;
* installing Hypridle;
* integrating Hypridle with the systemd user session;
* configuring automatic screen locking;
* configuring automatic display power management (DPMS);
* validating manual and automatic session locking.

The implementation did not include:

* suspend management;
* hibernation policies;
* monitor-specific power policies;
* visual customization beyond the default configuration.

---

## Installed Components

The following packages were installed:

* hyprlock
* hypridle

Both packages were installed using the project's package policy with weak dependencies disabled.

---

## Configuration

Hyprlock was configured as the session locking utility.

Hypridle was configured as the idle detection daemon responsible for:

* automatically locking the session after inactivity;
* powering off the displays after an additional timeout.

The service was enabled through the systemd user session, allowing it to start automatically with the graphical session.

---

## Hyprland 0.56 Compatibility

During validation it was observed that Hyprland 0.56 introduces a Lua-based dispatcher interface.

Previous dispatcher syntax such as:

```
hyprctl dispatch dpms off
```

is no longer accepted.

Instead, display power management uses:

```
hyprctl dispatch 'hl.dsp.dpms({action = "off"})'
```

and

```
hyprctl dispatch 'hl.dsp.dpms({action = "on"})'
```

Project Kintsugi adopts the new syntax to remain compatible with current upstream releases.

---

## Validation

The implementation was validated through:

* successful package installation;
* active `hypridle.service`;
* successful manual execution of Hyprlock;
* successful PAM authentication;
* automatic session locking after the configured timeout;
* automatic display power-off after inactivity;
* automatic display wake-up after user activity.

These validation steps confirmed the correct interaction between Hyprland, Hyprlock, Hypridle, PAM, and systemd.

---

## Results

Observed results include:

* Hyprlock operating correctly.
* PAM authentication functioning normally.
* Automatic idle detection working correctly.
* Session locking performed automatically.
* DPMS correctly powering displays off and on.
* Hypridle managed by the systemd user session.
* No manual startup required.

---

## Architecture Notes

The final architecture consists of:

* Hyprland providing compositor functionality;
* Hyprlock providing secure session locking;
* Hypridle providing idle detection;
* PAM providing authentication;
* systemd managing the user service lifecycle.

Each component maintains a single, clearly defined responsibility.

---

## Conclusion

Automatic session locking and idle management have been successfully integrated into the Hyprland desktop environment.

The resulting implementation improves workstation security while preserving the modular design principles that guide Project Kintsugi.

The implementation follows current upstream recommendations and integrates naturally with the systemd-managed graphical session established in previous phases.

---

## Next Step

With screen locking complete, Project Kintsugi can continue implementing the remaining desktop infrastructure components required to complete Phase 1, including clipboard management, screenshot workflow, and additional desktop integration services.