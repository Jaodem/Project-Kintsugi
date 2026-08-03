# Application Launcher Selection

## Objective

The purpose of this document is to select the application launcher that will become the standard launcher for Project Kintsugi.

Rather than choosing a launcher based on popularity or visual appearance, the decision follows the project's engineering principles and long-term desktop architecture.

The selected launcher should provide a fast, keyboard-oriented workflow while remaining simple, maintainable, and well integrated with Hyprland.

---

## Background

Project Kintsugi has successfully introduced a functional Hyprland session and a terminal emulator.

Applications can already be launched from the terminal, making the desktop technically usable.

However, requiring users to remember executable names or rely exclusively on the terminal is neither practical nor aligned with the project's usability goals.

The next step is therefore to introduce a dedicated application launcher.

---

## Evaluation Criteria

The launcher should satisfy the following requirements:

- Native Wayland support.
- Fast startup and low latency.
- Keyboard-first interaction.
- Simple and predictable configuration.
- Active upstream maintenance.
- High-quality documentation.
- Good compatibility with Fedora.
- Compatibility with Hyprland.
- Long-term maintainability.
- Minimal unnecessary complexity.

The objective is not to maximize features, but to select the launcher that best supports the project's engineering philosophy.

---

## Candidate Launchers

### Walker

Walker is a modern application launcher designed specifically for Wayland environments.

It provides:

- native Wayland support,
- asynchronous search,
- extensibility through modules,
- a clean and modern user interface,
- active development.

Walker focuses on becoming a general command launcher rather than only an application launcher, making it capable of growing alongside the desktop.

---

### Wofi

Wofi is one of the oldest launchers available for wlroots-based compositors.

It is lightweight, mature, and easy to configure.

However, development activity has slowed considerably, and its architecture reflects an earlier generation of Wayland tooling.

Although still functional, it is no longer considered the most forward-looking option.

---

### Fuzzel

Fuzzel is an extremely lightweight launcher inspired by dmenu.

It starts quickly, consumes very few resources, and integrates well with keyboard-driven workflows.

Its intentionally minimal design makes it an excellent choice for users who prioritize simplicity above all else.

---

### Rofi (Wayland variants)

Several Wayland-compatible variants of Rofi exist.

These offer familiarity for long-time X11 users but generally rely on compatibility layers, forks, or partial Wayland implementations.

For a project built around a native Wayland architecture, these solutions are less attractive than applications designed specifically for Wayland.

---

## Fedora Evaluation

Project Kintsugi will verify:

- package availability,
- package source,
- maintenance status,
- installation complexity,
- integration with Fedora 44.

Preference will be given to solutions available through the project's approved package sources.

---

## Decision

Project Kintsugi selects Fuzzel as the standard application launcher.

The selection is based on the engineering principles established by the project rather than on feature count or visual appearance.

Although Walker was initially considered the preferred candidate from an architectural perspective, it was not available through the project's approved package sources on Fedora 44.

Fuzzel satisfies all mandatory requirements while remaining available directly from the official Fedora repositories.

---

## Rationale

Fuzzel was selected because it provides the best overall balance between simplicity, maintainability, Fedora integration, and native Wayland support.

The decision is supported by the following observations:

- available from the official Fedora repositories;
- native Wayland implementation;
- active upstream maintenance;
- very small dependency footprint;
- fast startup and low resource usage;
- straightforward integration with Hyprland;
- aligns with Project Kintsugi's preference for simple, well-understood desktop components.

Walker remains architecturally attractive, but introducing an additional package source solely to obtain the launcher would unnecessarily increase long-term maintenance.

Wofi remains a documented alternative but offers no significant advantage over Fuzzel for the project's current objectives.

---

## Trade-offs

Every launcher represents a balance between:

- functionality,
- simplicity,
- configurability,
- maintenance,
- ecosystem maturity.

Project Kintsugi documents these trade-offs explicitly rather than assuming one launcher is objectively superior.

---

## Future Review

The launcher selection may be revisited if:

- Fedora packaging changes significantly,
- upstream maintenance changes,
- another launcher provides a substantially better engineering balance,
- or the project's desktop architecture evolves in a way that changes the original requirements.

Until then, the selected launcher will remain the standard launcher for Project Kintsugi.

---

## Conclusion

The application launcher is one of the final foundational desktop components required before constructing the higher-level user experience.

Selecting the launcher carefully ensures that future desktop development builds upon a stable, maintainable, and well-understood foundation.

---

## Validation on Fedora 44

The candidate launchers were evaluated against the package sources available on Fedora 44.

### Walker

Walker was initially considered the preferred candidate because of its modern design, Wayland-native implementation, and active development.

However, no package was available in the Fedora 44 official repositories or in the currently enabled Hyprland COPR repository.

As a consequence, Walker was not selected.

---

### Wofi

Wofi is available from the official Fedora repositories.

It is lightweight, Wayland-native, and widely used by wlroots-based compositors.

It remains a valid alternative.

---

### Fuzzel

Fuzzel is available from the official Fedora repositories.

It is a Wayland-native launcher with a small dependency footprint and an actively maintained upstream project.

Because it satisfies the project's engineering principles while remaining available through the official Fedora repositories, Project Kintsugi selects Fuzzel as its application launcher.

---

## Implementation Outcome

Fuzzel was installed successfully from the Fedora official repositories.

The launcher integrates correctly with Hyprland and was configured as the default launcher using the `SUPER + D` keybinding.

Validation confirmed:

- Fuzzel launches correctly.
- Desktop applications can be started.
- Keyboard navigation functions correctly.
- Integration with the Hyprland session is successful.