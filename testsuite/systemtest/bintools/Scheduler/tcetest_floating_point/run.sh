#!/bin/sh

# clean up possibly left over dir from earlier runs
BASE=$(echo "$1" | xargs realpath -m --relative-to=. |awk -F "/" '{print $1}')
rm -rf "$BASE"

# link test dir in so we can run in parallel
../../data/link-dir.sh ../tests_fp/$1 $1

scheduler_tester.py -e $1 -vr -g "-O3 -k_Output --swfp" \
    -a ti64x_subset.adf -a minimal_with_io.adf -a 64b.adf

rm -rf "$BASE"

# newline to make systemtests.py happy
echo ""
