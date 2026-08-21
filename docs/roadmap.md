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

* [x] Implement dedicated session menu with Fuzzel
* [x] Replace `Super + M` with `Ctrl + Alt + Delete` for session actions
* [x] Validate session actions (Lock, Logout, Suspend, Reboot, Shutdown)
* [x] Document Hyprland workflow and Waybar configuration

**Status:** Completed.

The session menu is now a Hyprland-specific workflow component under `~/.config/hypr/scripts/session-menu.sh`, providing Lock, Logout, Suspend, Reboot, and Shutdown actions through a centered Fuzzel interface.

Wi-Fi and Bluetooth ON/OFF controls were reviewed and validated during the same period.

The resulting configurations are documented in `docs/configuration/hyprland.md` and `docs/configuration/waybar.md`.

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

* [x] Review and refine `follow_mouse`
* [x] Determine the intended mouse-focus behavior
* [x] Determine the final keyboard and mouse interaction model

**Status:** Completed.

The mouse focus behavior is now configurable at runtime through a dedicated toggle (`Super + F`) that switches between `follow_mouse = 1` (focus-follows-mouse) and `follow_mouse = 0` (cursor movement does not change focus).

The chosen model is hybrid and user-selectable, allowing the user to adapt the behavior to the current workflow without restarting the compositor.

The implementation is documented in `docs/configuration/hyprland.md` under the Mouse Focus Behavior section.

---

### 4.5 — Monitors

* [x] Resolve monitor scaling definitively
* [x] Implement a Fuzzel-based monitor management menu
* [x] Provide convenient access to monitor configuration
* [x] Determine whether monitor profiles are required

**Status:** Completed.

The monitor configuration is now explicitly defined in `~/.config/hypr/hyprland.lua` using `hl.monitor()`.

The notebook display (`eDP-1`) uses a scale of `1.25` to improve readability, while the external monitor (`HDMI-A-1`) remains at `1.0`. Both use the preferred mode for their respective resolutions.

A Fuzzel-based menu provides quick access to common monitor configurations:

```text
Monitors ›
Extend — Notebook + monitor
Notebook only
Monitor only
Restore current configuration
```

The menu is invoked through Super + M and applies configurations dynamically using hyprctl eval, without permanently modifying the main configuration file.

| Option | Notebook (eDP-1) | External monitor (HDMI-A-1) |
|--------|------------------|-----------------------------|
| Extend — Notebook + monitor | 1.25, active | 1, active |
| Notebook only | 1.25, active | disabled |
| Monitor only | disabled | 1, active |
| Restore current configuration | 1.25, active | 1, active |

No separate monitor profiles were implemented. The required configurations are few and fully represented by the menu options.

The implementation is documented in `docs/configuration/hyprland.md` under the Monitor Configuration section.

---

### 4.6 — Core Applications: Terminal, File Manager, Screenshot

* [x] Review terminal emulator configuration (profile, keybindings, theme, fonts)
* [x] Review file manager configuration (views, keybindings, integration, mounting)
* [x] Review screenshot utility configuration (keybindings, capture modes, clipboard integration)
* [x] Validate daily-use workflows for these applications

**Status:** Completed.

The core applications have been reviewed and validated as part of the daily workflow.

**Terminal (Kitty):** The terminal remains with its default configuration. No customization was required because the current setup already satisfies Project Kintsugi's requirements for performance, usability, Wayland integration, and maintainability. The documented shortcut was corrected to `Super + T`.

**File Manager (Dolphin):** Dolphin was configured with proper MIME associations (KWrite for text, Okular for PDFs, Gwenview for images, Ark for archives) and integrated with Kitty for terminal access. The `F4` binding for the embedded terminal was removed, leaving `Shift + F4` and `Alt + Shift + F4` to open Kitty in the current directory.

**Screenshot Utility (Grimblast):** All three bindings (`Print`, `Shift + Print`, `Ctrl + Print`) were verified and remain functional. The implementation from Phase 1 continues to work correctly.

**Multimedia:** `mpv` remains the multimedia player for both video and audio, consistent with the project's lightweight philosophy.

The configurations are documented in:
- `docs/implementation/02-terminal-installation.md`
- `docs/configuration/dolphin.md`
- `docs/implementation/10-screenshot-utility.md`

---

### 4.7 — Screen Locker and Idle

* [x] Review current screen locker behavior and configuration
* [x] Evaluate idle timeout settings and lock triggers
* [x] Assess integration with session management (suspend, logout)
* [x] Validate unlock experience and authentication flow
* [x] Configure lock screen information (time, date, and battery)
* [x] Integrate MPRIS media information and controls
* [x] Validate the final screen locker configuration

