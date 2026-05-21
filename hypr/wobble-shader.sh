#!/usr/bin/bash

current_shader=$(hyprshade current)

if [[ "$current_shader" == *"simple-wobble"* ]]; then

  hyprshade off

  hyprctl reload

  notify-send 'Simple wobble' 'Disabled'
else
  hyprctl eval 'hl.config({ debug = { damage_tracking = 0 }})'

  hyprshade on simple-wobble

  notify-send 'Simple wobble' 'Activated'
fi
