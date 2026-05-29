-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function ()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waypaper --restore")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("/usr/bin/dunst")
	hl.exec_cmd("easyeffects --service-mode --hide-window")
end)
