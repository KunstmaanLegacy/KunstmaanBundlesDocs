#!/bin/bash

for d in $(find __compiled/ -not -name '.*' -not -name "__*" -type d -maxdepth 1)
do
    rm -Rf $d
done
rm -Rf __compiled/index.rst


for d in $(find . -name 'chapter-*' -type d )
do
    echo "Creating $d"
    mkdir "__compiled/$d"
done

for f in $(find . -name "*.rst.inc" -type f)
do
    echo "Copy $f"
    cp $f __compiled/$f
done

for f in $(find . -name "*.rst" -type f)
do
    echo "Copy $f"
    cp $f __compiled/$f
done

for f in $(find . -name "*.md" -not -name "README.md" -not -name "index.md" -type f)
do
    echo "Converting $f"
    dirn=$(dirname $f)
    output=$(basename $f .md)
    pandoc -s -f markdown -t rst $f -o "__compiled/$dirn/$output.rst"
done

pandoc -s -f markdown -t rst README.md -o "__compiled/index.rst"
cat index.rst >> __compiled/index.rst
