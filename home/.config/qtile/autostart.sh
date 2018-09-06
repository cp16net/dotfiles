#!/bin/bash

#exec xrandr --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-5 --off --output DP-4 --off --output DP-3 --primary --mode 3840x2160 --pos 1920x0 --rotate normal --output DP-2 --off --output DP-1 --off --output DP-0 --off &
exec /usr/bin/compton -b &
exec /usr/bin/gnome-keyring-daemon --start &
exec /home/craig/bin/synergys &
exec feh --bg-scale ~/.config/qtile/background.jpg &
