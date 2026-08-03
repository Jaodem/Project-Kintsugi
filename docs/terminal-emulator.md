# Terminal Emulator

## Introduction

A terminal emulator provides a graphical interface for interacting with the operating system through a command-line shell.

Although modern desktop environments emphasize graphical applications, the terminal remains one of the most powerful and efficient interfaces available for system administration, software development, automation, and troubleshooting.

For Project Kintsugi, the terminal is not considered a legacy tool but an essential part of the engineering workflow.

---

## Why It Matters

Unlike a traditional desktop environment, Hyprland initially provides only the compositor.

Many common desktop capabilities are added incrementally, making the terminal one of the first practical tools available inside the graphical session.

During the implementation of Project Kintsugi, the terminal serves as the primary interface for:

- configuring the desktop,
- testing configuration changes,
- launching applications,
- inspecting the running environment,
- executing administrative tasks,
- and validating system behavior.

Without a functional terminal, development inside the new desktop session becomes unnecessarily difficult.

---

## Responsibilities

A terminal emulator is responsible for providing a graphical window capable of hosting a shell and command-line applications.

Its responsibilities include:

- rendering text efficiently,
- supporting modern terminal capabilities,
- handling keyboard input correctly,
- integrating with the Wayland session,
- supporting copy and paste operations,
- displaying command-line applications reliably.

The terminal emulator does not provide the shell itself.

Instead, it hosts an existing shell such as Bash, Zsh, or Fish.

---

## Desired Characteristics

Project Kintsugi values tools that are:

- actively maintained,
- compatible with Wayland,
- fast and responsive,
- simple to configure,
- well documented,
- stable for daily use,
- and suitable for long-term maintenance.

Visual effects and extensive customization are considered secondary to reliability and maintainability.

---

## Evaluation Criteria

Several terminal emulators satisfy the technical requirements of a Wayland desktop.

Rather than selecting one based on popularity, Project Kintsugi evaluates candidates according to:

- native Wayland support,
- performance,
- configuration philosophy,
- documentation quality,
- ecosystem maturity,
- long-term maintenance,
- and compatibility with the overall architecture of the desktop.

The selected terminal should complement the project's engineering principles rather than simply follow current trends.

---

## Relationship with Hyprland

The terminal is one of the first applications expected to run inside a newly installed Hyprland session.

While Hyprland manages windows and user interaction, it does not provide command-line access on its own.

A terminal emulator fills this gap and becomes the primary tool for configuring and validating the remaining desktop components during the migration process.

---

## Project Kintsugi Perspective

The choice of a terminal emulator influences the daily workflow of the system.

Because it is one of the most frequently used applications, the decision deserves explicit documentation.

Project Kintsugi therefore evaluates terminal emulators as architectural components rather than interchangeable utilities.

The selected terminal should reinforce the project's goals of simplicity, productivity, maintainability, and incremental system construction.