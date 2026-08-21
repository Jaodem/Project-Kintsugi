#!/usr/bin/env bash

set -u

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CONFIG="$HOME/.config/hypr/wallpaper.conf"
WALLPAPER_SCRIPT="$HOME/.config/hypr/scripts/wallpaper.sh"

FUZZEL_ARGS=(
    --dmenu
    --width 32
    --lines 5
    --minimal-lines
)

error() {
    notify-send -t 3500 -u critical "Wallpaper" "$1" 2>/dev/null || true
}

# ---------- Required commands ----------

for cmd in fuzzel swaybg find sort notify-send; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$cmd" >&2
        exit 1
    fi
done

# ---------- Wallpaper list ----------

wallpapers() {
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \
        \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) \
        -printf '%f\n' \
        | sort
}

# ---------- Wallpaper selection ----------

choose_wallpaper() {
    local prompt="$1"

    wallpapers \
        | fuzzel "${FUZZEL_ARGS[@]}" --prompt "$prompt › "
}

# ---------- Apply wallpaper ----------

apply_wallpaper() {
    pkill swaybg 2>/dev/null || true

    if ! "$WALLPAPER_SCRIPT"; then
        error "Failed to apply wallpaper"
        exit 1
    fi
}

# ---------- Main menu ----------

choice="$(
    printf '%s\n' \
        'Both monitors' \
        'One image per monitor' \
        | fuzzel "${FUZZEL_ARGS[@]}" --prompt "Wallpaper › "
)"

case "$choice" in
    "Both monitors")
        wallpaper="$(choose_wallpaper "Wallpaper")"

        [ -n "$wallpaper" ] || exit 0

        cat > "$CONFIG" <<EOF
mode=same
wallpaper=$wallpaper
EOF

        apply_wallpaper

        notify-send -t 2500 "Wallpaper" \
            "Applied to both monitors: $wallpaper" \
            2>/dev/null || true
        ;;

    "One image per monitor")
        laptop="$(choose_wallpaper "eDP-1")"

        [ -n "$laptop" ] || exit 0

        desktop="$(choose_wallpaper "HDMI-A-1")"

        [ -n "$desktop" ] || exit 0

        cat > "$CONFIG" <<EOF
mode=per-output
eDP_1=$laptop
HDMI_A_1=$desktop
EOF

        apply_wallpaper

        notify-send -t 2500 "Wallpaper" \
            "eDP-1: $laptop
HDMI-A-1: $desktop" \
            2>/dev/null || true
        ;;

    *)
        exit 0
        ;;
esac
