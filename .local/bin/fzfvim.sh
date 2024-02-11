#!/bin/bash

nvim $(find ~ -maxdepth 5 -type d -print | fzf)