**Status:** Completed.

The screen locker was reviewed and refined as a daily-use workflow component.

The existing lock and unlock behavior was validated and preserved. The lock screen was then extended to display the current time, date, and battery status, with battery information provided through UPower and a dedicated script using Nerd Font battery icons.

MPRIS integration was also implemented through `playerctl`. When a compatible media player is active, the lock screen displays the current artist, track title, and playback state, together with clickable Previous, Play/Pause, and Next controls. The multimedia elements are automatically hidden when no media player is active.

The current implementation was validated with `ytm_player` and remains player-agnostic through the MPRIS interface.

The resulting hyprlock configuration and supporting scripts are documented in `docs/configuration/hyprlock.md`.

Idle and DPMS behavior remain separated from the hyprlock presentation layer. Monitor power-management behavior was previously resolved as part of Phase 4.5.

---

### 4.8 — Notifications

* [x] Review the current Mako configuration
* [x] Correct notification timeout behavior
* [x] Review notification urgency handling
* [x] Remove automatic suspension triggered by critical battery level
* [x] Align Mako visual appearance with the Project Kintsugi theme

**Status:** Completed.

The notification system was reviewed and validated as a workflow component.

Mako is correctly integrated as the notification daemon, providing the `org.freedesktop.Notifications` interface over D-Bus. The urgency-based timeout behavior was validated:

| Urgency | Timeout | Behavior |
|---------|---------|----------|
| **Low** | ~3 seconds | Disappears quickly; suitable for non-urgent informational messages. |
| **Normal** | ~5 seconds | Moderate duration; suitable for standard notifications. |
| **Critical** | Persistent | Remains visible until dismissed by the user; suitable for important events. |

Mako's visual appearance was aligned with the Project Kintsugi visual theme.

The notification presentation reuses the existing project palette rather than introducing notification-specific colors:

- **Background:** `#1A1A1A`
- **Primary text:** `#F0F0F0`
- **Primary accent:** `#780606`
- **Critical accent:** `#DA4453`

The notification border uses the same `2px` size and `10px` rounding established for Hyprland window presentation. The notification font uses `JetBrainsMono Nerd Font`, consistent with the primary desktop interface.

Normal notifications use the project accent, while critical notifications use the project's negative semantic color. Low-priority notifications retain the same visual identity and differ primarily through their shorter timeout.

No separate notification theme or additional theming layer was introduced.

Critical battery handling was reviewed and delegated to the native infrastructure (UPower and systemd-logind), avoiding custom notification-based power management scripts.

The distinction between notification **generation** (applications/services) and notification **presentation** (Mako) was clearly established and documented.

The investigation also identified that KDE Discover's `DiscoverNotifier` does not start in Hyprland sessions, which is expected behavior. This is not a limitation of Mako but a separate architectural question regarding system update notifications, which will be addressed in future phases.

The resulting Mako configuration is documented in `docs/configuration/mako.md`.

---

### 4.9 — Desktop Appearance

* [x] Review and refine Hyprland window appearance (gaps, border size, rounding, shadows)
* [x] Evaluate and select a consistent system theme (GTK, Qt, icons, cursors)
* [x] Configure and style Fuzzel to match the system visual theme
* [x] Ensure visual consistency across applications and the desktop
* [x] Select and configure wallpaper management
* [x] Validate the final visual appearance in daily use

**Status:** Completed.

The initial window-appearance review and system theme evaluation have been completed as the first steps of this subphase.

The current Hyprland configuration now uses:

- **Gaps:** `gaps_in = 4` and `gaps_out = 10`, reducing the previously excessive space around and between windows while preserving enough separation for visual clarity.
- **Border size:** `2`, retained as a clear but unobtrusive window boundary.
- **Rounding:** `10`, retained after testing alternative values and considering the desired minimal visual style.
- **Active border:** a single muted dark-red accent (`#780606`) replaces the previous cyan/green gradient.
- **Inactive border:** `rgba(595959aa)`, providing a subdued distinction between focused and unfocused windows.
- **Shadows:** enabled with a small range and moderate render power.
- **Blur:** enabled with a minimal configuration (`size = 3`, `passes = 1`) and low vibrancy.

The appearance was intentionally kept minimal. No additional visual effects or theme layers were introduced during the window-appearance review.

The active border color was selected as the project's primary visual accent and is reused throughout the system theme.

### System Theme

A consistent dark visual theme was selected and applied across the Qt and GTK application layers.

The current visual palette is based on:

