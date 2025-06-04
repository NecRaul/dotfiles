#!/bin/bash

pip list -o --format=json | jq -r ".[].name" | grep -v "^pywal16$" | xargs -n1 pip install -U
