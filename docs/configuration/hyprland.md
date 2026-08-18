# Hyprland Configuration

## Objective

The objective of this configuration is to define and standardize the practical Hyprland workflow used by Project Kintsugi.

The implementation focuses on keyboard-driven interaction, session controls, and integration with the supporting scripts required by the Hyprland session while keeping compositor configuration separate from status-bar-specific functionality.

---

## Background

Previous implementations established Hyprland as the selected compositor for Project Kintsugi and documented the installation and supporting desktop infrastructure.

The current configuration work focuses on refining Hyprland for daily use rather than replacing the compositor or introducing an additional desktop-management layer.

The configuration is maintained through Lua and dedicated scripts, with system-management operations delegated to the appropriate existing system services.

---

## Scope

This configuration includes:

* practical Hyprland keyboard bindings;
* directional keyboard focus movement;
* keyboard-based tiled-window movement;
* precise keyboard-based floating-window movement;
* keyboard-based window resizing;
* session management through a dedicated session menu;
* integration with Fuzzel for interactive session controls;
* separation of Hyprland-specific scripts from Waybar scripts;
* validation of the resulting session workflow.
* integration with KDE Plasma's Emoji Selector;
* integration with the terminal-based WhatsApp client;
* clipboard persistence through `cliphist` for short-lived clipboard producers;
* monitor configuration with explicit scaling and positioning;
* Fuzzel-based monitor management menu for quick configuration switching;
* validation of core application integration (Kitty, Dolphin, screenshot utilities);

The configuration does not include:

* replacing Hyprland;
* replacing Fuzzel;
* introducing a separate desktop environment;
* implementing wallpaper management;
* reorganizing the complete Hyprland configuration into modules.

Those areas are part of the subsequent Phase 4 workflow.

---

## Configuration Structure

The main Hyprland configuration is:

```text
~/.config/hypr/hyprland.lua
```

Hyprland-specific workflow scripts are stored separately from Waybar scripts:

```text
~/.config/hypr/
├── hyprland.lua
└── scripts/
    └── session-menu.sh
```

This separation reflects the responsibility of each component.

Scripts under:

```text
~/.config/hypr/scripts/
```

are intended to support the Hyprland session itself.

Scripts under:

```text
~/.config/waybar/scripts/
```

remain responsible for functionality initiated specifically through Waybar.

This prevents compositor-level workflow functionality from becoming dependent on the status bar.

---

## Session Management

Session management is provided through a dedicated Fuzzel-based session menu.

The menu is implemented through:

```text
~/.config/hypr/scripts/session-menu.sh
```
The menu provides the following actions:

```text
Lock
Logout
Suspend
Reboot
Shutdown
```

The menu is intentionally presented as a centered Fuzzel launcher rather than using the top-right positioning used by the interactive Waybar menus.

This distinction reflects the different responsibilities of the two interfaces:

* Waybar menus provide contextual controls associated with individual status-bar modules.
* The session menu provides a global desktop-session interface.

---

## Session Menu Actions

### Lock

The `Lock` action launches the configured Hyprland screen locker.

The current implementation was validated by selecting `Lock` from the session menu and successfully unlocking the session using the configured authentication mechanism.

---

### Logout

The `Logout` action terminates the current graphical session.

The implementation was validated by selecting `Logout` from the session menu and confirming that the Hyprland session ended successfully.

---

### Suspend

The `Suspend` action suspends the system using the existing system power-management infrastructure.

The implementation was validated by selecting `Suspend` and confirming that the system entered suspend successfully.

---

### Reboot

The `Reboot` action restarts the system using the existing system power-management infrastructure.

The implementation was validated by selecting `Reboot` and confirming that the system restarted successfully.

---

### Shutdown

The `Shutdown` action powers the system off using the existing system power-management infrastructure.

The implementation was validated by selecting `Shutdown` and confirming that the system powered off successfully.

---

## Keyboard Binding

The session menu is invoked through:

```text
Ctrl + Alt + Delete
```

The binding is defined in:

```text
~/.config/hypr/hyprland.lua
```

as:

```lua
-- Session menu: lock, logout, suspend, reboot, or shutdown
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("~/.config/hypr/scripts/session-menu.sh"))
```

The previous `Super + M` binding was removed.

The previous binding invoked `hyprshutdown` when available and otherwise attempted to terminate the Hyprland session. This behavior did not match the intended session-management workflow and was therefore replaced by the dedicated session menu.

After reloading the Hyprland configuration, the new binding was validated through normal interactive use.

---

## Mouse Focus Behavior

