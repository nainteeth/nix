#!/usr/bin/env bash

THEME_DIR="/home/nainteeth/.config/waybar/colors"
TARGET="$THEME_DIR/current_theme.css"

if [ ! -d "$THEME_DIR" ]; then
    notify-send "Waybar Error" "Directory $THEME_DIR not found."
    exit 1
fi

SELECTED_THEME=$(ls "$THEME_DIR" | grep ".css" | grep -v "current_theme.css" | wofi --show dmenu --prompt "Select Waybar Theme:")

if [ -n "$SELECTED_THEME" ]; then
    cp "$THEME_DIR/$SELECTED_THEME" "$TARGET"
    
    pkill -SIGUSR2 waybar
    
    notify-send "Waybar" "Theme changed to ${SELECTED_THEME%.css}"
fi
