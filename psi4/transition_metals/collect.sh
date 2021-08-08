#!/bin/bash

for f in *.out; do
    mol=$(basename $f .out | awk --field-separator=_ '{print $1}')
    out=$(basename $f .out).xyz
    if [[ ! -f $out || $f -nt $out ]]; then
        echo $f
        natoms=$(head -n 1 ${mol}.xyz)
        let ngrep=natoms+1
        echo -e "${natoms}\n$mol" > $out
        grep -A ${ngrep} "Final (previous) structure:" $f | tail -n ${natoms} >> $out
    fi
done