The mouse focus behavior is now configurable at runtime through a dedicated toggle.

The `follow_mouse` option was investigated experimentally to understand the difference between its two states:

* `follow_mouse = 1`: the window under the cursor receives focus automatically (focus-follows-mouse).
* `follow_mouse = 0`: the cursor can move freely without changing the active window focus.

Both values can be changed dynamically using `hyprctl eval` without restarting the compositor, which was validated through direct testing.

### Decision

The chosen interaction model is hybrid and user-selectable at runtime rather than fixed permanently to a single behavior.

This allows the user to switch between focus-follows-mouse and a decoupled focus model depending on the current workflow or task.

### Implementation

The toggle is implemented through a dedicated script:

```text
~/.config/hypr/scripts/toggle-follow-mouse.sh
```

The script retrieves the current `follow_mouse` state using:

```bash
hyprctl getoption input:follow_mouse -j | jq -r '.int'
```

and toggles it using:

```bash
hyprctl eval 'hl.config({ input = { follow_mouse = 1 } })'
```

or:

```bash
hyprctl eval 'hl.config({ input = { follow_mouse = 0 } })'
```

The full script is:

```bash
#!/bin/bash

current=$(hyprctl getoption input:follow_mouse -j | jq -r '.int')

if [ "$current" = "1" ]; then
    hyprctl eval 'hl.config({ input = { follow_mouse = 0 } })'
else
    hyprctl eval 'hl.config({ input = { follow_mouse = 1 } })'
fi
```

The script is made executable and stored under the Hyprland-specific scripts directory.

### Keyboard Binding

The toggle is bound to:

```text
Super + F
```

The binding is defined in `~/.config/hypr/hyprland.lua` as:

```lua
-- Toggle mouse focus behavior (follow_mouse)
hl.bind(mainMod .. " + F",
        hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-follow-mouse.sh"))
```

### Validation

The toggle was validated by switching between both states and observing the focus behavior while moving the cursor between windows.

- In the active state (follow_mouse = 1), hovering over a different window correctly transferred focus.
- In the inactive state (follow_mouse = 0), the cursor moved without changing the focused window.

No side effects were observed in keyboard-based window movement or resizing, confirming that the mouse focus model operates independently from the keyboard interaction model.

### Results

The mouse focus behavior is now explicitly defined and user-controllable.

The implementation provides a practical mechanism to switch between focus-follows-mouse and a keyboard-driven focus model without modifying the broader interaction workflow or requiring a Hyprland restart.

This resolves the previously pending mouse input evaluation.

---

## Monitor Configuration

The monitor configuration is explicitly defined in `~/.config/hypr/hyprland.lua` using `hl.monitor()`.

The current configuration is:

```lua
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "0x0",
    scale    = 1.25,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "1536x0",
    scale    = 1,
})
```
The notebook display (`eDP-1`) uses a scale of `1.25` to improve readability, while the external monitor (`HDMI-A-1`) remains at `1.0`. Both use the preferred mode for their respective resolutions.

The external monitor is positioned to the right of the notebook display (`1536x0`, where `1536` accounts for the scaled width of `eDP-1` at 1920×1080 × 1.25).

### Monitor Management Menu
A Fuzzel-based menu provides quick access to common monitor configurations.

The script is implemented as:

```text
~/.config/hypr/scripts/monitor-menu.sh
```

The menu offers the following options:

```text
Monitors ›
Extend — Notebook + monitor
Notebook only
Monitor only
Restore current configuration
```

The configurations are applied dynamically using `hyprctl eval` and `hl.monitor()`, without permanently modifying the main configuration file.

The available configurations are:

| Option | Notebook (eDP-1) | External monitor (HDMI-A-1) |
|--------|------------------|-----------------------------|
| Extend — Notebook + monitor | 1.25, active | 1, active |
| Notebook only | 1.25, active | disabled |
| Monitor only | disabled | 1, active |
| Restore current configuration | 1.25, active | 1, active |

### Keyboard Binding

The monitor menu is invoked through:

```text
Super + M
```

The binding is defined in ~/.config/hypr/hyprland.lua as:

```lua
-- Monitor management menu
hl.bind(mainMod .. " + M",
        hl.dsp.exec_cmd("~/.config/hypr/scripts/monitor-menu.sh"))
```

### Validation

The configuration was validated by:

* verifying that both monitors apply their correct scales and positions using `hyprctl monitors`;
* switching between all available configurations using the menu;
* confirming that `hyprctl configerrors` reports no errors after toggling configurations;
* testing the `Super + M` binding in the active Hyprland session.

