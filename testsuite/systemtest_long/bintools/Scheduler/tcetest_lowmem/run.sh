#!/bin/sh

# clean up possibly left over dir from earlier runs
BASE=$(echo "$1" | xargs realpath -m --relative-to=. |awk -F "/" '{print $1}')
rm -rf "$BASE"

# link test dir in so we can run in parallel
../../data/link-dir.sh ../../tests/$1 $1

scheduler_tester.py -e $1 -vrq -g "-O3 --swfp --lowmem-mode-threshold=1" \
    -a ti64x_subset.adf

rm -rf "$BASE"

# newline to make systemtests.py happy
echo ""
