#!/bin/bash

POLL_DELAY=3

OLD_DUAL="dummy"

while true; do
    DUAL="-$(cat /sys/class/drm/card0-DP-1/status)-$(cat /sys/class/drm/card0-DP-3/status)-"

    if [ "$OLD_DUAL" != "$DUAL" ]; then
        OLD_DUAL=$DUAL
        NOW="$(date "+%Y-%m-%d %H:%M:%S")"
        if [[ "$DUAL" == *"-connected-"* ]]; then
            echo "$NOW - External monitor connected"
            gsettings set org.gnome.desktop.interface text-scaling-factor 1.25
        else
            echo "$NOW - External monitor disconnected"
            gsettings set org.gnome.desktop.interface text-scaling-factor 1.1
        fi
    fi

    sleep $POLL_DELAY
done

