#!/bin/bash

# Get CPU usage breakdown (user, system, nice, idle, iowait) from top.
cpu_line=$(top -bn1 | awk -F'[, ]+' '/Cpu\(s\)/ {print $2, $4, $6, $8, $10}')

if [ -z "$cpu_line" ]; then
    printf '%s\n' '{"text":"󰻠 ?%","tooltip":"CPU: unavailable"}'
    exit 0
fi

read -r user sys nice idle iowait <<< "$cpu_line"

# Total usage is user + system (common convention, ignoring nice for the main percentage).
total_usage=$(awk "BEGIN {printf \"%.1f\", $user + $sys}")

# Get current CPU frequency in MHz from the first core.
freq_mhz=$(awk '/MHz/ {print $4; exit}' /proc/cpuinfo 2>/dev/null)

# Build frequency string if available.
if [ -n "$freq_mhz" ]; then
    if [ "$(printf "%.0f" "$freq_mhz")" -ge 1000 ]; then
        freq_ghz=$(awk "BEGIN {printf \"%.2f\", $freq_mhz / 1000}")
        freq_str="${freq_ghz} GHz"
    else
        freq_mhz_int=$(printf "%.0f" "$freq_mhz")
        freq_str="${freq_mhz_int} MHz"
    fi
else
    freq_str=""
fi

# Format breakdown values with one decimal for clarity.
user_f=$(printf "%.1f" "$user")
sys_f=$(printf "%.1f" "$sys")
nice_f=$(printf "%.1f" "$nice")
idle_f=$(printf "%.1f" "$idle")
iowait_f=$(printf "%.1f" "$iowait")
total_f=$(printf "%.1f" "$total_usage")

# Build tooltip with each item on its own line (vertical list).
tooltip="CPU usage: ${total_f}%\nUser: ${user_f}%\nSystem: ${sys_f}%\nNice: ${nice_f}%\nIdle: ${idle_f}%\nIowait: ${iowait_f}%"

# Append frequency if available, separated by a new line.
if [ -n "$freq_str" ]; then
    tooltip="${tooltip}\nFrequency: ${freq_str}"
fi

# Main text shows total usage as an integer (rounding down).
total_int=$(printf "%.0f" "$total_usage")
printf '{"text":"󰻠 %s%%","tooltip":"%s"}\n' "$total_int" "$tooltip"