### Decision on Profiles

No separate monitor profiles were implemented.

For the current system state, the required configurations are few and fully represented by the menu options. Adding a persistent profile system would introduce unnecessary complexity without addressing a concrete need.

The menu directly applies the desired configuration using Hyprland's runtime evaluation, keeping the permanent configuration simple and the workflow flexible.

---

## Window Appearance

The Hyprland window appearance was reviewed and refined during Phase 4.9 with the goal of reducing unnecessary visual space while keeping the interface clean, readable, and visually restrained.

The current appearance configuration is:

```lua
general = {
    gaps_in  = 4,
    gaps_out = 10,

    border_size = 2,

    col = {
        active_border   = "rgba(780606ff)",
        inactive_border = "rgba(595959aa)",
    },
}

decoration = {
    rounding       = 10,
    rounding_power = 2,

    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    shadow = {
        enabled      = true,
        range        = 4,
        render_power = 3,
        color        = 0xee1a1a1a,
    },

    blur = {
        enabled   = true,
        size      = 3,
        passes    = 1,
        vibrancy  = 0.1696,
    },
}
```

### Gaps

The internal and external gaps were reduced from their previous values to make more efficient use of the available screen area.

The current values are:

```text
gaps_in  = 4
gaps_out = 10
```

The reduced `gaps_out` value provides less unused space between the tiled windows and the edges of the display, while `gaps_in = 4` maintains a small visual separation between adjacent windows.

### Borders

The window border size remains:

```text
border_size = 2
```

This provides a clearly visible focus indicator without making the border visually dominant.

The active-window border uses a single accent color rather than the previous cyan/green gradient:

```text
active_border = #780606
```

The inactive border remains a neutral gray:

```text
inactive_border = #595959
```

The `#780606` color is considered the current Project Kintsugi accent color. Its reuse across other desktop components may be evaluated later as part of the broader desktop-theme work.

No global theme changes are implied by this decision.

### Rounding

Window rounding is set to:

```text
rounding = 10
rounding_power = 2
```

The selected value provides moderately rounded corners without introducing an exaggerated rounded-window appearance.

### Shadows and Blur

Shadows remain enabled with a conservative configuration:

```text
range        = 4
render_power = 3
```

Blur also remains enabled with:

```text
size      = 3
passes    = 1
vibrancy  = 0.1696
```

The blur configuration already uses a low number of passes and a small blur size, avoiding unnecessary rendering overhead while retaining the visual separation provided by the effect.

Hyprland's current effective configuration also reports:

```text

decoration:blur:new_optimizations = true
```

The option is currently active through Hyprland's effective defaults and is therefore not duplicated in the project configuration.

No additional performance-oriented reductions were introduced because no concrete performance problem was identified during this appearance review.

Opacity

Both active and inactive windows remain fully opaque:

```text
active_opacity   = 1.0
inactive_opacity = 1.0
```

Transparency was intentionally not introduced as part of this refinement.

### Design Decision

The resulting appearance follows the Project Kintsugi preference for minimal visual complexity:

* reduced gaps to use screen space more efficiently;
* moderate window rounding;
* a consistent 2-pixel border;
* a single dark-red accent for the active window;
* neutral inactive borders;
* restrained shadows and blur;
* no transparency;
* no additional decorative effects.

The appearance configuration is considered complete for this Phase 4.9 item. Further visual changes should be evaluated independently as part of the broader desktop-theme work rather than added to the window-appearance configuration without a concrete need.


---

## Keyboard-Driven Window Management

Hyprland window management has been extended with dedicated keyboard bindings for focus movement, window movement, floating-window positioning, and window resizing.

The bindings are defined in:

```text
~/.config/hypr/hyprland.lua
```

The current keyboard workflow is:

```text
Super + Arrow
    Move focus between windows

Super + Shift + Arrow
    Move the active window within the Hyprland layout

Super + Alt + Arrow
    Move a floating window precisely

Super + Ctrl + Arrow
    Resize the active window precisely
```

## Emoji Selector

KDE Plasma's Emoji Selector is integrated directly into the Hyprland workflow.

The selector is launched with:

```text
Super + .
```

The binding is defined as:

```lua
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("~/.config/hypr/scripts/emoji-selector.sh"))
```

The application enforces its own minimum usable dimensions, so the small configured size does not reduce the selector below its supported minimum size.

The resulting behavior is:

```text
Super + .
    Open Emoji Selector near the current cursor position

Emoji selection
    Copy the selected emoji to the clipboard

Esc
    Close Emoji Selector
```

The final implementation launches plasma-emojier directly and does not require a dedicated launcher script.

