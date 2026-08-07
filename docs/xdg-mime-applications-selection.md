# XDG MIME Applications Selection

## Objective

The purpose of this document is to select the XDG MIME Applications infrastructure for Project Kintsugi.

The selected implementation should integrate naturally with Fedora, remain compatible with Hyprland, and preserve the project's modular architecture.

---

## Background

XDG MIME Applications provides the standard mechanism used by Linux desktop environments to associate content types with applications.

The evaluation focused on identifying:

- the implementation provided by Fedora;
- the configuration mechanism;
- the interaction with desktop entries;
- the compatibility with KDE and Hyprland sessions.

---

## Evaluation Criteria

The selected infrastructure should provide:

- compliance with freedesktop.org specifications;
- compatibility with Fedora KDE Plasma;
- compatibility with Wayland;
- compatibility with Hyprland;
- integration with desktop applications;
- modular architecture;
- active upstream maintenance;
- availability in official Fedora repositories.

---

## Evaluated Components

### xdg-utils

The Fedora-provided `xdg-utils` package provides:

- the `xdg-mime` command;
- standardized MIME association management;
- compatibility with freedesktop.org specifications.

Validation confirmed:

- installed package availability;
- successful MIME queries;
- successful modification of user associations;
- correct resolution of default applications.

---

### mimeapps.list

The XDG MIME Applications specification uses:

```text
~/.config/mimeapps.list
```

for user-specific application associations.

Validation confirmed that user preferences can override system defaults.

---

### Desktop Entries

Desktop Entry files provide the application definitions used by MIME associations.

Validation confirmed the presence of desktop entries for installed applications and correct MIME type declarations.

---

## KDE Integration

Fedora KDE Plasma provides additional MIME integration through KDE-specific configuration.

Validation showed that KDE MIME handling coexists with the underlying XDG infrastructure.

Project Kintsugi adopts the XDG standard as the base mechanism and does not depend on KDE-specific configuration.

---

## Decision

Project Kintsugi adopts the standard XDG MIME Applications infrastructure.

The selected architecture is:

```text
Applications
      │
      ▼
Desktop Entries
      │
      ▼
XDG MIME Applications
      │
      ▼
mimeapps.list
      │
      ▼
Selected Application
```

No additional MIME management tools are required.

Project Kintsugi does not define a mandatory set of default applications.

---

## Trade-offs

Avoiding a predefined application policy preserves user flexibility and reduces unnecessary customization.

The trade-off is that different installations may contain different application preferences depending on user configuration.

This behavior is acceptable because application selection is considered a user preference rather than a system infrastructure responsibility.

---

## Validation

The selected architecture was validated through:

- installed xdg-utils package;
- successful xdg-mime queries;
- successful default application assignment;
- valid user mimeapps.list configuration;
- available desktop entries;
- compatibility with the Hyprland session.

---

## Conclusion

Project Kintsugi standardizes on the Fedora-provided XDG MIME Applications infrastructure.

This approach satisfies the project's architectural goals by preserving standards compliance, application interoperability, and user control.