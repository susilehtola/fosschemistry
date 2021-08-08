#!/bin/bash

. ./mets.sh

for((ibasis=0;ibasis<${#bases[@]};ibasis++)); do
    basis=${bases[ibasis]}
    basfname=${basfnames[ibasis]}
    for((iconf=1;iconf<=nconf;iconf++)); do
        run="${basfname}_${iconf}"

        # Generate input
        cat > ${run}.in <<EOF
# PBE0/${basis} calculation on methylcyclohexane conformer #${iconf} 

memory 4 gb

molecule {
EOF
        cat geomopt/conformer${iconf}.xyz | awk '{if(NR>2) {print $0}}' >> ${run}.in
        cat >> ${run}.in <<EOF
}

EOF
        # Use basis guess for def2-TZVP and def2-QZVP to speed up calculation
        if [[ "$basis" == "def2-TZVP" || "${basis}" == "def2-QZVP" ]]; then
        cat >> ${run}.in <<EOF
# It is beneficial to initialize larger-basis calculations with
# a small reasonable basis; use def2-SV(P) for this purpose
set basis_guess def2-SV(P)
EOF
        fi
        cat >> ${run}.in <<EOF
set basis ${basis}
energy('pbe0')
EOF

        # Run calculation
        if [[ ! -f ${run}.out ]]; then
            echo ${run}
            psi4 -n 4 ${run}.in
        fi
    done
done