Clipboard persistence for the short-lived Emoji Selector is provided separately through `cliphist`.

## Clipboard Persistence

`cliphist` is used to preserve clipboard contents produced by short-lived applications such as KDE Plasma's Emoji Selector.

The clipboard history watcher runs as a user-level systemd service:

```text
cliphist.service
```

The service runs:

```text
/usr/bin/wl-paste --type text --watch /usr/bin/cliphist store
```

This allows clipboard contents to remain available after the application that originally produced them exits.

The clipboard history can be inspected with:

```bash
cliphist list
```

and individual entries can be restored to the Wayland clipboard with:

```bash
cliphist decode <entry> | wl-copy
```

The service is enabled to start automatically with the user's systemd session.

## WhatsApp Terminal Client

A terminal-based WhatsApp client was added to the workstation as part of the desktop application workflow.

The selected client is `whatscli`.

The application was installed from its upstream Linux release and placed in the user's local executable directory:

```text
~/.local/bin/whatscli
```

The executable is available through the user's `PATH`:

```text
command -v whatscli
```

The installed version is:

```text
whatscli 1.1.6
```

The application was selected after evaluating terminal-based WhatsApp alternatives.

`wacli` was tested previously but was not retained because its workflow was not considered satisfactory for the intended daily use.

The final WhatsApp client is therefore whatscli.

### Focus Movement

The `Super + Arrow` bindings move keyboard focus between adjacent windows:

```lua
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
```

This provides directional keyboard navigation without moving or resizing the focused window.

### Tiled Window Movement

The `Super + Shift + Arrow` bindings move the active window through the Hyprland layout:

```lua
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d" }))
```

This uses Hyprland's directional window-movement dispatcher and therefore operates according to the active layout rather than moving the window by arbitrary screen coordinates.

### Floating Window Movement

Floating windows can be moved precisely using `Super + Alt + Arrow`.

Each key press moves the active floating window by 40 pixels:

```lua
hl.bind(mainMod .. " + ALT + left",
        hl.dsp.window.move({ x = -40, y = 0, relative = true }),
        { repeating = true })

hl.bind(mainMod .. " + ALT + right",
        hl.dsp.window.move({ x = 40, y = 0, relative = true }),
        { repeating = true })

hl.bind(mainMod .. " + ALT + up",
        hl.dsp.window.move({ x = 0, y = -40, relative = true }),
        { repeating = true })

hl.bind(mainMod .. " + ALT + down",
        hl.dsp.window.move({ x = 0, y = 40, relative = true }),
        { repeating = true })
```

The bindings use relative coordinates and are configured as repeating bindings so that holding the key continuously moves the window.

This provides keyboard-controlled positioning comparable to mouse-based movement while retaining a fixed movement increment.


### Window Resizing

The active window can be resized using `Super + Ctrl + Arrow`.

Each key press changes the corresponding dimension by 40 pixels:

```lua
hl.bind(mainMod .. " + CTRL + left",
        hl.dsp.window.resize({ x = -40, y = 0, relative = true }),
        { repeating = true })

hl.bind(mainMod .. " + CTRL + right",
        hl.dsp.window.resize({ x = 40, y = 0, relative = true }),
        { repeating = true })

hl.bind(mainMod .. " + CTRL + up",
        hl.dsp.window.resize({ x = 0, y = -40, relative = true }),
        { repeating = true })

hl.bind(mainMod .. " + CTRL + down",
        hl.dsp.window.resize({ x = 0, y = 40, relative = true }),
        { repeating = true })
```

The `relative = true` parameter is required for these bindings because the values represent size deltas rather than absolute dimensions.

### Floating Window Mode

The existing:

```text
Super + V
```

binding toggles the focused window between tiled and floating mode:

```text
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
```

This allows the precise `Super + Alt + Arrow` movement workflow to be used when a window is floating.

The same floating state can also be resized using the `Super + Ctrl + Arrow` bindings.

---

## Fuzzel Integration

Fuzzel is used as the interactive interface for the session menu.

Unlike the contextual menus launched from Waybar, the session menu uses the default centered launcher presentation.

This provides a more appropriate visual and interaction model for a global session action.

The observed mouse behavior of Fuzzel was also evaluated during this configuration work.

The validated behavior is:

```text
Left click
    Selects and launches the item under the pointer

Right click
    Closes Fuzzel without selecting the item

Mouse wheel / touchpad
    Scrolls the menu
```

The observed behavior was treated as Fuzzel's own input behavior rather than as a Hyprland window-management rule.

