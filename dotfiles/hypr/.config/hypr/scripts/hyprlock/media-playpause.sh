#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [[ "$status" == "Playing" ]]; then
    echo "󰏤"
elif [[ "$status" == "Paused" ]]; then
    echo "󰐊"
else
    exit 0          # ← se oculta cuando no hay nada
fi
