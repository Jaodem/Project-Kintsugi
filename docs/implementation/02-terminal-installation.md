# Terminal Installation

## Objective

The objective of this implementation is to introduce the project's selected terminal emulator into the Hyprland environment.

At this stage, the goal is not to customize the terminal or establish workflow preferences, but simply to provide a reliable terminal that enables further system configuration and validation.

This implementation represents the first functional desktop component added after the successful installation of Hyprland.

---

## Background

Project Kintsugi previously evaluated the role of terminal emulators and documented the engineering criteria used for their selection.

After comparing available alternatives within the Fedora 44 environment, Kitty was selected as the project's standard terminal emulator due to its maturity, Wayland support, ecosystem integration, and availability through the package sources already adopted by the project.

Installing the terminal is the next logical step because nearly every subsequent desktop component will require a working terminal for configuration and troubleshooting.

---

## Scope

This implementation is intentionally limited.

Its responsibilities are to:

- install Kitty,
- verify that the terminal launches successfully,
- confirm integration with the default Hyprland configuration,
- validate that terminal-based interaction is available inside the compositor.

The implementation explicitly excludes:

- terminal customization,
- font selection,
- color schemes,
- shell customization,
- terminal workflow optimizations.

Those topics belong to future implementation phases.

---

## Implementation

Kitty was installed using the same package source already approved for the Hyprland ecosystem.

The installation avoided introducing unrelated desktop components.

Kitty was initially integrated with the Hyprland environment and subsequently assigned as the project's terminal through the Hyprland Lua configuration.

The current terminal definition is:

```lua
local terminal = "kitty"
```

and Kitty is launched through:

```text
SUPER + T
```

using the corresponding Hyprland binding.

The terminal installation itself did not require a dedicated Kitty configuration file.

No project-specific `kitty.conf` has been introduced.

---

## Validation

The implementation is considered successful when all of the following conditions are satisfied:

- Kitty installs successfully.
- Kitty starts correctly from within KDE Plasma.
- Kitty launches successfully inside Hyprland.
- The configured shortcut (`SUPER + T`) opens Kitty.
- A shell session is usable.
- The terminal can execute basic Linux commands.

Successful validation confirms that Project Kintsugi now has an interactive command-line environment inside Hyprland.

---

## Observations

Although a terminal emulator is a relatively small component, it is one of the most important tools within a minimal desktop environment.

Without a functioning terminal, further desktop integration becomes unnecessarily difficult.

For this reason, Project Kintsugi introduces the terminal before components such as launchers, panels, notifications, or wallpapers.

---

## Current Configuration

Kitty currently runs using its default configuration.

No project-specific `kitty.conf` has been introduced.

An audit of the available Kitty configuration and debugging capabilities was performed after the initial installation. Kitty provides extensive customization options, but no additional configuration was identified as necessary for the current Project Kintsugi workflow.

This is intentional. The current configuration already satisfies the project's requirements for performance, usability, Wayland integration, and maintainability.

Future Kitty customization should therefore be driven by a concrete workflow requirement rather than by the availability of additional configuration options.

---

## Next Step

Once the terminal has been successfully validated, the project will continue evaluating the next fundamental desktop component.

Each additional component will follow the established engineering workflow:

1. Understand the component.
2. Document the architectural decision.
3. Implement incrementally.
4. Validate the implementation.
5. Record the result in version control.

---

## Validation Results

The installation was validated on Fedora 44 KDE Plasma (Wayland) with Hyprland installed from the `lionheartp/Hyprland` COPR repository.

Kitty was installed using:

```bash
sudo dnf install --setopt=install_weak_deps=False kitty
```

The installation introduced only the required Kitty packages and intentionally avoided weak dependencies.

Validation confirmed the following:

- Kitty installed successfully.
- The configured Hyprland keybinding (`SUPER + T`) launched Kitty successfully.
- A shell session was immediately available inside Hyprland.
- Standard Linux commands executed successfully.
- `hyprctl` communicated correctly with the running compositor.
- Both connected monitors were detected correctly.
- Graphical applications launched successfully from the terminal.
- `xdg-open` correctly opened the default web browser.
- The terminal integrated correctly into the Hyprland session.

The terminal installation achieved its intended objective without requiring a project-specific Kitty configuration file. Subsequent Hyprland workflow configuration assigned Kitty to the `SUPER + T` terminal binding.

---

## Conclusion

Project Kintsugi now has a functional command-line environment inside Hyprland.

This represents the first desktop component successfully integrated after the compositor itself.

The project can now perform future configuration, validation, and desktop integration directly from within the Hyprland session, reducing dependence on the original KDE Plasma environment while continuing the migration incrementally.