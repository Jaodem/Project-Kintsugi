# File Manager Selection

## Objective

The purpose of this document is to select the file manager that will become the standard graphical file manager for Project Kintsugi.

Rather than selecting an application based on familiarity, desktop environment, or visual appearance, the decision follows the project's engineering principles and long-term desktop architecture.

The selected file manager should integrate naturally with the Hyprland session while remaining maintainable, well documented, and available through the project's approved package sources.

---

## Background

Project Kintsugi has successfully established a functional Hyprland session together with a terminal emulator and an application launcher.

Although all filesystem operations can be performed from the terminal, a graphical file manager provides a convenient interface for browsing directories, managing files, and interacting with removable storage.

The next step is therefore to introduce a dedicated file manager into the desktop architecture.

---

## Evaluation Criteria

The selected file manager should satisfy the following requirements:

* Compatibility with Wayland-based desktop environments.
* Availability through the project's approved package sources.
* Active upstream maintenance.
* High-quality documentation.
* Predictable and stable behavior.
* Compliance with common desktop standards.
* Reasonable dependency footprint.
* Long-term maintainability.
* Straightforward integration with Hyprland.

The objective is not to maximize features, but to select the solution that best aligns with Project Kintsugi's engineering methodology.

---

## Candidate File Managers

### Dolphin

Dolphin is the file manager developed by the KDE community.

It is based on Qt and KDE Frameworks and provides a mature, feature-rich interface with support for tabs, split views, network locations, archive browsing, and removable devices.

Although commonly associated with KDE Plasma, Dolphin can be used independently of the Plasma desktop environment.

---

### Thunar

Thunar is the default file manager of the Xfce desktop environment.

It focuses on simplicity, responsiveness, and a traditional user interface.

Its relatively small dependency footprint makes it attractive for lightweight desktop environments while still providing the functionality expected from a modern graphical file manager.

---

### Nautilus

Nautilus, also known as GNOME Files, is the default file manager of the GNOME desktop environment.

It provides a clean and consistent interface while integrating closely with the GNOME ecosystem.

Its design intentionally favors simplicity over extensive configuration.

---

### PCManFM-Qt

PCManFM-Qt is the file manager of the LXQt desktop environment.

Built using Qt, it provides a lightweight graphical interface while maintaining compatibility with common desktop standards.

It represents a simple alternative for users seeking a minimal Qt-based solution.

---

## Fedora Evaluation

Project Kintsugi will verify:

* package availability;
* package source;
* maintenance status;
* installation complexity;
* compatibility with Fedora 44.

Preference will be given to solutions available through the project's approved package sources.

---

## Decision

Project Kintsugi selects Dolphin as the standard file manager.

The decision is based on the project's engineering principles rather than desktop environment affiliation.

Dolphin satisfies all mandatory evaluation criteria while providing a mature implementation, excellent documentation, active upstream maintenance, and seamless operation within a Wayland-based desktop.

Its reliance on KDE Frameworks is considered an acceptable architectural dependency and does not require the KDE Plasma desktop environment to be installed or running.

---

## Rationale

Dolphin was selected because it provides an appropriate balance between functionality, maintainability, ecosystem maturity, and long-term sustainability.

The decision is supported by the following observations:

* available from the official Fedora repositories;
* actively maintained by the KDE community;
* fully compatible with Wayland-based environments;
* mature and well-documented implementation;
* comprehensive filesystem capabilities;
* predictable long-term maintenance;
* integrates naturally with Project Kintsugi's modular architecture.

Although other candidates satisfy many of the project's requirements, none provided a sufficiently compelling technical advantage to justify replacing Dolphin.

---

## Trade-offs

Every file manager represents a balance between:

* functionality;
* dependency footprint;
* desktop ecosystem integration;
* configuration philosophy;
* long-term maintenance.

Project Kintsugi documents these trade-offs explicitly rather than assuming any solution is objectively superior.

Selecting Dolphin introduces a dependency on KDE Frameworks.

However, this dependency is limited to the application itself and does not require adopting KDE Plasma as the primary desktop environment.

---

## Future Review

The file manager selection may be revisited if:

* Fedora packaging changes significantly;
* upstream maintenance changes;
* another file manager provides a substantially better engineering balance;
* or the project's desktop architecture evolves in a way that changes the original requirements.

Until then, Dolphin will remain the standard graphical file manager for Project Kintsugi.

---

## Validation on Fedora 44

The candidate file managers were evaluated against the package sources available on Fedora 44.

### Dolphin

Dolphin is available from the official Fedora repositories.

It is actively maintained by the KDE community and operates correctly within Wayland sessions independently of KDE Plasma.

---

### Thunar

Thunar is available from the official Fedora repositories.

It remains a lightweight and well-maintained alternative suitable for modular desktop environments.

---

### Nautilus

Nautilus is available from the official Fedora repositories.

It provides excellent integration within the GNOME ecosystem but introduces GNOME-oriented dependencies that offer no architectural advantage for the current project.

---

### PCManFM-Qt

PCManFM-Qt is available from the official Fedora repositories.

It provides a lightweight Qt-based alternative but does not offer sufficient advantages over Dolphin for the objectives of Project Kintsugi.

---

## Conclusion

A graphical file manager is a fundamental desktop component that complements command-line tools without replacing them.

After evaluating the available alternatives, Project Kintsugi adopts Dolphin as its standard file manager due to its mature implementation, active maintenance, availability within the official Fedora repositories, and compatibility with the project's modular desktop architecture.
