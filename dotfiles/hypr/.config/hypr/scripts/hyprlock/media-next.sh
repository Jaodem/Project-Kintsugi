#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
    echo "󰒭"
else
    exit 0
fi
