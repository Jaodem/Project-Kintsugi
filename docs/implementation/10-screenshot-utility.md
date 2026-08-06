# Screenshot Utility Implementation

## Objective

The objective of this implementation was to integrate a native screenshot workflow into the Hyprland desktop environment.

The implementation provides an efficient mechanism for capturing screenshots, copying them directly to the clipboard, saving them to disk, and integrating with the existing desktop notification system while preserving Project Kintsugi's modular architecture.

---

## Background

Previous implementations established the Wayland desktop infrastructure, including the XDG Desktop Portal, graphical authentication, session management, and screen locking.

While the portal infrastructure enables secure screenshot functionality, it does not provide a user-facing screenshot application or keyboard shortcuts.

This implementation introduces a dedicated screenshot workflow based on the utilities recommended by the Hyprland ecosystem.

---

## Scope

This implementation included:

* installing Grimblast;
* integrating Grimblast with the existing Grim and Slurp utilities;
* configuring keyboard shortcuts within Hyprland;
* enabling clipboard-based screenshots;
* enabling file-based screenshots;
* integrating screenshot notifications through Mako;
* validating all configured screenshot workflows.

The implementation did not include:

* image editing;
* screenshot annotation;
* cloud upload functionality;
* screenshot history management.

---

## Installed Components

The following package was installed:

* grimblast

The existing installation already included:

* grim
* slurp

Grimblast was installed from the approved Hyprland COPR repository using the project's package installation policy.

---

## Configuration

The following keyboard shortcuts were configured:

| Shortcut | Action |
|----------|--------|
| **Print** | Capture a user-selected region and copy it to the clipboard. |
| **Shift + Print** | Capture a user-selected region, save it under `~/Pictures/Screenshots/`, and display a desktop notification. |
| **Ctrl + Print** | Capture the entire desktop and copy it to the clipboard. |

The screenshot directory is created automatically if it does not already exist.

Saved screenshots use timestamp-based filenames to ensure uniqueness.

---

## Integration

The screenshot workflow integrates with multiple desktop components:

* Hyprland provides keyboard shortcut handling.
* Grimblast orchestrates screenshot operations.
* Grim performs image capture.
* Slurp provides interactive region selection.
* wl-clipboard manages clipboard operations.
* Mako displays save notifications.

Each component maintains a single responsibility within the overall workflow.

---

## Validation

The implementation was validated through:

* successful package installation;
* successful dependency verification using `grimblast check`;
* successful region capture;
* successful full-screen capture;
* successful clipboard integration;
* successful paste into external applications;
* successful file creation in `~/Pictures/Screenshots/`;
* successful timestamp-based filename generation;
* successful desktop notifications via Mako;
* successful keyboard shortcut execution within Hyprland.

These validation steps confirmed the correct interaction between Hyprland, Grimblast, Grim, Slurp, wl-clipboard, and Mako.

---

## Results

Observed results include:

* Region screenshots copied directly to the clipboard.
* Full-screen screenshots copied successfully.
* Screenshots saved correctly to the designated directory.
* Automatic timestamped filenames generated correctly.
* Desktop notifications displayed after saving screenshots.
* Keyboard shortcuts operating as expected.
* No manual command execution required during normal use.

---

## Architecture Notes

The resulting screenshot architecture consists of:

* Hyprland providing keyboard shortcut management;
* Grimblast coordinating screenshot workflows;
* Grim performing image capture;
* Slurp providing interactive area selection;
* wl-clipboard managing clipboard operations;
* Mako providing user notifications.

The implementation follows Project Kintsugi's modular design philosophy by assigning a single, clearly defined responsibility to each component.

---

## Conclusion

Screenshot functionality has been successfully integrated into the Hyprland desktop environment.

The resulting workflow provides a lightweight, efficient, and well-integrated solution for capturing, storing, and sharing screenshots while preserving the modular architecture established throughout Project Kintsugi.

The implementation follows upstream recommendations and integrates naturally with the existing Hyprland session.

---

## Next Step

With screenshot functionality completed, Project Kintsugi can continue implementing the remaining desktop infrastructure components required to complete Phase 1, including clipboard management improvements, audio infrastructure, Bluetooth integration, network management, and power management.