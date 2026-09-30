#!/usr/bin/env bash
set -euo pipefail

# Select a Hyprland window, then send its image to the same editor used by
# Noctalia's configured screenshot pipeline.
geometry="$(
    hyprctl clients -j |
        jq -r '.[] | select(.mapped == true and .hidden != true and .size[0] > 0 and .size[1] > 0) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' |
        slurp -r -f '%x,%y %wx%h'
)" || exit 0
[[ -n "$geometry" ]] || exit 0

grim -g "$geometry" - |
    swash --stdin --name "swash-$(date +'%Y-%m-%d_%H:%M:%S').png"
