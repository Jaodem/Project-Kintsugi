#!/bin/bash

# Show memory usage as a percentage.
# Detailed used / total / available memory is available in the tooltip.

read -r mem_used mem_total <<< "$(free -b | awk '/^Mem:/ {print $3, $2}')"

if [ -z "$mem_used" ] || [ -z "$mem_total" ] || [ "$mem_total" -eq 0 ]; then
    printf '%s\n' '{"text":"󰍛 ?%","tooltip":"Memory: unavailable"}'
    exit 0
fi

# Calculate percentage with one decimal for the tooltip.
mem_percent_float=$(awk "BEGIN {printf \"%.1f\", ($mem_used * 100 / $mem_total)}")

# Integer percentage for the main text (rounded down).
mem_percent_int=$(printf "%.0f" "$mem_percent_float")

# Human-readable values for the tooltip.
mem_used_human=$(free -h | awk '/^Mem:/ {print $3}')
mem_total_human=$(free -h | awk '/^Mem:/ {print $2}')
mem_avail_human=$(free -h | awk '/^Mem:/ {print $7}')

# Build tooltip with each item on its own line.
tooltip="Memory usage: ${mem_percent_float}%\nUsed: ${mem_used_human}\nTotal: ${mem_total_human}\nAvailable: ${mem_avail_human}"

printf '{"text":"󰍛 %s%%","tooltip":"%s"}\n' "$mem_percent_int" "$tooltip"
