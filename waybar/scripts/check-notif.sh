#!/bin/sh

status=$(dunstctl is-paused)

if [[ "$status" == "true" ]]; then
	echo ""
else
	echo ""
fi
