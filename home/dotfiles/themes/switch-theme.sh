#!/usr/bin/env bash

THEME_DIR="$HOME/.config/themes"
WAYBAR_COLORS="$HOME/.config/waybar/colors"
NVIM_THEME_FILE="$HOME/.config/nvim/current_theme.txt"
NVIM_NAMES="$THEME_DIR/nvim-names.txt"

if [ ! -d "$WAYBAR_COLORS" ]; then
    notify-send "Theme Error" "Waybar colors directory not found."
    exit 1
fi

THEMES=$(ls "$WAYBAR_COLORS" | grep ".css" | grep -v "current_theme.css" | sed 's/.css$//')
SELECTED=$(echo "$THEMES" | wofi --show dmenu --prompt "Select Theme:")

if [ -z "$SELECTED" ]; then
    exit 0
fi

NVIM_THEME=$(grep "^$SELECTED:" "$NVIM_NAMES" | cut -d: -f2)
if [ -z "$NVIM_THEME" ]; then
    NVIM_THEME="$SELECTED"
fi

cp "$WAYBAR_COLORS/$SELECTED.css" "$WAYBAR_COLORS/current_theme.css"

echo "$NVIM_THEME" > "$NVIM_THEME_FILE"

pkill -SIGUSR2 waybar

for sock in /run/user/$(id -u)/nvim.*.0; do
    [ -S "$sock" ] && nvim --server "$sock" --remote-send "<Cmd>lua require('theme-switcher').reload()<CR>" 2>/dev/null
done

notify-send "Theme" "Changed to $SELECTED"
