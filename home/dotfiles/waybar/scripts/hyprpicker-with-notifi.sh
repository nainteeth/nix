# Script to also send a notification whenever using hyprpicker
#!/usr/bin/env bash

COLOR=$(hyprpicker -a)

if [ -n "COLOR" ]; then
  notify-send "Copied $COLOR to clipboard" -i color-management
fi
