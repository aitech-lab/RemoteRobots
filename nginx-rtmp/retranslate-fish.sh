#!/bin/bash
# ./ffmpeg/ffmpeg -f v4l2 -list_formats all -i /dev/video1
#./ffmpeg/ffmpeg -f v4l2 -framerate 25 -video_size 640x480 -i /dev/video$1 -c:v libx264 -c:a libmp3lame -ar 44100 -ac 1 -f flv rtmp://vs43.ailove.ru/stream/camera
./ffmpeg/ffmpeg \
-re -i "https://live.schou.me/fish.m3u8" \
-c:v libx264 -c:a libmp3lame -ar 44100 -ac 1 -f flv rtmp://localhost/webcam/fish