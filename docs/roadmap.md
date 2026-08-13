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

## Phase 4 — Workflow

Improve the environment around the way the system is actually used.

Potential areas include:

* [ ] Keyboard-driven workflow
* [ ] Workspace organization
* [ ] Terminal workflow
* [ ] File-management workflow
* [ ] Development environment

These areas should be evaluated individually rather than implemented merely because they are technically available.

**Status:** In progress.

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