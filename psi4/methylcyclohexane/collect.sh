#!/bin/bash

. ./mets.sh

for((ibasis=0;ibasis<${#bases[@]};ibasis++)); do
    basis="${bases[ibasis]}"
    basfname="${basfnames[ibasis]}"

    # Number of basis functions
    if [[ -f ${basfname}_1.out ]]; then
        nnbas=$(grep "Number of basis function:" ${basfname}_1.out|wc -l)
        if((nnbas==2)); then
            # Orbital basis, auxiliary basis
            nbas=$(grep "Number of basis function:" ${basfname}_1.out|head -n 1| awk '{print $NF}')
        elif((nnbas==4)); then
            # small orbital basis, (small) auxiliary basis, orbital basis, auxiliary basis
            nbas=$(grep "Number of basis function:" ${basfname}_1.out|head -n 3|tail -n 1| awk '{print $NF}')
        fi
    else
        nbas=0
    fi

    # Extract conformer energies
    Es=""
    for((iconf=1;iconf<=nconf;iconf++)); do
        logfile="${basfname}_${iconf}.out"
        if [[ -f "$logfile" ]]; then
            E=$(grep "@DF-RKS Final Energy:" "$logfile" | tail -n 1| awk '{print $NF}')
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

    printf "%s\t%4i\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n" "${basis}" $nbas ${dEs[@]}
done

