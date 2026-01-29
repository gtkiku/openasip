#!/bin/sh

for f in $(find "$1" -type f); do
    rel=$2/$(echo "$f" | sed "s|$1||")
    dir=$(dirname "$rel")
    mkdir -p "$dir"
    ln -s $(realpath -m --relative-to="$dir" $f) $rel
done