The configuration therefore does not introduce compositor-specific mouse rules to reproduce or override this behavior.

---

## Responsibility Separation

The session menu is intentionally stored under the Hyprland configuration rather than under the Waybar configuration.

The separation is based on functional ownership rather than on the application used to present the interface.

The current organization is:

```text
~/.config/hypr/scripts/
└── session-menu.sh

~/.config/waybar/scripts/
├── wifi-menu.sh
├── bluetooth-menu.sh
└── power-profile.sh
```

The session menu belongs to the Hyprland session because it provides global session-level operations.

The Wi-Fi, Bluetooth, and power-profile menus remain under Waybar because they are currently exposed as contextual controls through Waybar modules.

Both groups may use Fuzzel, but the shared interface technology does not determine configuration ownership.

This separation keeps session-management functionality independent from the status bar and allows future Hyprland-specific scripts to follow the same organizational model.

---

## Validation

The configuration was validated through direct interactive testing within the active Hyprland session.

The following actions were individually tested through the session menu:

```text
Lock       → successful
Logout     → successful
Suspend    → successful
Reboot     → successful
Shutdown   → successful
```

The keyboard binding was subsequently changed to:

```text
Ctrl + Alt + Delete
```

and the Hyprland configuration was reloaded without restarting the graphical session.

The new binding was successfully validated.

The previous:

```text
Super + M
```

binding no longer performs the previous session-management action.

The Wi-Fi and Bluetooth menus were also independently validated during the same workflow refinement period, including their respective ON/OFF controls.

---

## Results

The resulting Hyprland workflow provides:

* a dedicated global session menu;
* keyboard access through `Ctrl + Alt + Delete`;
* centralized Fuzzel presentation;
* directional keyboard focus movement;
* keyboard-based movement of tiled windows;
* precise keyboard-based movement of floating windows;
* keyboard-based window resizing;
* repeating bindings for continuous floating-window movement and resizing;
* lock, logout, suspend, reboot, and shutdown actions;
* separation between Hyprland-specific and Waybar-specific scripts;
* integration with the existing system session and power-management infrastructure;
* no additional desktop-management layer;
* KDE Plasma Emoji Selector integration with cursor-relative positioning;
* direct `Super + .` access to the Emoji Selector;
* terminal-based WhatsApp access through `whatscli`;
* clipboard persistence through `cliphist` for short-lived clipboard producers;
* persistent clipboard history through a user-level `cliphist` systemd service;
* explicit monitor configuration with scaling and positioning;
* Fuzzel-based monitor management menu accessed through `Super + M`;
* dynamic switching between display configurations without modifying the permanent configuration;
* no unnecessary profile layer, keeping the configuration simple;
* core application integration (Kitty, Dolphin, screenshot) validated as part of the daily workflow;

The implementation keeps Hyprland responsible for compositor-level workflow while delegating session and power operations to the appropriate existing system services.

---

## Known Limitations

The current document covers the validated Hyprland workflow implemented during Phase 4.1.

The complete Hyprland configuration has not yet been reorganized into separate Lua modules.

Scratchpad behavior has not yet been finalized.

Wallpaper management remains pending.

These areas will be addressed independently during the subsequent Phase 4 subphases.

---

## Reproducibility

The current session-management workflow can be reproduced through:

```text
~/.config/hypr/hyprland.lua
~/.config/hypr/scripts/session-menu.sh
```

The workflow relies on existing system components rather than introducing a separate session-management application.

The interactive interface is provided by Fuzzel, while locking, session termination, suspension, reboot, and shutdown are delegated to the existing desktop and system infrastructure.

---

## Conclusion

The current Hyprland workflow has been successfully refined and validated for Project Kintsugi.

The session-management interface is now separated from Waybar and implemented as a Hyprland-specific workflow component.

A dedicated Fuzzel session menu provides centralized access to locking, logout, suspend, reboot, and shutdown operations through the `Ctrl + Alt + Delete` keyboard binding.

The Hyprland keyboard workflow has also been extended with directional focus movement, tiled-window movement, precise floating-window movement, and keyboard-based window resizing.

Floating-window movement and resizing use relative coordinate deltas and repeating keyboard bindings, allowing continuous adjustment while a key is held.

These bindings provide a consistent keyboard-driven workflow while preserving Hyprland's existing layout-based behavior for tiled windows.

The implementation preserves the project's modular architecture by keeping compositor-specific workflow scripts under the Hyprland configuration while retaining Waybar-specific scripts under the Waybar configuration.

Further Hyprland workflow improvements will be implemented incrementally as part of Phase 4.