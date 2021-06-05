#! /bin/bash

ffmpeg -i $1 "${1/mp4/min.mp4}"
