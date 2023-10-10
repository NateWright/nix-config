#!/usr/bin/env bash

#initializing wallpaper daemon
swww init &
# setting wallpaper
swww img ~/Pictures/backgrounds/kate-hazen-unleash-your-robot.png

nm-applet --indicator &

dunst &

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
