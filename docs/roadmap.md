# Project Roadmap

> Building knowledge one layer at a time.

## Vision

Project Kintsugi is built incrementally.

Each stage focuses on understanding, documenting, implementing, and validating one part of the system before moving to the next.

The objective is continuous improvement rather than rapid completion.

The roadmap describes the current state of the project and the work that remains to be evaluated. It is not a checklist of software to install: a component may be considered complete when the existing system is understood, validated, and intentionally retained.

---

## Project Status

The initial foundation and core desktop environment have been established and documented.

The project has progressed beyond the original roadmap structure. The current implementation and documentation cover the following areas:

* Hyprland and Wayland session architecture
* Terminal emulator
* Application launcher
* File manager
* Status bar
* Notification daemon
* Authentication agent
* Screen locking and idle management
* XDG Desktop Portal
* Screenshot utility
* Audio
* Network management
* Session management
* Bluetooth
* Power management
* XDG user directories
* XDG MIME applications
* Trash management
* Clipboard management
* XDG autostart
* Secrets management

These areas have corresponding implementation documentation under `docs/implementation/` and supporting documentation where applicable.

The project should therefore be considered beyond the initial desktop-foundation stage.

---

## Phase 0 — Foundation

Understand the existing system and establish the project's engineering principles.

* [x] Initialize the repository
* [x] Define the project philosophy
* [x] Define the project architecture
* [x] Audit the initial Fedora installation
* [x] Document the initial decisions
* [x] Establish documentation and validation practices
* [x] Establish the Git workflow

**Status:** Completed.

The results of this phase are documented in the project foundation, architecture, philosophy, decision criteria, audit, and Phase 0 summary documents.

---

## Phase 1 — Core Desktop Environment

Build and validate the minimal Wayland desktop environment.

* [x] Hyprland
* [x] Terminal emulator
* [x] Application launcher
* [x] File manager
* [x] Status bar
* [x] Notification daemon
* [x] Authentication agent
* [x] Screen locking and idle management
* [x] XDG Desktop Portal
* [x] Screenshot utility

**Status:** Completed.

Each component was evaluated in the context of the existing system before implementation or adoption. Existing system components were retained where they were already suitable.

---

## Phase 2 — Desktop Services and Integration

Establish the supporting services required for a functional daily desktop.

* [x] Audio
* [x] Network management
* [x] Session management
* [x] Bluetooth
* [x] Power management
* [x] XDG user directories
* [x] XDG MIME applications
* [x] Trash management
* [x] Clipboard management
* [x] XDG autostart
* [x] Secrets management

**Status:** Completed.

The services in this phase have been implemented, standardized, or validated according to the project's architecture and decision criteria.

Where the existing Fedora infrastructure already provided an appropriate solution, no unnecessary replacement was introduced.

---

## Phase 3 — Validation and Refinement

Verify that the assembled environment behaves coherently as a complete desktop session.

This phase focuses on integration, refinement, and validation rather than replacing components that are already working.

### Completed areas

* [x] Review desktop integration gaps
* [x] Evaluate Waybar icon and font integration
* [x] Configure Waybar as the primary status bar presentation layer
* [x] Configure Waybar modules for Hyprland, audio, networking, Bluetooth, keyboard layout, CPU, memory, battery, weather, clock, and system tray
* [x] Implement CPU monitoring
* [x] Implement memory monitoring
* [x] Implement weather information
* [x] Implement an interactive calendar popup
* [x] Implement a Wi-Fi management menu
* [x] Implement a Bluetooth management menu
* [x] Implement a power profile menu
* [x] Refine Waybar styling and module presentation
* [x] Validate interactive desktop components within the Hyprland session
* [x] Document the resulting Waybar configuration and supporting scripts

The resulting configuration was validated through direct testing and normal interactive use within the Hyprland session.

The implementation preserves the existing desktop architecture. Waybar provides the presentation and interaction layer, while existing system services remain responsible for networking, Bluetooth, audio, power management, and other system functions.

No additional desktop-integration layer was introduced where existing components and dedicated scripts were sufficient.

**Status:** Completed.

---

## Phase 4 — Workflow and Daily Use

Improve the environment around the way the system is actually used.

This phase is driven by real-world usage rather than a predefined list of software or configuration changes.

