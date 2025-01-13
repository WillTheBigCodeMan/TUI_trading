#!/bin/bash

while :; do
    ydotool key 125:1 3:1 125:0 3:0
    ydotool mousemove --absolute 640 205
    ydotool click C1
    sleep 0.1
    ydotool mousemove 50 100
    sleep 1
    ydotool mousemove 150 400
    ydotool click C0
    sleep 0.1
    ydotool key 29:1 19:1 29:0 19:0 56:1 3:1 56:0 3:0
    ydotool mousemove --absolute 100 100
    ydotool click C0
    ydotool key 29:1 47:1 29:0 47:0
    sleep 4
    ydotool mousemove 500 0
    ydotool click C0
    sleep 4
    ydotool key 56:1 2:1 56:0 2:0
    ydotool key 125:1 2:1 125:0 2:0
    ydotool mousemove --absolute 100 100
    ydotool click C0
    ydotool type "nano stream.har"
    ydotool key 28:1 28:0
    sleep 4
    ydotool key 29:1 42:1 47:1 29:0 42:0 47:0
    sleep 4
    ydotool key 29:1 24:1 29:0 24:0 28:1 28:0
    sleep 4
    ydotool key 29:1 45:1 29:0 45:0
    sleep 4
    ydotool type "./convert.sh"
    ydotool key 28:1 28:0
    sleep 600
done
