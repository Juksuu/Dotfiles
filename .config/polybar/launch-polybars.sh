#! /bin/sh
killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

PRIMARY=$(polybar --list-monitors | grep "primary" | cut -d":" -f1)
OTHERS=$(polybar --list-monitors | grep -v "primary" | cut -d":" -f1)

# Launch on primary monitor
MONITOR=$PRIMARY polybar --reload primary &
MONITOR=$PRIMARY polybar --reload tray &
sleep 1

# Launch on all other monitors
for m in $OTHERS; do
 MONITOR=$m polybar --reload secondary &
done
