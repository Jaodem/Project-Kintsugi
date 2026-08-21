#!/bin/bash

set -u

FUZZEL_ARGS=(
    --dmenu
    --width 32
    --lines 4
    --minimal-lines
    --prompt "Monitors › "
)

# ---------- Required commands ----------

for cmd in fuzzel hyprctl; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$cmd" >&2
        exit 1
    fi
done

# ---------- Monitor configurations ----------

apply_monitors() {
    local laptop_scale="$1"
    local laptop_position="$2"
    local laptop_disabled="$3"

    local external_position="$4"
    local external_disabled="$5"

    hyprctl eval "hl.monitor({
        output = \"eDP-1\",
        mode = \"preferred\",
        position = \"$laptop_position\",
        scale = $laptop_scale,
        disabled = $laptop_disabled,
    })"

    hyprctl eval "hl.monitor({
        output = \"HDMI-A-1\",
        mode = \"preferred\",
        position = \"$external_position\",
        scale = 1,
        disabled = $external_disabled,
    })"
}

# ---------- Menu ----------

options=$'Extend — Notebook + monitor\nNotebook only\nMonitor only\nRestore current configuration'

choice="$(printf '%s\n' "$options" | fuzzel "${FUZZEL_ARGS[@]}")"

case "$choice" in
    "Extend — Notebook + monitor")
        apply_monitors 1.25 "0x0" false "1536x0" false
        ;;

    "Notebook only")
        apply_monitors 1.25 "0x0" false "0x0" true
        ;;

    "Monitor only")
        apply_monitors 1 "0x0" true "0x0" false
        ;;

    "Restore current configuration")
        apply_monitors 1.25 "0x0" false "1536x0" false
        ;;

    *)
        exit 0
        ;;
esac
