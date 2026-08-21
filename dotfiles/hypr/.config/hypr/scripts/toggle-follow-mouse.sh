#!/bin/bash

current=$(hyprctl getoption input:follow_mouse -j | jq -r '.int')

if [ "$current" = "1" ]; then
    hyprctl eval 'hl.config({ input = { follow_mouse = 0 } })'
else
    hyprctl eval 'hl.config({ input = { follow_mouse = 1 } })'
fi
