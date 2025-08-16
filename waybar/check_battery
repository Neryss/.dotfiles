#!/bin/sh

mouse=$(upower --dump | awk '/battery_hidpp_battery_[0-9]+/{f=1} f{if($1 == "percentage:") print $2} /^$/{f=0}' | tr -d "%")
controller=$(upower --dump | awk '/battery_nintendo_switch_controller_battery_[0-9]+/{f=1} f{if($1 == "percentage:") print $2} /^$/{f=0}')
if [ "$controller" == "" ]; then
  controller="Disconnected"
fi

echo "{\"text\": \"$mouse\", \"percentage\": $mouse, \"tooltip\": \"controller: $controller\"}"
