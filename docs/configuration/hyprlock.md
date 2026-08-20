# Hyprlock Configuration

## Overview

This document records the configuration applied to hyprlock as part of Phase 4.6 (Screen Locker and Idle).

Hyprlock provides the screen locking interface for Project Kintsugi. The configuration focuses on functional information and lightweight multimedia integration while keeping the implementation minimal, reversible, and independent of a specific desktop environment or media application.

The underlying lock and unlock functionality was already operational before this configuration pass. This phase focused on improving the information and interaction available on the lock screen.

---

## Applied Configuration

### General Behaviour

* Cursor remains visible while the lock screen is active.
* The existing screenshot background is preserved.
* Background blur is enabled with three blur passes.
* Password authentication remains unchanged.

### Lock Screen Information

The lock screen displays:

* Current time
* Current date
* Battery status
* Battery percentage

The information is positioned in the upper-right area of the lock screen.

### Battery Display

Battery information is displayed using a Nerd Font battery icon together with the current percentage.

The displayed icon changes according to the battery level.

Charging and fully charged states are handled separately.

---

## Multimedia Integration

Hyprlock provides optional multimedia information and controls through MPRIS using `playerctl`.

### Media Information

When a compatible MPRIS media player is available, the lock screen displays:

* Artist
* Track title
* Playback state

The multimedia section is positioned in the lower-right area of the lock screen to keep it visually separated from the time, date, and battery information.

When no media player is active, the multimedia information is hidden.

### Media Controls

The lock screen provides clickable controls for:

* Previous track
* Play / pause
* Next track

The controls are only displayed when media playback is available.

The play/pause icon changes according to the current playback state.

---

## MPRIS Integration

Media integration is intentionally implemented through the MPRIS standard rather than through application-specific integration.

`playerctl` is used as the interface between hyprlock and the active MPRIS player.

The current media player is `ytm_player`, which exposes:

```text
org.mpris.MediaPlayer2.ytm_player
```

and is therefore fully accessible through `playerctl`.

This approach also allows other MPRIS-compatible applications to be used without changing the hyprlock integration.

For example, a future return to a YouTube Music wrapper based on Brave can use the same integration if the application exposes an MPRIS interface.

---

## Configuration Files Touched

### Hyprlock

* `~/.config/hypr/hyprlock.conf`

### Battery

* `~/.config/hypr/scripts/hyprlock/battery-status.sh`

### Multimedia

* `~/.config/hypr/scripts/hyprlock/media-status.sh`
* `~/.config/hypr/scripts/hyprlock/media-state.sh`
* `~/.config/hypr/scripts/hyprlock/media-prev.sh`
* `~/.config/hypr/scripts/hyprlock/media-playpause.sh`
* `~/.config/hypr/scripts/hyprlock/media-next.sh`

---

## Implementation Details

### Time

Hyprlock's native `$TIME` variable substitution is used for the current time.

The time is displayed using the `Monospace` font at a larger font size than the other informational elements.

### Date

The date is generated using the system `date` command:

```text
date +"%A, %d %B %Y"
```

The value is refreshed every 60 seconds.

### Battery

Battery information is obtained through UPower.

The battery script automatically searches for an available battery rather than relying on a hardcoded battery device path.

The script extracts:

* Battery percentage
* Battery state

The output uses Nerd Font battery icons consistent with the icons used elsewhere in the desktop environment.

The script handles:

* Normal discharging
* Charging
* Fully charged
* Pending charge
* Missing battery
* Missing battery percentage

No `acpi` dependency was added.

### Multimedia Metadata

The media metadata script queries `playerctl` for the current player state, artist, and title.

If no active media player is available, or no valid title is returned, the script produces no output.

This allows hyprlock to hide the multimedia section automatically when it is not needed.

### Multimedia State

The media state script reports the current playback state:

* `Playing`
* `Paused`

The corresponding icon is displayed alongside the state.

### Multimedia Controls

Each control is implemented as a separate hyprlock label with its own click action.

The controls invoke the corresponding `playerctl` commands:

```text
playerctl previous
playerctl play-pause
playerctl next
```

This keeps the control logic simple and delegates media control to the MPRIS interface.

---

## Update Intervals

The dynamic elements use different update intervals according to how frequently their values can change:

| Element            |        Update Interval |
| ------------------ | ---------------------: |
| Time               | Native hyprlock update |
| Date               |             60 seconds |
| Battery            |             30 seconds |
| Media metadata     |              5 seconds |
| Media state        |               1 second |
| Previous control   |               1 second |
| Play/Pause control |               1 second |
| Next control       |               1 second |

The shorter multimedia intervals ensure that the displayed playback state and controls remain responsive without requiring a persistent background process.

---

## Design Decisions

### Minimal Dependencies

No additional battery utility was introduced.

UPower was already available on the system and provides all information required for the battery display.

### Script Separation

Battery and multimedia processing are handled by small dedicated scripts rather than embedding complex shell pipelines directly into `hyprlock.conf`.

This keeps the hyprlock configuration readable while keeping each piece of logic independently testable.

### Player-Agnostic Multimedia Integration

The multimedia implementation does not contain any `ytm-player`-specific logic.

MPRIS is used as the abstraction layer, allowing different compatible media players to work through the same interface.

### Conditional Multimedia UI

Multimedia information and controls are hidden when no active media player is available.

The lock screen therefore does not reserve visual space for multimedia when it is not being used.

### Functional Rather Than Decorative

The configuration prioritizes useful information and interaction over extensive visual customization.

Further visual refinement is intentionally deferred to the dedicated theming phase.

---

## Known Limitations

* Multimedia functionality requires the active application to expose an MPRIS interface.
* Metadata availability depends on what the active MPRIS player provides.
* Media controls depend on the capabilities exposed by the active MPRIS player.
* The current battery display assumes that UPower is available.
* The current configuration does not provide application-specific integration for individual media players.

---

## Validation

The configuration was tested by:

* Locking the session using hyprlock.
* Unlocking successfully using the existing password authentication.
* Verifying the time display.
* Verifying the date display.
* Verifying the battery icon and percentage.
* Testing the multimedia display while media was paused.
* Testing the multimedia display while media was playing.
* Testing Previous.
* Testing Play/Pause.
* Testing Next.
* Verifying that multimedia information and controls disappear when no media is playing.

The lock and unlock mechanism remained functional throughout the configuration changes.

---

## Notes

* Screen locking and authentication were already operational before this configuration pass.
* DPMS behaviour is handled separately as part of the monitor configuration work.
* Idle and power-management behaviour are outside the scope of this document.
* The current media implementation has been validated with `ytm_player`.
* The use of MPRIS keeps the implementation open to other compatible media players.
* Further visual theming and aesthetic refinement are deferred to the dedicated theming phase.
