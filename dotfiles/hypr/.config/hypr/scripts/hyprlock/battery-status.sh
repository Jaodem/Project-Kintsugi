#!/bin/bash

# Buscar automáticamente la batería
battery_path=$(upower -e | grep -i battery | head -n1)

if [[ -z "$battery_path" ]]; then
    echo "󰂎 ?"
    exit 0
fi

info=$(upower -i "$battery_path")

percentage=$(echo "$info" | grep -E "percentage" | awk '{print $2}' | tr -d '%')
state=$(echo "$info" | grep -E "state" | awk '{print $2}')

# Iconos (iguales a Waybar)
icons=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")

if [[ -z "$percentage" ]]; then
    echo "󰂎 ?"
    exit 0
fi

if [[ "$state" == "charging" ]]; then
    echo "󰂄 ${percentage}%"
elif [[ "$state" == "fully-charged" || "$state" == "pending-charge" ]]; then
    echo "󰁹"
else
    index=$((percentage / 10))
    [[ $index -gt 9 ]] && index=9
    [[ $index -lt 0 ]] && index=0
    echo "${icons[$index]} ${percentage}%"
fi
