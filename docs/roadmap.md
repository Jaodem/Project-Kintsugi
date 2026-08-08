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

This phase focuses on integration rather than replacing components that are already working.

### Current areas for evaluation

* [ ] Review desktop integration gaps
* [ ] Evaluate Waybar icon and font integration
* [ ] Evaluate graphical network-status integration
* [ ] Evaluate Bluetooth tray integration
* [ ] Validate whether these concerns should remain separate or form a single desktop-integration feature

These items are intentionally subject to investigation before implementation.

A documented limitation or an acceptable existing behavior may be considered complete without introducing additional software or configuration.

**Status:** In progress.

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

**Status:** Pending evaluation.

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

The next stage of Project Kintsugi is not another broad installation phase.

The immediate focus is to evaluate the remaining desktop-integration concerns, determine whether they represent genuine requirements, and implement them only if the investigation provides sufficient justification.

After that, the project can proceed toward workflow improvements, optimization, and reproducibility in a controlled manner.

> The roadmap is a living representation of the project's actual state. It should be updated as decisions are made rather than used as a predetermined list of changes.
