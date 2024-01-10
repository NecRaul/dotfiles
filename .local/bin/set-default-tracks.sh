#!/bin/bash

for file in *.mkv; do
    mkvpropedit "$file" \
        --edit track:v1 --set flag-default=1 --set flag-forced=0 --set language="jpn" \
        --edit track:a1 --set flag-default=1 --set flag-forced=0 --set language="jpn" \
        --edit track:s1 --set flag-default=1 --set flag-forced=0 --set language="eng"
done
