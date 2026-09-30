#!/usr/bin/env bash
set -euo pipefail

state_file="${XDG_RUNTIME_DIR:-/tmp}/hypr-display-mode"

notify() {
    noctalia msg notification-show "Display" "$1" >/dev/null 2>&1 || true
}

monitor_json="$(hyprctl monitors all -j 2>/dev/null || true)"
active_json="$(hyprctl monitors -j 2>/dev/null || true)"

if [ -z "$monitor_json" ] || [ -z "$active_json" ]; then
    notify "Could not read Hyprland monitors"
    exit 1
fi

internal="$(
    jq -r '
        .[]
        | select((.name | test("^(eDP|LVDS|DSI)"; "i")) and (.disabled != true))
        | .name
    ' <<<"$monitor_json" | head -n 1
)"

if [ -z "$internal" ]; then
    internal="$(
        jq -r '
            .[]
            | select(.name | test("^(eDP|LVDS|DSI)"; "i"))
            | .name
        ' <<<"$monitor_json" | head -n 1
    )"
fi

external="$(
    jq -r --arg internal "$internal" '
        .[]
        | select(.name != $internal)
        | .name
    ' <<<"$monitor_json" | head -n 1
)"

if [ -z "$external" ]; then
    notify "No external monitor connected"
    exit 0
fi

internal_active="false"
external_active="false"

if jq -e --arg name "$internal" '.[] | select(.name == $name)' <<<"$active_json" >/dev/null; then
    internal_active="true"
fi

if jq -e --arg name "$external" '.[] | select(.name == $name)' <<<"$active_json" >/dev/null; then
    external_active="true"
fi

if [ "$internal_active" = "true" ] && [ "$external_active" = "true" ]; then
    next_mode="external"
elif [ "$external_active" = "true" ]; then
    next_mode="internal"
elif [ "$internal_active" = "true" ]; then
    next_mode="both"
else
    next_mode="$(cat "$state_file" 2>/dev/null || echo both)"
fi

case "$next_mode" in
    external)
        hyprctl keyword monitor "$external,preferred,auto,1" >/dev/null
        hyprctl keyword monitor "$internal,disable" >/dev/null
        notify "External monitor only"
        ;;
    internal)
        hyprctl keyword monitor "$internal,preferred,auto,1" >/dev/null
        hyprctl keyword monitor "$external,disable" >/dev/null
        notify "Laptop screen only"
        ;;
    *)
        hyprctl keyword monitor "$internal,preferred,0x0,1" >/dev/null
        hyprctl keyword monitor "$external,preferred,auto,1" >/dev/null
        notify "Both screens"
        ;;
esac

printf '%s\n' "$next_mode" >"$state_file"
