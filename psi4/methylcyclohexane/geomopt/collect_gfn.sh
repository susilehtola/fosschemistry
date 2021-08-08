#!/bin/bash

. ../mets.sh

for gfn in 0 1 2; do
    # Extract conformer energies
    Es=""
    for((iconf=1;iconf<=nconf;iconf++)); do
        logfile="conformer${iconf}_gfn${gfn}.out"
        if [[ -f "$logfile" ]]; then
            E=$(grep "TOTAL ENERGY" "$logfile" | tail -n 1| awk '{print $(NF-2)}')
        else
            E="NaN"
        fi
        Es="$Es $E"
    done
    Es=( $Es )
    
    # Calculate energy differences, now numbering from 0
    dEs=()
    for((iconf=1;iconf<nconf;iconf++)); do
        if [[ ${Es[iconf]} != "NaN" && ${Es[0]} != "NaN" ]]; then
            dEs[iconf]=$(echo ${Es[iconf]} ${Es[0]} | awk '{printf("% .16e",($1-$2)*627.5)}')
        else
            dEs[iconf]="NaN"
        fi
    done

    printf "%s\t%4s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n" "GFN${gfn}-xTB" "" ${dEs[@]}
done

