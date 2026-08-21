#!/bin/bash

set -u

FUZZEL_ARGS=(
    --dmenu
    --anchor top-right
    --x-margin 12
    --y-margin 0
    --width 42
    --lines 20
    --minimal-lines
    --prompt "Bluetooth > "
)

error() {
    notify-send -t 3500 -u critical "Bluetooth" "$1" 2>/dev/null || true
}

info() {
    notify-send -t 2500 "Bluetooth" "$1" 2>/dev/null || true
}

# ---------- Required commands ----------

for cmd in bluetoothctl fuzzel notify-send awk sed; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$cmd" >&2
        exit 1
    fi
done

# ---------- Bluetooth state ----------

powered="$(bluetoothctl show 2>/dev/null |
    awk -F': ' '/Powered:/ {print $2; exit}')"

case "$powered" in
    yes)
        bluetooth_enabled=true
        ;;
    no)
        bluetooth_enabled=false
        ;;
    *)
        error "Unable to determine Bluetooth state"
        exit 1
        ;;
esac

# ---------- Device list ----------

get_devices() {
    bluetoothctl devices 2>/dev/null |
    while read -r _ mac name; do
        [ -z "${mac:-}" ] && continue

        info_data="$(bluetoothctl info "$mac" 2>/dev/null)"

        connected="$(printf '%s\n' "$info_data" |
            awk -F': ' '/Connected:/ {print $2; exit}')"

        if [ "$connected" = "yes" ]; then
            printf "● %s\t%s\n" "$name" "$mac"
        else
            printf "  %s\t%s\n" "$name" "$mac"
        fi
    done
}

# ---------- Main menu ----------

show_menu() {
    local options devices

    if [ "$bluetooth_enabled" = true ]; then
        power_item="Power OFF"

        devices="$(get_devices)"

        options="$power_item"
        options+=$'\n'"↻  Scan"

        if [ -n "$devices" ]; then
            options+=$'\n'"$devices"
        else
            options+=$'\n'"No Bluetooth devices"
        fi

        options+=$'\n'"────────────────────────"
        options+=$'\n'"Manager"
    else
        power_item="Power ON"

        options="$power_item"
        options+=$'\n'"────────────────────────"
        options+=$'\n'"Bluetooth is disabled"
    fi

    printf '%s\n' "$options" | fuzzel "${FUZZEL_ARGS[@]}"
}

choice="$(show_menu)"

case "$choice" in
    "")
        exit 0
        ;;

    "Power ON")
        if bluetoothctl power on >/dev/null 2>&1; then
            info "Bluetooth enabled"
        else
            error "Unable to enable Bluetooth"
        fi
        ;;

    "Power OFF")
        if bluetoothctl power off >/dev/null 2>&1; then
            info "Bluetooth disabled"
        else
            error "Unable to disable Bluetooth"
        fi
        ;;

    *"Scan"*)
        if ! bluetoothctl power on >/dev/null 2>&1; then
            error "Unable to enable Bluetooth for scanning"
            exit 1
        fi

        bluetoothctl scan on >/dev/null 2>&1 &
        scan_pid=$!

        sleep 5

        kill "$scan_pid" 2>/dev/null || true
        bluetoothctl scan off >/dev/null 2>&1 || true

        exec "$0"
        ;;

    "Manager")
        if command -v blueman-manager >/dev/null 2>&1; then
            blueman-manager &
        else
            error "blueman-manager not found"
        fi
        ;;

    "No Bluetooth devices"|"Bluetooth is disabled")
        exit 0
        ;;

    *)
        mac="$(printf '%s\n' "$choice" |
            awk -F'\t' '{print $2}')"

        name="$(printf '%s\n' "$choice" |
            sed -E 's/^[● ]*//' |
            awk -F'\t' '{print $1}')"

        [ -z "$mac" ] && exit 0

        connected="$(bluetoothctl info "$mac" 2>/dev/null |
            awk -F': ' '/Connected:/ {print $2; exit}')"

        if [ "$connected" = "yes" ]; then
            if bluetoothctl disconnect "$mac" >/dev/null 2>&1; then
                info "Disconnected: $name"
            else
                error "Failed to disconnect: $name"
            fi
        else
            if ! bluetoothctl power on >/dev/null 2>&1; then
                error "Unable to enable Bluetooth"
                exit 1
            fi

            if bluetoothctl connect "$mac" >/dev/null 2>&1; then
                info "Connected: $name"
            else
                error "Failed to connect: $name"
            fi
        fi
        ;;
esac
