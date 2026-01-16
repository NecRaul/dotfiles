#!/bin/bash

for dir in */; do
    count=$(fd --max-depth 1 --min-depth 1 . "$dir" | wc -l)
    echo "$count - $dir"
done | sort -rn >files-in-subdirs
