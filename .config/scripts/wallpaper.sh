echo "wallpaper file path $1"

# set wallpaper
# wal -i $1 --saturate 1.0
wal -i $1

# dwm
cp /home/dennis/.cache/wal/colors-wal-dwm.h /home/dennis/.config/dwm/src/colors-wal-dwm.h
(cd /home/dennis/.config/dwm && sudo make clean install)
# sh /home/dennis/.config/scripts/dwm_launcher.sh
# pkill dwm
