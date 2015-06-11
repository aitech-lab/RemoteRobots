#!/bin/bash

../ffmpeg/ffmpeg -f v4l2 -list_formats all -i /dev/video$1
v4l2-ctl -d /dev/video$1 --list-framesizes=YUYV
../ffmpeg/ffmpeg \
    -f v4l2 -framerate 25 -pix_fmt yuv420p \
    -video_size 640x480 \
    -i /dev/video$1 -c:v libx264 -an \
    -f flv rtmp://localhost/webcam/video$1

# ../ffmpeg/ffmpeg -f x11grab -s 1280x800 -framerate 15  -i :0.0+1280,0 -c:v libx264 -vf scale=640:-1 -pix_fmt yuv420p -an -f flv rtmp://vs43.ailove.ru/webcam/video1
# ../ffmpeg/ffmpeg \
#     -f x11grab -s 1280x800 -framerate 15  -i :0.0+1280,800 -c:v libx264 \
#     -pix_fmt yuv420p \
#     -vf "drawtext=fontcolor=black: fontsize=24: \
#          fontfile=../ffmpeg/font.ttf: \
#          box=1:boxcolor=white@0.5:x=4:y=4: \
#          timecode='00\\:00\\:00\\;02':rate=30000/1001 \
#         " \
#          -an -f flv rtmp://vs43.ailove.ru/webcam/desktop
#     -vf scale=640:-1 \

# ./ffmpeg/ffmpeg \
# -f v4l2 -framerate 25 -video_size 640x480 -i /dev/video0 \
# -f v4l2 -framerate 25 -video_size 640x480 -i /dev/video1 \
# -filter_complex " 
# nullsrc=size=1280x480 [background]; 
# [0:v] setpts=PTS-STARTPTS, scale=640x480 [left]; 
# [1:v] setpts=PTS-STARTPTS, scale=640x480 [right]; 
# [background][left]       overlay=shortest=1       [background+left];
# [background+left][right] overlay=shortest=1:x=640 [left+right]" \
# -map "[left+right]" -c:v libx264 -c:a libmp3lame -ar 44100 -ac 1 -f flv rtmp://vs43.ailove.ru/stream/camera
# v4l2
