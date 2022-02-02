#!/bin/bash

for f in *.out; do
    mol=$(basename $f .out)
    x=${mol}.xyz
    if [[ ! -f $x || $f -nt $x ]]; then
        echo $x
        echo -e "21\n$mol" > $x
        grep -A22 "Final (previous) structure:" $f | tail -n 21 >> $x
    fi
done

cat conformer{0,1,2,3}.xyz > conformers.xyz
