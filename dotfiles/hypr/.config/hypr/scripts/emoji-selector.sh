#!/bin/bash

plasma-emojier

sleep 0.1

entry=$(cliphist list | head -1 | cut -f1)

if [ -n "$entry" ]; then
    cliphist decode "$entry" | wl-copy
fi
