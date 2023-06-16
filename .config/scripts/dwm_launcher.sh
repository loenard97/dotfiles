# Credit: https://wiki.archlinux.org/title/dwm

# relaunch DWM if the binary changes, otherwise bail
csum=""
new_csum=$(sha1sum $(which dwm))
while true
do
    dwm 2> ~/.dwm.log
    sleep 0.5
done
