#!/bin/sh
echo -ne '\033c\033]0;La plaza\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/laplaza.x86_64" "$@"