- **Primary accent:** `#780606`
- **View background:** `#141618`
- **Alternative background:** `#1d1f22`
- **Window background:** `#202326`
- **Button background:** `#292c30`
- **Primary text:** `#fcfcfc`
- **Inactive text:** `#a1a9b1`
- **Link text:** `#a83232`
- **Visited link text:** `#d06464`
- **Negative:** `#da4453`
- **Neutral:** `#f67400`
- **Positive:** `#27ae60`

Qt applications use the customized Breeze dark color scheme, including the project accent for selection, focus, and hover decorations.

GTK 3 and GTK 4 use `Breeze-Dark` with the same project-oriented color palette and dark-red selection and focus colors.

The selected icon theme is `Breeze Chameleon Dark`.

The cursor theme is `breeze_cursors` with a size of `24`.

The resulting theme configuration is documented in `docs/configuration/themes.md`.

KDE System Settings was also validated from within the Hyprland session. This provides a graphical interface for reviewing and modifying the KDE/Qt color configuration without requiring a Plasma desktop session.

The theme was evaluated across applications including Dolphin, KWrite, Okular, Firefox, and KDE System Settings. The previous cyan selection color was identified as a visual inconsistency and replaced with the project dark-red accent where supported.

The current theme configuration is intentionally based on existing Breeze infrastructure rather than introducing a separate GTK or Qt theming framework.

### Fuzzel

Fuzzel was configured to match the Project Kintsugi visual theme.

The global Fuzzel configuration uses the existing project palette:

- **Background:** `#1A1A1A`
- **Primary text:** `#F0F0F0`
- **Match:** `#9A0A0A`
- **Selection:** `#780606`
- **Selection text:** `#FFFFFF`
- **Border:** `#780606`

The configuration uses `JetBrainsMono Nerd Font`, with a `2px` border and `10px` rounding to maintain consistency with the Hyprland and Mako presentation.

The visual configuration is applied globally to Fuzzel while individual scripts retain responsibility for workflow-specific properties such as width, number of lines, position, margins, and prompts.

This allows the session, monitor, wallpaper, Wi-Fi, Bluetooth, and power-profile menus to share the same visual language without introducing duplicated styling configuration.

The resulting Fuzzel configuration is stored in `~/.config/fuzzel/fuzzel.ini`.

### Waybar

Waybar was configured to match the Project Kintsugi visual theme.

The final Waybar styling uses:

- **Bar background:** transparent
- **Module background:** `rgba(30, 30, 30, 0.90)`
- **Primary text:** `#ffffff`
- **Font:** `JetBrainsMono Nerd Font`, with `Noto Sans` as fallback
- **Module rounding:** `8px`
- **Module spacing:** `2px 1px` margins with `1px 7px` padding
- **Tooltip accent:** `#780606`

The modules intentionally remain borderless to preserve the previously established minimal appearance.

Tooltips use the project dark-red accent as their border, providing visual consistency with the Hyprland active border and Fuzzel selection and border colors without adding borders to the regular Waybar modules.

Battery states retain dedicated semantic colors for charging, warning, and critical conditions.

The resulting Waybar configuration is stored in:

```text
~/.config/waybar/config.jsonc
~/.config/waybar/style.css
```

This completes the visual integration of Waybar with the rest of the desktop environment.

### Wallpaper Management

Wallpaper management has been implemented using `swaybg` as the wallpaper backend and Fuzzel as the interactive selection interface.

The final desktop appearance was validated across the configured Hyprland session, Qt and GTK applications, Fuzzel, Waybar, KDE System Settings, and the configured wallpapers.

The resulting components share the same dark visual foundation and Project Kintsugi dark-red accent while retaining their native toolkit and application behavior.

---

### 4.10 — Keyboard as the Primary Interface

* [x] Review existing keyboard bindings
* [x] Add useful workflow actions
* [x] Evaluate Fuzzel as a command-oriented interaction layer
* [x] Review multimedia bindings
* [x] Review brightness controls
* [x] Review audio controls
* [x] Identify additional frequently used keyboard actions

**Status:** Completed.

This subphase consolidated the keyboard-driven workflow for daily desktop use.

Existing keyboard bindings were reviewed and validated against the actual system configuration. Multimedia controls (`playerctl`), audio controls (`wpctl`), and screen brightness controls (`brightnessctl`) were verified and documented, including specific hardware scancode behavior for the AULA F75 keyboard (`Fn + E` Mac mode requirement).

Fuzzel was confirmed as the unified, command-oriented interaction layer across the session, monitor, wallpaper, and application launchers.

Additional daily workflow bindings were evaluated and implemented:

* `Super + Shift + F`: Toggle fullscreen active window
* `Super + Shift + C`: Force kill active window
* `Super + Tab`: Switch to previously active workspace

