# File Manager Installation

## Objective

The objective of this implementation is to establish the standard graphical file manager for the Hyprland session.

The file manager provides a graphical interface for browsing the filesystem, managing files and directories, and opening files with their associated applications.

---

## Background

Previous implementations introduced the following foundational desktop components:

* Hyprland
* Kitty
* Fuzzel

The next logical component is a graphical file manager.

Following the project's evaluation process, Dolphin was selected as the standard file manager because it satisfies the project's architectural and maintenance requirements while remaining available through the official Fedora repositories.

---

## Scope

This implementation is limited to:

* adopting Dolphin as the standard file manager;
* verifying its availability on the system;
* validating its operation within the Hyprland session;
* integrating it with the existing keyboard-driven workflow.

Customization, plugins, service integration, and advanced configuration are outside the scope of this implementation.

---

## Installation

Dolphin was already present on the system as part of the existing KDE Plasma installation, which is intentionally retained as a fallback desktop environment during Phase 1.

As a result, no additional package installation was required for this implementation.

The project formally adopts Dolphin as the standard file manager after completing the evaluation documented in the corresponding selection document.

---

## Validation

The implementation is considered successful when:

* Dolphin is available on the system;
* it launches correctly within the Hyprland session;
* directories can be browsed successfully;
* files can be opened using their associated applications;
* the existing keyboard shortcut (`SUPER + E`) launches Dolphin correctly.

---

## Results

Validation confirmed the following:

* Dolphin was available without additional installation.
* The application launched successfully under Hyprland.
* Files and directories could be accessed normally.
* Existing keyboard integration functioned correctly.
* Dolphin operated as expected within the Wayland session.

---

## Conclusion

The implementation objective was achieved successfully.

Project Kintsugi now includes a documented and validated graphical file manager as part of its modular desktop architecture.

Although no additional package installation was required, the component has been formally evaluated, adopted, and validated following the project's engineering methodology.

---

## Next Step

With the file manager successfully incorporated, Project Kintsugi will continue building the desktop environment by evaluating the next foundational component according to the established workflow.

Each future implementation will follow the same sequence of documentation, technical evaluation, validation, and version control.
