# Waybar Configuration

## Objective

The objective of this implementation was to complete and standardize the Waybar configuration used by Project Kintsugi.

The implementation focused on configuring the selected status bar for the Hyprland session, integrating system information, desktop controls, interactive menus, and custom scripts while keeping the configuration compact, reproducible, and independent from the compositor.

---

## Background

Previous documentation established Waybar as the selected status bar for Project Kintsugi and documented its installation.

The current implementation completes the practical configuration of Waybar within the Hyprland session.

The implementation includes both the Waybar configuration and the supporting scripts required for system monitoring, weather information, calendar interaction, network management, Bluetooth management, and power profile selection.

---

## Scope

This implementation included:

* configuration of Waybar as the top status bar;
* configuration of left, center, and right module groups;
* integration with Hyprland workspaces and active window information;
* integration with audio, network, Bluetooth, keyboard layout, battery, clock, and system tray modules;
* implementation of CPU monitoring;
* implementation of memory monitoring;
* implementation of weather information;
* implementation of an interactive calendar popup;
* implementation of a Wi-Fi management menu;
* implementation of a Bluetooth management menu;
* implementation of a power profile menu;
* configuration of Waybar styling;
* validation of the resulting interactive components.

The implementation did not include:

* replacing Waybar with another status bar;
* introducing a separate desktop widget framework;
* implementing application-specific status bar extensions;
* adding unnecessary system-management functionality to the status bar;
* modifying the Hyprland compositor architecture.

---

## Configuration

Waybar is configured as a top-layer status bar:

```text
Layer:     top
Position:  top
```

The configuration is divided into three module groups:
```text
Left:
    Hyprland workspaces

Center:
    Hyprland active window

Right:
    Audio
    Network
    Bluetooth
    Keyboard layout
    CPU
    Memory
    Battery
    Weather
    Clock
    System tray
```

The main Waybar configuration is stored at:

`~/.config/waybar/config.jsonc`

The visual configuration is stored at:

`~/.config/waybar/style.css`

The separation between configuration and styling keeps the module definitions independent from the visual presentation.

---

## Integrated Modules

### Hyprland

The left side of the bar provides workspace information through:

```text
hyprland/workspaces
```

The center provides the active window title through:

```text
hyprland/window
```

The keyboard layout module provides a compact language indicator:

```text
Eng
Lat
```

---

### Audio

Audio management is provided through the Waybar `wireplumber` module.

The module displays the current volume level and uses different icons according to the volume state.

Clicking the module toggles mute for the default audio sink through:

```bash
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
```

The tooltip provides the current audio node and volume information.

---

### Network

Network status is provided through the Waybar `network` module.

The module displays different states for:

* Wi-Fi;
* Ethernet;
* linked interfaces;
* disconnected networking;
* disabled networking.

The Wi-Fi tooltip provides:

```text
SSID
Signal strength
IP address
Gateway
```

Clicking the Wi-Fi module launches the custom Wi-Fi management menu.

Right-clicking opens:

```bash
nm-connection-editor
```

---

### Bluetooth

Bluetooth status is provided through the Waybar `bluetooth` module.

The module distinguishes between:

* Bluetooth disabled;
* Bluetooth enabled;
* connected devices.

Clicking the module launches the custom Bluetooth management menu.

Right-clicking opens:

```bash
blueman-manager
```

---

### Battery

Battery information is provided through the Waybar `battery` module.

The module displays battery state using status-dependent icons and provides additional information through its tooltip.

Warning and critical states are visually distinguished.

Clicking the battery module opens the custom power profile menu.

---

### Clock

The clock displays the current time in a compact 24-hour format:

```text
HH:MM
```

The tooltip provides the current date and seconds.

Clicking the clock launches the custom calendar popup.

---

### System Tray

The system tray is provided through the standard Waybar `tray` module.

The configured icon size and spacing are kept compact to maintain consistency with the rest of the status bar.

---

## Custom System Monitoring

### CPU Monitoring

CPU monitoring is implemented through:
```text
~/.config/waybar/scripts/cpu.sh
```

The script provides a compact CPU usage percentage in the main bar.

The tooltip provides:

* total CPU usage;
* user usage;
* system usage;
* nice usage;
* idle time;
* I/O wait;
* current CPU frequency when available.

The main display is intentionally limited to the total CPU usage percentage to keep the status bar compact.

---

### Memory Monitoring

Memory monitoring is implemented through:
```text
~/.config/waybar/scripts/memory.sh
```

The main display provides memory usage as a percentage.

The tooltip provides:

* memory usage percentage;
* used memory;
* total memory;
* available memory.

This keeps the main status bar compact while retaining detailed information when required.

---

### Weather

Weather information is implemented through:
```text
~/.config/waybar/scripts/weather.sh
```

The script retrieves current weather information from the Open-Meteo API.

The main display provides:

* weather condition icon;
* current temperature.

The tooltip provides:

* location;
* weather condition;
* temperature;
* apparent temperature;
* humidity;
* precipitation;
* wind speed.

Weather information is refreshed periodically rather than continuously to avoid unnecessary network requests.

---

## Interactive Components

### Calendar Popup

The calendar popup is implemented through:
```text
~/.config/waybar/scripts/calendar-popup.py
```

The popup uses GTK and GtkLayerShell to provide a layer-shell window integrated with the Wayland session.

The implementation provides:

