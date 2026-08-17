# Clipboard Management Implementation

## Objective

The objective of this implementation was to validate and standardize the Clipboard Management infrastructure used by Project Kintsugi.

The implementation focused on validating the native Wayland clipboard infrastructure and adding lightweight clipboard persistence through cliphist where required by short-lived clipboard producers.

---

## Background

Previous implementations established the graphical session, authentication, networking, audio, desktop portals, power management, XDG infrastructure, and trash management.

Clipboard Management provides another foundational desktop service required for application interoperability.

---

## Scope

This implementation included:

- validation of the Wayland clipboard protocol;
- validation of wl-clipboard utilities;
- validation of clipboard data exchange;
- validation of MIME type support;
- validation of compatibility with the Hyprland session;
- installation and validation of cliphist;
- configuration of clipboard history persistence;
- integration of cliphist with the user-level systemd session.

The implementation did not include:

- clipboard synchronization between devices;
- integration with a full desktop clipboard manager such as Klipper or CopyQ.

---

## Installed Components

No additional components were installed.

The implementation uses the following components:

```text
wl-clipboard
cliphist
```

`wl-clipboard` provides the command-line interface to the Wayland clipboard.

`cliphist` provides clipboard history and persistence through a user-level systemd service.

---

## Integration

The validated architecture is:

```text
Applications
        │
        ▼
Wayland Clipboard Protocol
        │
        ▼
Hyprland
        │
        ▼
Clipboard Selection
        │
        ├── wl-copy
        └── wl-paste
                │
                ▼
             cliphist
                │
                ▼
       Clipboard History Storage
```

The clipboard history watcher runs as a user-level systemd service:

```text
cliphist.service
```

The service executes:

```text
/usr/bin/wl-paste --type text --watch /usr/bin/cliphist store
```

This allows clipboard contents to be retained after the application that produced them exits.

---

## Validation

The implementation was validated through:

The implementation was validated through:

- verification of the installed wl-clipboard package;
- successful execution of wl-copy;
- successful execution of wl-paste;
- successful MIME type enumeration;
- successful installation and execution of cliphist;
- successful startup of `cliphist.service`;
- successful storage of clipboard entries;
- successful inspection through `cliphist list`;
- successful restoration through `cliphist decode`;
- successful integration with the Hyprland session;
- successful preservation of emoji clipboard contents after using KDE Plasma's Emoji Selector.

---

## Results

The resulting implementation provides:

- standardized clipboard operations;
- compatibility with Fedora KDE Plasma;
- compatibility with Wayland;
- compatibility with Hyprland;
- support for multiple MIME types;
- persistent clipboard history;
- preservation of clipboard contents produced by short-lived applications;
- lightweight user-level integration through systemd;
- minimal additional system complexity.

---

## Known Limitations

The current implementation provides clipboard history for text content through `cliphist`.

It does not provide:

- clipboard synchronization between devices;
- a graphical clipboard-history interface;
- full desktop clipboard-manager functionality such as the features provided by Klipper or CopyQ.

These capabilities remain outside the scope of the current implementation.

---

## Conclusion

Clipboard Management has been successfully standardized for Project Kintsugi.

The implementation relies on the native Wayland clipboard infrastructure and wl-clipboard utilities, with cliphist providing lightweight clipboard history and persistence.

The resulting architecture remains compatible with Hyprland and preserves the project's modular design while ensuring that clipboard contents produced by short-lived applications, such as KDE Plasma's Emoji Selector, remain available after the originating application exits.