#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [[ -z "$status" || "$status" == "Stopped" ]]; then
    exit 0
fi

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [[ -z "$title" ]]; then
    exit 0
fi

if [[ -n "$artist" ]]; then
    echo "$artist — $title"
else
    echo "$title"
fi
