#!/bin/bash

# Wi-Fi menu for NetworkManager + Fuzzel

set -u

FUZZEL_ARGS=(
    --dmenu
    --anchor top-right
    --x-margin 12
    --y-margin 0
    --width 42
    --lines 18
    --minimal-lines
    --prompt "Wi-Fi › "
)

PASSWORD_ARGS=(
    --dmenu
    --password
    --anchor top-right
    --x-margin 12
    --y-margin 0
    --width 36
    --lines 0
    --prompt "Password › "
)

error() {
    notify-send -t 3500 -u critical "Wi-Fi" "$1" 2>/dev/null || true
}

info() {
    notify-send -t 2500 "Wi-Fi" "$1" 2>/dev/null || true
}

# ---------- Required commands ----------

for cmd in nmcli fuzzel notify-send awk sed sort; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$cmd" >&2
        exit 1
    fi
done

# ---------- Wi-Fi state ----------

wifi_state="$(nmcli radio wifi 2>/dev/null || true)"

case "$wifi_state" in
    enabled)
        wifi_enabled=true
        ;;
    disabled)
        wifi_enabled=false
        ;;
    *)
        error "Unable to determine Wi-Fi state"
        exit 1
        ;;
esac

# ---------- Helpers ----------

get_iface() {
    nmcli -t -f DEVICE,TYPE device status 2>/dev/null |
        awk -F: '$2 == "wifi" {print $1; exit}'
}

is_saved() {
    local ssid="$1"

    nmcli -g 802-11-wireless.ssid connection show 2>/dev/null |
        grep -Fxq -- "$ssid"
}

get_networks() {
    local iface="$1"

    nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY device wifi list \
        ifname "$iface" 2>/dev/null |
    awk -F: '
        {
            inuse = $1
            ssid = $2
            signal = $3
            security = $4

            if (ssid == "")
                next

            marker = (inuse == "*") ? "● " : "  "

            printf "%s%s  %3s%%  %s\n",
                marker, ssid, signal, security
        }
    ' |
    sort -k2
}

# ---------- Main menu ----------

show_menu() {
    local options networks iface

    if [ "$wifi_enabled" = true ]; then
        power_item="Power OFF"
        iface="$(get_iface)"

        options="$power_item"

        if [ -n "$iface" ]; then
            networks="$(get_networks "$iface")"

            options+=$'\n'"↻  Rescan"

            if [ -n "$networks" ]; then
                options+=$'\n'"$networks"
            else
                options+=$'\n'"No networks found"
            fi

            options+=$'\n'"────────────────────────"
            options+=$'\n'"Disconnect"
            options+=$'\n'"Network settings"
        else
            options+=$'\n'"────────────────────────"
            options+=$'\n'"No Wi-Fi interface found"
        fi
    else
        power_item="Power ON"

        options="$power_item"
        options+=$'\n'"────────────────────────"
        options+=$'\n'"Wi-Fi is disabled"
    fi

    printf '%s\n' "$options" | fuzzel "${FUZZEL_ARGS[@]}"
}

choice="$(show_menu)"

case "$choice" in
    "")
        exit 0
        ;;

    "Power ON")
        if nmcli radio wifi on >/dev/null 2>&1; then
            info "Wi-Fi enabled"
        else
            error "Unable to enable Wi-Fi"
        fi
        ;;

    "Power OFF")
        if nmcli radio wifi off >/dev/null 2>&1; then
            info "Wi-Fi disabled"
        else
            error "Unable to disable Wi-Fi"
        fi
        ;;

    *"Rescan"*)
        iface="$(get_iface)"

        if [ -z "$iface" ]; then
            error "No Wi-Fi interface found"
            exit 1
        fi

        if nmcli device wifi rescan ifname "$iface" >/dev/null 2>&1; then
            exec "$0"
        else
            error "Scan failed"
        fi
        ;;

    "Disconnect")
        iface="$(get_iface)"

        if [ -z "$iface" ]; then
            error "No Wi-Fi interface found"
            exit 1
        fi

        if nmcli device disconnect "$iface" >/dev/null 2>&1; then
            info "Disconnected"
        else
            error "Failed to disconnect"
        fi
        ;;

    "Network settings")
        if command -v nm-connection-editor >/dev/null 2>&1; then
            nm-connection-editor &
        else
            error "nm-connection-editor not found"
        fi
        ;;

    "No networks found"|"Wi-Fi is disabled"|"No Wi-Fi interface found")
        exit 0
        ;;

    *)
        iface="$(get_iface)"

        if [ -z "$iface" ]; then
            error "No Wi-Fi interface found"
            exit 1
        fi

        # Remove visual marker.
        ssid="$(printf '%s' "$choice" |
            sed -E 's/^[● ]*//; s/[[:space:]]+[0-9]+%[[:space:]]+.*$//')"

        # Remove trailing whitespace.
        ssid="${ssid%"${ssid##*[![:space:]]}"}"

        [ -z "$ssid" ] && exit 0

        if is_saved "$ssid"; then
            if nmcli device wifi connect "$ssid" ifname "$iface" \
                >/dev/null 2>&1; then
                info "Connected to $ssid"
            else
                error "Failed to connect to $ssid"
            fi

            exit 0
        fi

        pass="$(printf '' | fuzzel "${PASSWORD_ARGS[@]}")"

        [ -z "$pass" ] && exit 0

        if nmcli device wifi connect "$ssid" \
            password "$pass" \
            ifname "$iface" \
            >/dev/null 2>&1; then

            info "Connected to $ssid"
        else
            error "Failed to connect to $ssid (wrong password?)"
        fi
        ;;
esac
