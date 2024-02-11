#!/bin/bash

code $(find ~ -maxdepth 5 -type d -print | fzf)
