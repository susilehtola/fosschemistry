#!/bin/bash

bases=('STO-3G' 'STO-6G' 'MINAO' 'def2-SV(P)' 'def2-SVP' 'def2-TZVP' 'def2-QZVP')

basfnames=()
for((i=0;i<${#bases[@]};i++)); do
    basfnames[i]=$(echo "${bases[i]}" | sed "s|*|s|g;s|+|p|g;s|(|p|g;s|)|p|g")
done

# Number of conformers
nconf=4
