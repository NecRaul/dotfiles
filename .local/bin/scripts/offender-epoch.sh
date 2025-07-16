#!/bin/bash

fd -t f | rg --pcre2 '/\d{13,15}(?=(\.[^/]+$| $|m))' | sort > offender-epoch