Each subphase focuses on a specific aspect of the daily workflow and follows the project's incremental implementation process:

1. Observe a real requirement or limitation.
2. Investigate the current behavior.
3. Evaluate alternatives when necessary.
4. Make an explicit decision.
5. Implement the smallest justified change.
6. Validate the result through actual use.
7. Document the final state.

---

### 4.1 — Menus and Basic Actions

* [x] Implement a dedicated session menu
* [x] Move the session menu script to the Hyprland configuration
* [x] Replace the previous `Super + M` session binding with `Ctrl + Alt + Delete`
* [x] Use a centered Fuzzel presentation for the session menu
* [x] Validate Lock, Logout, Suspend, Reboot, and Shutdown actions
* [x] Rename `power-menu.sh` to `power-profile.sh`
* [x] Review Fuzzel mouse and dismissal behavior
* [x] Review Wi-Fi ON/OFF behavior
* [x] Review Bluetooth ON/OFF behavior
* [x] Document the resulting Hyprland workflow configuration
* [x] Document the resulting Waybar configuration and supporting scripts

**Status:** Completed.

The first workflow refinement established dedicated interactive controls for common session and system actions.

The session menu is now implemented as a Hyprland-specific workflow component under:

```text
~/.config/hypr/scripts/session-menu.sh
```

The session menu provides:

```text
Lock
Logout
Suspend
Reboot
Shutdown
```

and is invoked through:

```text
Ctrl + Alt + Delete
```

Fuzzel was evaluated as the common interactive interface for these menus. Its mouse behavior was investigated and confirmed to be provided by Fuzzel itself rather than by a Hyprland window-management rule.

The Wi-Fi and Bluetooth menus were also reviewed and validated with their respective ON/OFF controls.

The resulting Hyprland workflow is documented in:

```text
docs/configuration/hyprland.md
```

The corresponding Waybar configuration and supporting scripts are documented separately in:

```text
docs/configuration/waybar.md
```

---

### 4.2 — Window Management

* [x] Implement keyboard-based window focus movement
* [x] Implement keyboard-based tiled window movement
* [x] Implement precise movement for floating windows
* [x] Implement keyboard-based window resizing
* [x] Validate repeated movement and resizing bindings
* [x] Review `special:magic` scratchpad behavior
* [x] Determine whether an application should be assigned to the scratchpad

**Status:** Completed.

This subphase established and validated the intended keyboard-driven window-management workflow, including window focus, movement, floating-window positioning, and resizing.

Scratchpad behavior was also reviewed and finalized according to the intended workflow.

---

### 4.3 — Applications and Clipboard

* [x] Integrate KDE Plasma Emoji Selector into the Hyprland workflow
* [x] Evaluate terminal-based WhatsApp clients
* [x] Select and install `whatscli`
* [x] Implement clipboard persistence with `cliphist`

**Status:** Completed.

This subphase established several daily-use application and clipboard workflow improvements based on actual usage requirements.

---

### 4.4 — Input

* [ ] Review and refine `follow_mouse`
* [ ] Determine the intended mouse-focus behavior
* [ ] Determine the final keyboard and mouse interaction model

**Status:** Pending.

Input behavior will be evaluated independently from window-management bindings to avoid introducing unnecessary interaction complexity.

---

### 4.5 — Notifications

* [ ] Review the current Mako configuration
* [ ] Correct notification timeout behavior
* [ ] Review notification urgency handling
* [ ] Remove automatic suspension triggered by critical battery level

**Status:** Pending.

This subphase will focus on making notification behavior predictable and consistent with the intended desktop workflow.

---

### 4.6 — Monitors

* [ ] Resolve monitor scaling definitively at `1.0`
* [ ] Implement a Fuzzel-based monitor management menu
* [ ] Provide convenient access to monitor configuration
* [ ] Determine whether monitor profiles are required

**Status:** Pending.

The objective is to make monitor configuration accessible without introducing unnecessary persistent configuration complexity.

---

### 4.7 — Wallpaper

* [ ] Evaluate wallpaper management tools
* [ ] Select the appropriate wallpaper implementation
* [ ] Determine whether to use one wallpaper across all monitors or separate wallpapers
* [ ] Remove the default Hyprland wallpaper permanently

**Status:** Pending.

Wallpaper management will be evaluated as a separate desktop-appearance concern rather than being coupled to monitor management.

