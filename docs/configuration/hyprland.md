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
* session management through a dedicated session menu;
* integration with Fuzzel for interactive session controls;
* separation of Hyprland-specific scripts from Waybar scripts;
* validation of the resulting session workflow.

The configuration does not include:

* replacing Hyprland;
* replacing Fuzzel;
* introducing a separate desktop environment;
* implementing window-management refinements;
* finalizing mouse and keyboard input behavior;
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
* lock, logout, suspend, reboot, and shutdown actions;
* separation between Hyprland-specific and Waybar-specific scripts;
* integration with the existing system session and power-management infrastructure;
* no additional desktop-management layer.

The implementation keeps Hyprland responsible for compositor-level workflow while delegating session and power operations to the appropriate existing system services.

---

## Known Limitations

The current document covers the validated Hyprland workflow implemented during Phase 4.1.

The complete Hyprland configuration has not yet been reorganized into separate Lua modules.

Window movement and keyboard-based resizing have not yet been implemented as part of the current workflow refinement.

Scratchpad behavior has not yet been finalized.

Mouse and keyboard input behavior, including `follow_mouse`, remains under evaluation.

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

The implementation preserves the project's modular architecture by keeping compositor-specific workflow scripts under the Hyprland configuration while retaining Waybar-specific scripts under the Waybar configuration.

Further Hyprland workflow improvements will be implemented incrementally as part of Phase 4.