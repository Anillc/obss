#!/bin/bash
export DISPLAY=:0
Xvfb -screen 0 900x900x24 -ac &
x11vnc -noxrecord -noxfixes -noxdamage -forever -display :0 &
cd /headless-obs
sleep 3
npm start
#bash
