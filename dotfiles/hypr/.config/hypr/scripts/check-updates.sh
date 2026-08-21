#!/bin/bash
# ~/.config/hypr/scripts/check-updates.sh
# Detects system updates offline and sends an interactive notification via Mako.
# Left-clicking opens Fuzzel. Selecting "INSTALL ALL UPDATES" launches Kitty with cleanup routines.

# ---------- Configuration ----------

FUZZEL_ARGS=(
    --dmenu
    --anchor top-right
    --x-margin 12
    --y-margin 0
    --width 60
    --lines 20
    --minimal-lines
    --prompt "Updates > "
)

# ---------- Data Gathering ----------

SEC_UPDATES=$(dnf5 check-upgrade --security -C --quiet | grep -E '\.(x86_64|noarch|i686|aarch64)' | wc -l)
ALL_DNF_UPDATES=$(dnf5 check-upgrade -C --quiet | grep -E '\.(x86_64|noarch|i686|aarch64)' | wc -l)
STD_UPDATES=$((ALL_DNF_UPDATES - SEC_UPDATES))
FLATPAK_UPDATES=$(flatpak remote-ls --updates | wc -l)

TOTAL_UPDATES=$((ALL_DNF_UPDATES + FLATPAK_UPDATES))

# ---------- Execution ----------

if [ "$TOTAL_UPDATES" -eq 0 ]; then
    exit 0
fi

MESSAGE="Available updates:\n"

if [ "$SEC_UPDATES" -gt 0 ]; then
    MESSAGE+="• <b>$SEC_UPDATES security patch(es)</b>\n"
    URGENCY="critical"
    ICON="software-update-urgent"
else
    URGENCY="normal"
    ICON="software-update-available"
fi

if [ "$STD_UPDATES" -gt 0 ]; then
    MESSAGE+="• $STD_UPDATES standard package(s)\n"
fi

if [ "$FLATPAK_UPDATES" -gt 0 ]; then
    MESSAGE+="• $FLATPAK_UPDATES flatpak app(s)"
fi

ACTION=$(notify-send "System Updates" "$MESSAGE" \
    --urgency="$URGENCY" \
    --icon="$ICON" \
    --action="default=View Details" \
    --wait)

if [ "$ACTION" = "default" ]; then
    
    DETAILS=">>> INSTALL ALL UPDATES <<<\n\n"
    
    DETAILS+="=== SECURITY ADVISORIES ===\n"
    if [ "$SEC_UPDATES" -gt 0 ]; then
        DETAILS+=$(dnf5 updateinfo list -C --quiet)
    else
        DETAILS+="No pending security patches."
    fi
    DETAILS+="\n\n"

    DETAILS+="=== ALL PENDING PACKAGES ===\n"
    if [ "$ALL_DNF_UPDATES" -gt 0 ]; then
        DETAILS+=$(dnf5 check-upgrade -C --quiet | awk '/^Upgrades / {next} NF {print}')
    else
        DETAILS+="No pending system packages."
    fi
    DETAILS+="\n\n"

    DETAILS+="=== FLATPAK UPDATES ===\n"
    if [ "$FLATPAK_UPDATES" -gt 0 ]; then
        DETAILS+=$(flatpak remote-ls --updates)
    else
        DETAILS+="No pending flatpak applications."
    fi

    # Pass the text to Fuzzel and capture the user's choice
    CHOICE=$(echo -e "$DETAILS" | fuzzel "${FUZZEL_ARGS[@]}")

    # Process the choice
    if [ "$CHOICE" = ">>> INSTALL ALL UPDATES <<<" ]; then
        kitty -T "System Updates Execution" -e bash -c "
            echo -e '\e[1;34m=== Upgrading DNF5 Packages ===\e[0m'
            sudo dnf5 upgrade
            
            echo -e '\n\e[1;34m=== Upgrading Flatpak Applications ===\e[0m'
            flatpak update
            
            echo -e '\n\e[1;33m=== System Maintenance & Cleanup ===\e[0m'
            echo 'Removing unused dependencies...'
            sudo dnf5 autoremove -y
            
            echo 'Removing unused flatpak runtimes...'
            flatpak uninstall --unused -y
            
            echo 'Cleaning package cache...'
            sudo dnf5 clean packages

            echo 'Clearing temporary files...'
            sudo rm -rf /var/tmp/flatpak-cache-* 2>/dev/null
            rm -rf ~/.cache/thumbnails/*
            
            echo 'Optimizing system logs...'
            sudo journalctl --vacuum-size=100M
            
            echo -e '\n\e[1;32mUpdate and maintenance process finished.\e[0m'
            read -p 'Press Enter to close this window...'
        "
    fi
fi
