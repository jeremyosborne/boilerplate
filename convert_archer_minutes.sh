#!/usr/bin/env bash

for f in *.[Mm][Pp]4; do
    ffmpeg -i $f -c:v libx264 -preset slow -crf 23 -c:a copy -threads 0 -pix_fmt yuv420p `stat -f %Sm -t %Y%m%d_%H%M%S $f`.mkv;
done
