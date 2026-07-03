# Fedora Baseline Audit

## Operating System

Fedora 44 KDE Plasma.

Wayland session.

Intel Tiger Lake integrated graphics.

---

## Repositories

- Fedora
- Updates
- RPM Fusion Free
- RPM Fusion Nonfree
- Brave
- Docker CE
- Visual Studio Code
- COPR (Yazi)

Observation:

The repository configuration is minimal and well justified.

---

## Installed Software

### Development

- Zed (primary code editor)
- Visual Studio Code (secondary editor)
- Git
- Docker
- DBeaver
- Python development tools

### Browsers

- Brave (primary browser)
- Firefox (secondary browser)

### File Management

- Dolphin (graphical file manager)
- Yazi (terminal file manager)

### Multimedia

- VLC

### Utilities

- Fastfetch
- btop
- htop
- GParted
- KeePassXC

### Notes

The installed software reflects a development-oriented workstation.

Applications that are no longer part of the daily workflow (such as Discord and OBS Studio) were intentionally removed during the audit process.

Several packages remain under evaluation and may be removed in future optimization phases if they no longer provide value.

---

## Services

The system runs a relatively small set of background services.

Core services such as NetworkManager, Firewalld, Bluetooth, Chrony, D-Bus, and PipeWire are expected and justified.

Services identified for future evaluation:

- Docker (installed but not used daily)
- containerd
- Libvirt
- ABRT
- CUPS
- ModemManager

Input Remapper is intentionally enabled because it provides the required keyboard layout for an ANSI mechanical keyboard.

No service has been removed during this audit.

---

## Performance

Boot time:

- Firmware: ~5 s
- Bootloader: ~4 s
- Kernel: ~1 s
- Initrd: ~6 s
- Userspace: ~14 s

Current memory usage is primarily dominated by Brave Browser rather than the desktop environment itself.

No obvious performance issues were identified during the initial audit.

---

## Conclusions

The current Fedora installation is clean and well maintained.

No unnecessary repositories or major configuration issues were identified.

Several services have been marked for future evaluation, but no changes have been made yet.

Project Kintsugi follows the principle of understanding before modifying.

The current system provides a stable foundation for future work.
