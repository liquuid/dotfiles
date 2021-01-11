#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
#run "xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal"
#run "xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off"
xrandr --output DisplayPort-0 --mode 1440x900 --output HDMI-A-0 --primary --mode 2560x1080 --pos 1440x0  --rotate normal
run "nitrogen --restore"
run "nm-applet"
#run "caffeine"
run "xfce4-power-manager"
#run "lxqt-session"
run "blueberry-tray"
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "numlockx on"
run "setxkbmap br abnt2"
#run "volumeicon"
#run "xrandr --output DVI-I-0 --mode 1280x1024 --pos 0x0 --rotate normal --output DVI-I-1 --off --output HDMI-0 --primary --mode 2560x1080 --pos 1280x0 --rotate normal --output DP-0 --off --output DVI-D-0 --mode 1440x900 --pos 3840x0 --rotate normal --output DP-1 --off"
run "rescuetime"
run "xset -dpms"
run "xset s off"
run "transmission-gtk -m"
run "clementine"
run "strawberry"
#run "zeal"
#run "conky -c $HOME/.config/awesome/system-overview"

#run applications from startup
#run "firefox-bin"
#run "atom"
#run "dropbox"
#run "insync start"
#run "spotify"
