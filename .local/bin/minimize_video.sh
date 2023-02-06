#! /bin/bash

OUTPUT="${1/mp4/min.mp4}"
OUTPUT="${OUTPUT/mkv/min.mkv}"

ffmpeg -i $1 "$OUTPUT"
