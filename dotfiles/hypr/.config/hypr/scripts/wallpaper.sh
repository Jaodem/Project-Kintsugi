#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CONFIG="$HOME/.config/hypr/wallpaper.conf"

[[ -f "$CONFIG" ]] || exit 1

source "$CONFIG"

case "${mode:-}" in
    same)
        [[ -n "${wallpaper:-}" ]] || exit 1

        swaybg \
            -o eDP-1 -i "$WALLPAPER_DIR/$wallpaper" -m fill \
            -o HDMI-A-1 -i "$WALLPAPER_DIR/$wallpaper" -m fill
        ;;

    per-output)
        [[ -n "${eDP_1:-}" ]] || exit 1
        [[ -n "${HDMI_A_1:-}" ]] || exit 1

        swaybg \
            -o eDP-1 -i "$WALLPAPER_DIR/$eDP_1" -m fill \
            -o HDMI-A-1 -i "$WALLPAPER_DIR/$HDMI_A_1" -m fill
        ;;

    *)
        exit 1
        ;;
esac
