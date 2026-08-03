# Application Launcher

## Introduction

An application launcher is the component responsible for discovering and starting applications within a desktop environment.

Although launching applications appears to be a simple task, it represents an important interaction between the user and the operating system.

In traditional desktop environments, the launcher is typically integrated into the desktop shell.

In a compositing window manager such as Hyprland, the launcher becomes an independent component that must be selected, configured, and maintained separately.

Understanding this distinction is essential for building a modular desktop.

---

## Why This Component Matters

A graphical desktop is only useful if users can efficiently access the applications installed on the system.

Without an application launcher, users would need to:

- start every graphical application from a terminal,
- memorize executable names,
- or create manual keyboard shortcuts for each application.

While these approaches are technically valid, they do not scale well for daily use.

An application launcher provides a fast, searchable interface for discovering and starting applications while keeping the desktop uncluttered.

---

## Responsibilities

An application launcher is responsible for:

- discovering installed desktop applications,
- presenting them to the user,
- providing fast search capabilities,
- launching the selected application,
- integrating naturally with keyboard-driven workflows.

Its responsibility ends once the application has been launched.

Window management, notifications, desktop panels, and workspace organization remain the responsibility of other desktop components.

---

## Relationship with Hyprland

Hyprland intentionally does not include an application launcher.

This reflects its philosophy of remaining a compositor rather than a complete desktop environment.

Instead, users are free to select the launcher that best fits their workflow.

This modular design allows Project Kintsugi to evaluate launchers independently according to its engineering principles.

---

## Design Considerations

When selecting an application launcher, Project Kintsugi considers more than visual appearance.

Important characteristics include:

- native Wayland support,
- responsiveness,
- keyboard-first interaction,
- active maintenance,
- documentation quality,
- ease of configuration,
- compatibility with the Fedora ecosystem,
- long-term maintainability.

The preferred launcher should complement the project's philosophy rather than simply provide additional features.

---

## Separation of Concerns

An application launcher is not:

- a desktop shell,
- a status bar,
- a notification daemon,
- a terminal emulator,
- or a window manager.

Its single responsibility is to provide an efficient mechanism for locating and launching applications.

Maintaining this separation of responsibilities simplifies both configuration and long-term maintenance.

---

## Project Kintsugi Perspective

Project Kintsugi views the application launcher as a fundamental desktop component rather than a cosmetic addition.

Although the desktop is already functional through the terminal, a launcher significantly improves usability while preserving the modular architecture established throughout the project.

For this reason, the launcher will be selected using the same engineering methodology applied to every previous architectural decision.

---

## Next Step

The next document will evaluate the available launcher alternatives for Project Kintsugi.

Rather than selecting a launcher based on popularity, the project will compare the available options against the engineering principles defined throughout Phase 1 before making a documented decision.