All bindings were directly tested and validated within the active Hyprland session.

The resulting configuration and hardware interactions are documented in `docs/configuration/hyprland.md`.

---

### 4.11 — Organization

* [x] Separate the Hyprland Lua configuration into modules
* [x] Organize Hyprland-specific scripts
* [x] Document keyboard bindings
* [x] Review configuration ownership
* [x] Leave the configuration in a maintainable final structure

**Status:** Completed.

The Hyprland configuration was refactored into a clean, modular Lua structure. Responsibilities were split into dedicated modules (`monitors`, `autostart`, `env`, `appearance`, `input`, `rules`, `keybindings`), reducing `hyprland.lua` to a concise entrypoint loader.

Scripts under `~/.config/hypr/scripts/` were reviewed and organized by ownership. Scripts supporting the `hyprlock` screen locker were grouped into a dedicated `hyprlock/` subdirectory, ensuring clear separation between compositor workflows and lock screen presentation tools.

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

This phase focuses on system-level improvements and integration with native Fedora infrastructure, following the same incremental approach used in Phase 4.

---

### 5.1 — System Updates (Investigation)

* [x] Investigate the current Fedora/DNF5 update infrastructure
* [x] Identify available systemd timers and services for update metadata
* [x] Determine the least invasive way to check for available updates
* [x] Document the DNF5 API and command-line options for update detection

**Status:** Completed.

The objective is to understand what Fedora already provides for update detection and how Kintsugi can integrate with it without reinventing the wheel.

Key areas to investigate:
- `dnf5 check-update` and its behavior
- `dnf5-makecache.timer` and other systemd timers
- PackageKit vs. DNF5 native mechanisms
- Offline metadata handling
- Repository cache and network dependency

This investigation will inform the design of the update notification system without assuming a specific implementation yet.

---

### 5.2 — System Updates (Detection and Notification)

* [x] Implement update detection using the selected mechanism
* [x] Integrate detection with a systemd timer for periodic checks
* [x] Generate notifications via Mako when updates are available
* [x] Distinguish between regular updates and security updates

**Status:** Completed.

Once the investigation is complete, this subphase will implement the actual detection and notification of available updates.

The implementation will:
- Check for updates periodically (e.g., daily)
- Use Mako to display notifications when updates are available
- Provide clear information about the number of updates and their severity

The update notification will be a lightweight integration that does not require network access during session startup.

---

### 5.3 — System Updates (Details and Interaction)

* [x] Provide a mechanism to view detailed update information
* [x] Implement interactive controls to view available updates
* [x] Design a simple UX for update management

**Status:** Completed.

This subphase will add the ability to see more details about available updates and interact with the update system.

Potential UX:
```text
Updates available
12 packages, 2 security updates

[ View Details ] [ Ignore ]
```

The details view could show package names, versions, and changelogs.

---

### 5.4 — System Updates (Execution)

* [x] Implement update execution with proper privilege handling
* [x] Handle transaction confirmation and error reporting
* [x] Manage post-update actions (reboot, service restarts)

**Status:** Completed.

This subphase will enable actual package installation from within Kintsugi.

Important considerations:

* `pkexec` or `polkit` for privilege escalation (Resolved via native `sudo` in Kitty)
* DNF5 transaction reporting (Resolved via interactive terminal)
* Handling of errors, dependencies, and conflicts (Delegated to DNF5 interactive prompts)
* Kernel updates and reboot requirements (Delegated to standard terminal output)
* Offline updates vs. online updates

This is the most complex part and was approached by keeping the execution transparent within a terminal emulator.

---

### 5.5 — System Updates (Post-Update and Recovery)

* [x] Handle post-update notifications (success, failure)
* [x] Manage reboot requirements for kernel updates
* [x] Implement rollback or recovery mechanisms if applicable

**Status:** Completed.

This subphase addresses the aftermath of updates. By holding the execution terminal open upon completion, the user is natively informed about the outcome, any necessary service restarts, or kernel reboots required by the system, avoiding unnecessary abstraction layers.

---

### 5.6 — Additional Optimization and Maintenance

* [x] Review installed packages
* [x] Review unnecessary services
* [x] Identify repetitive manual tasks
* [x] Evaluate automation opportunities
* [x] Refactor configuration where justified
* [x] Review configuration ownership and organization

**Status:** Completed.

Additional optimization tasks not covered by the update subphases. Automated post-update cleanup (cache removal, log vacuuming, and flatpak maintenance) has been integrated into the update execution flow. Furthermore, a deep system audit was conducted to disable unnecessary systemd services (telemetry, virtualization agents, unused network managers) and remove obsolete or redundant packages, ensuring a lean and performant base system.

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