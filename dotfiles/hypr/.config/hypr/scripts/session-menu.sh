#!/bin/bash

set -u

FUZZEL_ARGS=(
    --dmenu
    --width 32
    --lines 5
    --minimal-lines
    --prompt "Session › "
)

error() {
    notify-send -t 3500 -u critical "Session" "$1" 2>/dev/null || true
}

# ---------- Required commands ----------

for cmd in fuzzel hyprlock loginctl systemctl notify-send; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$cmd" >&2
        exit 1
    fi
done

# ---------- Menu ----------

options=$'Lock\nLogout\nSuspend\nReboot\nShutdown'

choice="$(printf '%s\n' "$options" | fuzzel "${FUZZEL_ARGS[@]}")"

case "$choice" in
    "Lock")
        hyprlock
        ;;

    "Logout")
        if [ -n "${XDG_SESSION_ID:-}" ]; then
            loginctl terminate-session "$XDG_SESSION_ID"
        else
            error "Unable to determine current session"
        fi
        ;;

    "Suspend")
        systemctl suspend
        ;;

    "Reboot")
        systemctl reboot
        ;;

    "Shutdown")
        systemctl poweroff
        ;;

    *)
        exit 0
        ;;
esac
