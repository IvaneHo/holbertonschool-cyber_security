#!/bin/bash
[ "$(sha256sum "$1" 2>/dev/null | cut -d' ' -f1)" = "$2" ] && echo "$1: OK"
