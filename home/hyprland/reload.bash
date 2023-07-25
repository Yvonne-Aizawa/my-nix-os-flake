#!/bin/bash

# Sending the signal to stop the process
pkill -2 waybar
pkill -2 dunst

# Waiting for the process to actually stop
while pgrep -u $UID -x waybar >/dev/null; do
    sleep 1;
done
while pgrep -u $UID -x dunst >/dev/null; do
    sleep 1;
done

# Restarting the process
waybar &
dunst &

