#!/bin/bash

for file in [0-9]*\ *; do
    new_name="${file#* }"
    mv "$file" "$new_name"
done
