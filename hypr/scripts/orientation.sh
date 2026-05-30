#!/usr/bin/env bash
set -euo pipefail

MONITOR="${MONITOR:-DSI-1}"
MODE="${MODE:-preferred}"
POS="${POS:-auto}"
SCALE="${SCALE:-1}"

STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr-orientation-state"

ON_TRANSFORM=0
OFF_TRANSFORM=3

mkdir -p "$(dirname "$STATE_FILE")"

get_state() {
    cat "$STATE_FILE" 2>/dev/null || echo "off"
}

apply_transform() {
    local state="$1"
    local transform

    if [[ "$state" == "on" ]]; then
        transform="$ON_TRANSFORM"
    else
        transform="$OFF_TRANSFORM"
    fi

    hyprctl --batch "\
keyword monitor $MONITOR,$MODE,$POS,$SCALE,transform,$transform ; \
keyword input:touchdevice:transform $transform ; \
keyword input:tablet:transform $transform"

    echo "$state" > "$STATE_FILE"
}

case "${1:-toggle}" in
    on)
        apply_transform "on"
        ;;
    off)
        apply_transform "off"
        ;;
    toggle)
        if [[ "$(get_state)" == "on" ]]; then
            apply_transform "off"
        else
            apply_transform "on"
        fi
        ;;
    status)
        get_state
        ;;
    *)
        echo "usage: orientation.sh {on|off|toggle|status}"
        exit 1
        ;;
esac
