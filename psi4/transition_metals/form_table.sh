#!/bin/bash

#for mol in c5h5nino cl3tich3 cro2f2 cro2cl2; do
for mol in cro2f2; do
    echo $mol
    icalc=0
    #for method in lda mlda pbe r2scan; do
    for method in lda pbe r2scan; do
        for basis in STO-3G STO-6G 3-21G 6-31G 6-31Gss def2-SVpPp def2-SVP def2-TZVP def2-QZVP pcseg-{0,1,2,3}; do
            f=${mol}_${basis}_${method}.xyz
            if [[ ! -f $f ]]; then
                continue
            fi
            if((icalc==0)); then
                ./get_geometry.py ${f} | sed "s|${mol}_||g"
            else
                ./get_geometry.py ${f} | tail -n 1  | sed "s|${mol}_||g"
            fi
            let icalc++
        done
    done
    echo ""
done | sed "s|_lda|\tlda|g;s|_pbe|\tpbe|g;s|_r2scan|\tr2scan|g;s|def2-SVpPp|def2-SV(P)|g;s|6-31Gss|6-31G**|g" | awk '{print $2 "\t" $1 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7}'

