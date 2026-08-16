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

The configuration does not include:

* replacing Hyprland;
* replacing Fuzzel;
* introducing a separate desktop environment;
* finalizing all mouse and keyboard input behavior;
* implementing monitor management;
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
        hl.dsp.window.resize({ width = -40, height = 0, relative = true }),
        { repeating = true })

hl.bind(mainMod .. " + CTRL + right",
        hl.dsp.window.resize({ width = 40, height = 0, relative = true }),
        { repeating = true })

hl.bind(mainMod .. " + CTRL + up",
        hl.dsp.window.resize({ width = 0, height = -40, relative = true }),
        { repeating = true })

hl.bind(mainMod .. " + CTRL + down",
        hl.dsp.window.resize({ width = 0, height = 40, relative = true }),
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
* no additional desktop-management layer.

The implementation keeps Hyprland responsible for compositor-level workflow while delegating session and power operations to the appropriate existing system services.

---

## Known Limitations

The current document covers the validated Hyprland workflow implemented during Phase 4.1.

The complete Hyprland configuration has not yet been reorganized into separate Lua modules.

Scratchpad behavior has not yet been finalized.

Additional mouse and keyboard input behavior, including `follow_mouse`, remains under evaluation.

Monitor management, wallpaper management, and broader keyboard-driven workflow improvements remain pending.

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