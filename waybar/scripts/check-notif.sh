#!/bin/sh

status=$(dunstctl is-paused)

if [[ "$status" == "true" ]]; then
	echo "n: off"
else
	echo "n: on "
fi
