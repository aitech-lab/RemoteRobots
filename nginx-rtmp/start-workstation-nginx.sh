#!/bin/bash
export PATH=`pwd`/../ffmpeg:$PATH
./nginx-1.9.1/objs/nginx -p `pwd`/ -c `pwd`/workstation.conf
