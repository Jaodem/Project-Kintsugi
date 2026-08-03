# File Manager

## Introduction

A file manager is the desktop component responsible for providing users with a graphical interface to browse, organize, and manage the files and directories stored on a system.

Although every file operation can be performed from a terminal, a graphical file manager offers an intuitive representation of the filesystem and simplifies many common tasks without changing the underlying operating system behavior.

In a modular desktop architecture such as the one developed by Project Kintsugi, the file manager is an independent component that can be evaluated, selected, and maintained separately from the compositor and other desktop services.

---

## Why This Component Matters

The filesystem is one of the fundamental interfaces between users and the operating system.

Documents, downloads, source code, configuration files, removable storage, and network locations are all accessed through the filesystem.

While command-line tools provide complete control over these resources, many workflows benefit from a graphical interface that allows users to inspect, organize, and manipulate files efficiently.

Introducing a dedicated file manager improves usability while preserving the modular design principles established throughout the project.

---

## Responsibilities

A file manager is responsible for:

* browsing the filesystem;
* navigating directories;
* opening files with their associated applications;
* copying, moving, renaming, and deleting files;
* managing removable storage devices;
* providing access to common user locations.

Its responsibility is limited to file management and navigation.

Application launching, window management, notifications, authentication, and desktop configuration remain the responsibility of other desktop components.

---

## Separation of Concerns

A file manager is not:

* a terminal emulator;
* a desktop shell;
* a window manager;
* a status bar;
* a file indexing service;
* a backup solution.

Although some file managers provide additional capabilities such as network browsing, archive handling, or integrated previews, these features remain secondary to their primary responsibility of managing files and directories.

Maintaining this separation of concerns contributes to a modular, maintainable desktop architecture.

---

## Relationship with Hyprland

Hyprland does not include a graphical file manager.

As a Wayland compositor, its responsibility is limited to managing windows, input devices, rendering, and related compositor functionality.

Users are therefore free to select the file manager that best fits their workflow and architectural requirements.

This separation allows Project Kintsugi to evaluate file managers independently from the compositor itself.

---

## Design Considerations

When evaluating a file manager, Project Kintsugi considers technical characteristics rather than visual appearance.

Relevant considerations include:

* compatibility with Wayland-based desktop environments;
* availability through approved Fedora package sources;
* long-term upstream maintenance;
* quality of documentation;
* predictable behavior;
* integration with standard desktop specifications;
* dependency footprint;
* long-term maintainability.

The objective is to select a component that integrates cleanly into the desktop architecture while remaining understandable and sustainable over time.

---

## Project Kintsugi Perspective

Project Kintsugi considers the file manager a foundational desktop component rather than an optional convenience.

Although the operating system remains fully usable through command-line tools, a graphical file manager provides an efficient interface for interacting with the filesystem while preserving the project's modular engineering approach.

As with every architectural decision in Phase 1, the selected file manager will be chosen only after a documented evaluation of the available alternatives.

---

## Next Step

The next document will compare the available file manager alternatives suitable for Project Kintsugi.

Rather than selecting an application based on familiarity or ecosystem preference, the project will evaluate each candidate against the engineering principles established throughout Phase 1 before documenting a final decision.