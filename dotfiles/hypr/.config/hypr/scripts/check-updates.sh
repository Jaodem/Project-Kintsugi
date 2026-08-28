#!/bin/bash
# ~/.config/hypr/scripts/check-updates.sh
# System update detector and executor for Project Kintsugi.
# Target: Fedora 44 (DNF5) & Flatpak.
#
# Detects available updates, sends an interactive notification via Mako,
# and allows reviewing details via Fuzzel. Selecting the install option
# launches Kitty to execute a complete system maintenance routine.

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

# Regex used to count/list only real package lines (avoids headers/noise)
PKG_FILTER='[[:alnum:]_.+-]+\.(x86_64|noarch|i686|aarch64)'

# ---------- Data Gathering ----------
# Refresh user cache quietly to ensure accurate package counts
dnf5 makecache --quiet >/dev/null 2>&1 || true

SEC_UPDATES=$(dnf5 check-upgrade --security --quiet 2>/dev/null \
    | grep -E "$PKG_FILTER" | wc -l)

ALL_DNF_UPDATES=$(dnf5 check-upgrade --quiet 2>/dev/null \
    | grep -E "$PKG_FILTER" | wc -l)

STD_UPDATES=$((ALL_DNF_UPDATES - SEC_UPDATES))
[[ $STD_UPDATES -lt 0 ]] && STD_UPDATES=0

# Strictly count valid application IDs (ignores "Info:" or warnings)
FLATPAK_UPDATES=$(flatpak remote-ls --updates --columns=application 2>/dev/null \
    | grep -E '^[a-zA-Z0-9_.-]+$' | wc -l)

TOTAL_UPDATES=$((ALL_DNF_UPDATES + FLATPAK_UPDATES))

# ---------- Execution ----------
if [ "$TOTAL_UPDATES" -eq 0 ]; then
    exit 0
fi

# Build notification message
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

# Send interactive notification
ACTION=$(notify-send "System Updates" "$MESSAGE" \
    --urgency="$URGENCY" \
    --icon="$ICON" \
    --action="default=View Details" \
    --wait)

# Process user action
if [ "$ACTION" = "default" ]; then

    DETAILS=">>> INSTALL ALL UPDATES <<<\n\n"

    DETAILS+="=== SECURITY ADVISORIES ===\n"
    if [ "$SEC_UPDATES" -gt 0 ]; then
        DETAILS+=$(dnf5 advisory list --security --quiet 2>/dev/null)
    else
        DETAILS+="No pending security patches."
    fi

    DETAILS+="\n\n"
    DETAILS+="=== ALL PENDING PACKAGES ===\n"
    if [ "$ALL_DNF_UPDATES" -gt 0 ]; then
        DETAILS+=$(dnf5 check-upgrade --quiet 2>/dev/null | grep -E "$PKG_FILTER")
    else
        DETAILS+="No pending system packages."
    fi

    DETAILS+="\n\n"
    DETAILS+="=== FLATPAK UPDATES ===\n"
    if [ "$FLATPAK_UPDATES" -gt 0 ]; then
        # Filter details to only show valid app lines
        DETAILS+=$(flatpak remote-ls --updates --columns=application 2>/dev/null | grep -E '^[a-zA-Z0-9_.-]+$')
    else
        DETAILS+="No pending flatpak applications."
    fi

    # Show details in Fuzzel and capture selection
    CHOICE=$(echo -e "$DETAILS" | fuzzel "${FUZZEL_ARGS[@]}")

    # User chose to install everything
    if [ "$CHOICE" = ">>> INSTALL ALL UPDATES <<<" ]; then
        kitty -T "System Updates Execution" -e bash -c "
            echo -e '\e[1;34m=== 1/9: Upgrading DNF5 Packages ===\e[0m'
            # --best and --allowerasing handle strict dependencies smoothly
            sudo dnf5 upgrade --refresh --best --allowerasing -y

            echo -e '\n\e[1;34m=== 2/9: Upgrading Flatpak Apps ===\e[0m'
            flatpak update -y

            echo -e '\n\e[1;33m=== 3/9: Removing unused DNF5 dependencies ===\e[0m'
            sudo dnf5 autoremove -y

            echo -e '\n\e[1;33m=== 4/9: Removing unused Flatpak runtimes ===\e[0m'
            flatpak uninstall --unused -y

            echo -e '\n\e[1;33m=== 5/9: Cleaning DNF5 cache ===\e[0m'
            sudo dnf5 clean all

            echo -e '\n\e[1;33m=== 7/9: Clearing Flatpak temporary files ===\e[0m'
            sudo rm -rf /var/tmp/flatpak-cache-* 2>/dev/null || true

            echo -e '\n\e[1;33m=== 8/9: Clearing thumbnail cache ===\e[0m'
            rm -rf ~/.cache/thumbnails/* 2>/dev/null || true

            echo -e '\n\e[1;33m=== 9/9: Optimizing system logs ===\e[0m'
            sudo journalctl --vacuum-size=100M

            echo -e '\n\e[1;32mSystem update and maintenance completed successfully.\e[0m'
            read -p 'Press Enter to close this window...'
        "
    fi
fi
