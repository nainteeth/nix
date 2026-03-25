#!/usr/bin/env bash
ACTIVE=$(hyprctl activeworkspace -j | jq '.id')
mapfile -t LABELS <<< $(hyprctl clients -j | jq -r '.[] | select(.workspace.name == "special:minimized") | "\(.title) [\(.class)]"')
mapfile -t ADDRS  <<< $(hyprctl clients -j | jq -r '.[] | select(.workspace.name == "special:minimized") | .address')
SELECTED=$(printf '%s\n' "${LABELS[@]}" | wofi --dmenu --prompt "Restore")
for i in "${!LABELS[@]}"; do
  [[ "${LABELS[$i]}" == "$SELECTED" ]] && hyprctl dispatch movetoworkspace "${ACTIVE},address:${ADDRS[$i]}" && break
done
