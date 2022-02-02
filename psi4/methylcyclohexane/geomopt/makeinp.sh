#!/bin/bash

# Loop over conformers
for((iconf=0;iconf<4;iconf++)); do
    cat > conformer${iconf}.in <<EOF
memory 8 gb

molecule {
0 1
EOF
    # Extract the geometry from the crest output. Number of atoms is
    Nat=$(head -n 1 crest_conformers.xyz|awk '{print $1}')
    # First atom in the wanted conformer is on line
    ibeg=$(echo $iconf|awk -v Nat=$Nat '{print (3+$1*(Nat+2))}')
    # Last atom is on line
    iend=$(echo $ibeg $Nat|awk '{print $1+$2-1}')
    echo "Conformer ${iconf}: lines $ibeg to $iend"
    # Extract the atoms
    awk -v ibeg=$ibeg -v iend=$iend '{if(NR>=ibeg && NR<=iend) {print $0}}' crest_conformers.xyz >> conformer${iconf}.in
    cat >> conformer${iconf}.in <<EOF
}

set basis def2-tzvp
optimize('pbe0')
EOF
done
