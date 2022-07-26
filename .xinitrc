export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

xrdb -merge ~/.Xresources
xrandr --output eDP-1 --dpi 192

DISPLAY=:0.0
exec openbox-session