* monthly calendar navigation;
* current-day selection;
* month navigation;
* a return-to-today action;
* selected-date display;
* Escape-key dismissal;
* click-outside dismissal;
* toggle behavior when invoked repeatedly.

The popup is intentionally implemented independently from Waybar itself and is launched through the clock module.

---

### Wi-Fi Management

Wi-Fi management is implemented through:
```text
~/.config/waybar/scripts/wifi-menu.sh
```

The script uses NetworkManager through `nmcli` and Fuzzel as the interactive menu.

The implementation provides:

* automatic Wi-Fi interface detection;
* Wi-Fi radio activation;
* available network listing;
* signal strength display;
* security information;
* current-network indication;
* Wi-Fi rescan;
* connection to saved networks;
* password entry for new networks;
* Wi-Fi disconnection;
* access to `nm-connection-editor`;
* error and status notifications.

The menu intentionally avoids additional network-management functionality that is not required for the current desktop workflow.

---

### Bluetooth Management

Bluetooth management is implemented through:
```text
~/.config/waybar/scripts/bluetooth-menu.sh
```

The script uses `bluetoothctl` for Bluetooth management and Fuzzel for interaction.

The implementation provides:

* Bluetooth power control;
* device discovery;
* device scanning;
* connection and disconnection;
* connection state indication;
* access to `blueman-manager`;
* status notifications.

---

### Power Profiles

Power profile selection is implemented through:
```text
~/.config/waybar/scripts/power-menu.sh
```

The script uses `tuned-adm` to display and select the active power profile.

The available profiles are:
```yaml
Power Saver
Balanced
Desktop
```

The currently active profile is indicated in the Fuzzel menu.

The implementation provides a simple interface for changing power profiles without adding a separate power-management application.

---

### Styling

Waybar styling is implemented through:
```text
~/.config/waybar/style.css
```

The visual design uses compact modules with:

* transparent bar background;
* dark translucent module backgrounds;
* rounded corners;
* consistent spacing;
* consistent typography;
* Nerd Font icons;
* state-dependent battery colors.

The styling is intentionally shared across modules rather than introducing individual visual systems for each component.

---

## Script Design

Custom scripts use standard command-line interfaces and return JSON-compatible output where required by Waybar.

The scripts are kept independent from the Waybar configuration and are stored under:
```text
~/.config/waybar/scripts/
```

This separation allows individual scripts to be executed and validated independently from the status bar.

Scripts use English for:

* comments;
* user-facing output;
* notifications;
* tooltips;
* menu labels.

This maintains consistency across the implementation and improves reproducibility.

---

## Validation

The implementation was validated by directly executing the custom scripts and inspecting their output.

The CPU monitoring script was validated to return CPU usage and detailed CPU information.

The memory monitoring script was validated to return percentage-based memory usage and detailed memory information.

The weather script was validated to return current weather information and a detailed tooltip.

The interactive components were tested through their corresponding Waybar actions, including:

* calendar popup;
* Wi-Fi menu;
* Bluetooth menu;
* power profile menu.

The resulting Waybar configuration was also validated through normal interactive use within the Hyprland session.

---

## Results

The resulting status bar provides:

* compact system information;
* desktop state information;
* audio controls;
* network controls;
* Bluetooth controls;
* keyboard layout indication;
* CPU monitoring;
* memory monitoring;
* battery status;
* weather information;
* calendar access;
* power profile selection;
* system tray integration.

The implementation keeps frequently accessed information directly visible while moving detailed information and management operations into tooltips and interactive menus.

Custom functionality is implemented as independent scripts rather than tightly coupling system-management logic to the Waybar configuration.

---

## Reproducibility

The implementation is reproducible through the following configuration and script files:
```text
~/.config/waybar/config.jsonc
~/.config/waybar/style.css
~/.config/waybar/scripts/cpu.sh
~/.config/waybar/scripts/memory.sh
~/.config/waybar/scripts/weather.sh
~/.config/waybar/scripts/calendar-popup.py
~/.config/waybar/scripts/wifi-menu.sh
~/.config/waybar/scripts/bluetooth-menu.sh
~/.config/waybar/scripts/power-menu.sh
```

The configuration relies on existing desktop infrastructure documented elsewhere in Project Kintsugi, including:

* Hyprland;
* NetworkManager;
* WirePlumber;
* BlueZ;
* Fuzzel;
* tuned;
* GTK;
* GtkLayerShell.

The status bar implementation therefore remains a composition layer over existing desktop services rather than becoming an independent system-management layer.

---

## Known Limitations

The Wi-Fi implementation manages networks through NetworkManager and does not attempt to implement every possible NetworkManager operation.

The weather module depends on external Open-Meteo service availability.

The calendar popup provides calendar navigation and date selection but does not implement event management or calendar synchronization.

The Bluetooth menu provides basic device management but does not replace the full functionality of `blueman-manager`.

Power profile availability depends on the profiles provided by the installed tuned configuration.

Future changes to Waybar, Hyprland, NetworkManager, BlueZ, WirePlumber, Fuzzel, GTK, or related desktop components may require re-validation.

---

## Conclusion

The Waybar implementation has been completed and validated for Project Kintsugi.

The resulting configuration provides a compact and functional status bar while keeping system-management operations separated into dedicated scripts.

The implementation preserves the modular architecture established by the project: Waybar provides the presentation and interaction layer, while existing system services remain responsible for networking, Bluetooth, audio, power management, and other system functions.

The configuration and supporting scripts are stored separately from the core system components, allowing the status bar implementation to be reproduced and maintained independently.