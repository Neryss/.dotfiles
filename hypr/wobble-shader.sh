#!/usr/bin/bash

current_shader=$(hyprshade current)

if [[ "$current_shader" == *"simple-wobble"* ]]; then

  hyprshade off

  hyprctl reload

  notify-send 'Simple wobble' 'Disabled'
else
  hyprshade on simple-wobble

  hypr_overrides="keyword debug:damage_tracking 0;"

  hyprctl --batch "$hypr_overrides"

  notify-send 'Simple wobble' 'Activated'
fi