---

### 4.8 — Keyboard as the Primary Interface

* [ ] Review existing keyboard bindings
* [ ] Add useful workflow actions
* [ ] Evaluate Fuzzel as a command-oriented interaction layer
* [ ] Review multimedia bindings
* [ ] Review brightness controls
* [ ] Review audio controls
* [ ] Identify additional frequently used keyboard actions

**Status:** Pending.

This subphase will consolidate the keyboard-driven workflow after the underlying window, input, monitor, and desktop-control behavior has been established.

---

### 4.9 — Organization

* [ ] Separate the Hyprland Lua configuration into modules
* [ ] Organize Hyprland-specific scripts
* [ ] Document keyboard bindings
* [ ] Review configuration ownership
* [ ] Leave the configuration in a maintainable final structure

**Status:** Pending.

Configuration reorganization will be performed after the workflow has stabilized so that the module structure reflects the actual responsibilities of the final configuration rather than an assumed architecture.

---

Phase 4 Principles

Phase 4 follows the project's existing engineering principles:

1. Improve the workflow based on actual use.
2. Investigate existing behavior before introducing changes.
3. Prefer existing system infrastructure when it is suitable.
4. Keep functionality separated according to component responsibility.
5. Use dedicated scripts when they simplify the configuration without creating unnecessary dependencies.
6. Validate interactive behavior through actual use.
7. Document important decisions and final configuration state.
8. Avoid premature reorganization before the workflow is understood.
9. Treat intentional non-changes as valid outcomes.
10. Implement each subphase independently when possible.

---

## Phase 5 — Optimization and Maintenance

Improve performance, maintainability, and clarity after the desktop environment has been validated.

Potential areas include:

* [ ] Review installed packages
* [ ] Review unnecessary services
* [ ] Identify repetitive manual tasks
* [ ] Evaluate automation opportunities
* [ ] Refactor configuration where justified
* [ ] Review configuration ownership and organization

Optimization should only be performed when there is an identifiable benefit. Complexity should not be introduced for its own sake.

**Status:** Pending evaluation.

---

## Phase 6 — Reproducibility

Make the environment easier to reproduce, restore, and maintain.

Potential areas include:

* [ ] Organize dotfiles
* [ ] Improve installation documentation
* [ ] Define a reproducible installation procedure
* [ ] Define a backup strategy
* [ ] Review repository structure
* [ ] Evaluate preparation for a public repository

Reproducibility should be developed from the configuration and decisions that have already been validated rather than from an assumed target configuration.

**Status:** Pending evaluation.

---

## Closed Decisions and Intentional Non-Changes

Not every investigated issue requires an implementation.

When investigation shows that the current behavior is acceptable, stable, and sufficiently understood, the project may explicitly choose not to change it.

One example is secrets management.

The current Secret Service architecture has been validated, including GNOME Keyring and its interaction with applications such as Brave Browser. Automatic keyring unlocking and related PAM/session changes were investigated but were not modified because the observed behavior did not justify introducing additional complexity.

Such decisions are considered part of the project's state and should not reappear as pending implementation work unless new evidence justifies reopening them.

---

## Roadmap Principles

The roadmap follows the same principles as the rest of the project:

1. Understand the current system before changing it.
2. Investigate alternatives before selecting a solution.
3. Prefer existing system infrastructure when it is suitable.
4. Test changes before considering them complete.
5. Document important decisions and limitations.
6. Avoid changes whose benefits do not justify their complexity.
7. Treat intentional non-changes as valid engineering decisions.
8. Keep the repository and documentation synchronized with the actual system state.
9. Do not reopen completed investigations without new evidence.
10. Prefer a well-understood system over a more feature-rich but less understood one.

---

## Current Focus

The desktop environment and its core integration layer have been validated and refined.

The immediate focus is now the user's daily workflow, including keyboard-driven interaction, workspace organization, terminal usage, file-management workflows, and the development environment.

These areas will be evaluated individually and implemented only where they provide a clear benefit to the overall desktop workflow.

After workflow improvements have been evaluated and validated, the project can proceed toward optimization, maintenance, and reproducibility in a controlled manner.

> The roadmap is a living representation of the project's actual state. It should be updated as decisions are made rather than used as a predetermined list of changes.