#!/bin/sh

uv tool list | grep -E '^[a-z]' | cut -d' ' -f1 | while read tool; do
  echo "Upgrading $tool"
  uv tool upgrade "$tool"
  echo
done
