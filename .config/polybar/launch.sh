#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
PRIMARY=$(polybar --list-monitors | grep "primary" | cut -d":" -f1)
OTHERS=$(polybar --list-monitors | grep -v "primary" | cut -d":" -f1)

# Launch on primary monitor
MONITOR=$PRIMARY polybar -c ~/.config/polybar/config.ini top &
MONITOR=$PRIMARY polybar -c ~/.config/polybar/config.ini bottom &
sleep 1

# Launch on all other monitors
for m in $OTHERS; do
    MONITOR=$m polybar -c ~/.config/polybar/config.ini top &
    MONITOR=$m polybar -c ~/.config/polybar/config.ini bottom &
done
