#!/bin/bash

current=$(tuned-adm active | sed 's/Current active profile: //')

options=""
[ "$current" = "powersave" ] && options+="● Power Saver\n" || options+="  Power Saver\n"
[ "$current" = "balanced" ]  && options+="● Balanced\n"    || options+="  Balanced\n"
[ "$current" = "desktop" ]   && options+="● Desktop\n"     || options+="  Desktop\n"

choice=$(printf '%b' "$options" | fuzzel --dmenu \
    --anchor top-right \
    --x-margin 12 \
    --y-margin 0 \
    --width 32 \
    --lines 3 \
    --minimal-lines \
    --prompt "Power profile:")

case "$choice" in
    *"Power Saver"*)
        tuned-adm profile powersave
        ;;
    *"Balanced"*)
        tuned-adm profile balanced
        ;;
    *"Desktop"*)
        tuned-adm profile desktop
        ;;
esac
