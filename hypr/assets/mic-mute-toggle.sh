#!/bin/bash

if pactl get-source-mute @DEFAULT_SOURCE@ | grep yes
then
    pactl set-source-mute @DEFAULT_SOURCE@ no
    pw-play ~/.config/hypr/assets/mic-mute.mp3
else
    pactl set-source-mute @DEFAULT_SOURCE@ yes
    pw-play ~/.config/hypr/assets/mic-unmute.mp3
fi
