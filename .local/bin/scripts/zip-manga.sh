#!/bin/bash

for d in */; do
    d="${d%/}"
    zip -0 -r "${d}.cbz" "./${d}"/*
done
