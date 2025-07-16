#!/bin/bash

ffmpeg -i "$(ls *.mp3 *.flac | head -n 1)" -an -vcodec copy Cover.jpg
