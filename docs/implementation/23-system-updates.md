# System Updates Implementation

## Objective

The objective of this implementation was to establish an automated, non-blocking system update notification mechanism, paired with an interactive, transparent execution and maintenance workflow for the Project Kintsugi Wayland session.

The solution operates independently of KDE Plasma's PackageKit backend, relying instead on native terminal execution and background caching.

---

## Background

Project Kintsugi requires a lightweight method to handle system updates while maintaining absolute user control over package transactions.

Previous investigation (Phase 5.1) confirmed that Fedora's native `dnf-makecache.timer` handles background repository synchronization effectively. Therefore, detection is performed offline.

Furthermore, standard desktop environments typically abstract update execution through graphical package managers, which obscure transaction details and error reporting. To align with the project's philosophy of transparency, it was determined that the execution must remain within a standard terminal emulator, exposing native `sudo` prompts and DNF5 outputs.

Firmware updates are explicitly excluded from this implementation and remain delegated to KDE Discover.

---

## Scope

This implementation included:

- integration with DNF5 and Flatpak local caches;
- separation of security and standard packages;
- automated update detection via a `systemd --user` timer;
- non-blocking notifications via Mako;
- interactive notification mapping (left-click action);
- detailed package visualization using Fuzzel;
- native execution environment via Kitty;
- interactive execution of `dnf5 upgrade` and `flatpak update`;
- automated post-update maintenance and cleanup.

The implementation explicitly excluded:

- graphical user interfaces for package installation (e.g., Polkit GUI);
- background silent installations;
- firmware (fwupd) integration.

---

## Implementation

The complete update lifecycle is handled by a single shell script (`~/.config/hypr/scripts/check-updates.sh`), scheduled via systemd.

### 1. Detection and Notification

The script queries the local DNF5 cache (`-C`) and Flatpak for pending updates, calculating totals for security patches, standard packages, and applications. 

Execution is scheduled via a systemd timer (`kintsugi-updates.timer`), set to trigger 10 minutes after boot and every 24 hours thereafter.

If updates are found, the script sends a formatted message to Mako using `notify-send`. If security patches are detected, the notification urgency is elevated to `critical`.

### 2. Visual Interaction (Fuzzel)

The script pauses execution (`--wait`) to monitor user interaction with the notification. 

When the user left-clicks the notification, the script intercepts the `default` action and pipes the detailed update list (Security, System, and Flatpak sections) into Fuzzel. Fuzzel displays the list as an interactive, read-only menu anchored to the top-right corner.

### 3. Execution Environment (Kitty)

An explicit execution trigger (`>>> INSTALL ALL UPDATES <<<`) is injected at the top of the Fuzzel menu. If selected, Fuzzel terminates and spawns a floating Kitty terminal window.

The terminal handles the upgrade execution:
1. `sudo dnf5 upgrade` is called natively, utilizing the standard terminal password prompt.
2. `flatpak update` is executed at the user level.

### 4. Automated Maintenance

To fulfill system optimization requirements, routine maintenance commands are appended directly to the execution sequence. Post-update, the system automatically performs:

- `sudo dnf5 autoremove -y`
- `flatpak uninstall --unused -y`
- `sudo dnf5 clean packages` (clearing RPM installers without destroying repository metadata)
- `sudo rm -rf /var/tmp/flatpak-cache-*` and `rm -rf ~/.cache/thumbnails/*` (clearing temporary installation caches and stale image thumbnails)
- `sudo journalctl --vacuum-size=100M`

The terminal pauses upon completion (`read -p`), allowing the user to audit the transaction history before manually closing the window.

---

## Validation

The implementation was validated manually in the live environment:

- The systemd timer (`list-timers`) scheduled the script correctly without impacting initial boot performance.
- Mako displayed the correct update counts and severity indicators.
- Left-clicking the notification successfully launched the Fuzzel details menu.
- Selecting the install trigger successfully spawned Kitty.
- Terminal authentication (`sudo`) functioned natively.
- Package transactions and automated maintenance executed sequentially and successfully.
- The terminal window persisted until explicitly dismissed by the user.

---

## Conclusion

The system updates mechanism is fully implemented.

By combining offline caching, asynchronous Mako notifications, Fuzzel for elegant data visualization, and Kitty for robust transaction handling, Project Kintsugi provides a highly capable update system that respects user control and automates system hygiene.