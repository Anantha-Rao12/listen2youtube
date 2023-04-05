#!/bin/bash
# Play music from directory
mpv --shuffle "./Youtube-songs" &

# Save the process ID of mpv
mpv_pid=$!

# Wait for user input
while read -n1 input; do
    if [[ $input == "n" ]]; then
        # Send the 'next' command to mpv
        echo "next" | socat - "tcp-connect:localhost:${mpv_pid}"
    elif [[ $input == "N" ]]; then
        # Send the 'prev' command to mpv
        echo "prev" | socat - "tcp-connect:localhost:${mpv_pid}"
    elif [[ $input == " " ]]; then
        # Send the 'toggle-pause' command to mpv
        echo "toggle-pause" | socat - "tcp-connect:localhost:${mpv_pid}"
    fi
done

