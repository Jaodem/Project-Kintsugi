#!/bin/bash

status=$(playerctl status 2>/dev/null)

case "$status" in
    Playing)
        echo "󰏤 Playing"
        ;;
    Paused)
        echo "󰐊 Paused"
        ;;
    *)
        exit 0
        ;;
esac
