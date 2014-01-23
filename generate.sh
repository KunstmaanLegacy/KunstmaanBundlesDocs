#!/bin/bash

for d in $(find __compiled/ -not -name '.*' -not -name "__*" -type d -maxdepth 1)
do
    rm -Rf $d
done


for d in $(find . -not -name '.*' -not -name "__*" -type d -maxdepth 1)
do
    echo "Creating $d"
    mkdir "__compiled/$d"
done

for f in $(find . -name "*.md" -not -name "README.md" -type f)
do
    echo "Converting $f"
    dirn=$(dirname $f)
    output=$(basename $f .md)
    pandoc -s -f markdown -t rst $f -o "__compiled/$dirn/$output.rst"
done

for f in $(find . -name "*.rst.inc" -type f)
do
    echo "Copy $f"
    cp $f __compiled/$f
done
