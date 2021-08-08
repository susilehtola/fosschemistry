funcs=(lda pbe r2scan)
xfuncs=(lda_x gga_x_pbe mgga_x_r2scan)
cfuncs=(lda_c_pw gga_c_pbe mgga_c_r2scan)

#for mol in c5h5nino cl3tich3 cro2f2 cro2cl2; do
for mol in cro2f2; do
    for((ifun=0;ifun<${#funcs[@]};ifun++)); do
        func=${funcs[ifun]}
        xfunc=${xfuncs[ifun]}
        cfunc=${cfuncs[ifun]}
        for basis in STO-3G STO-6G def2-{"SV(P)",SVP,TZVP,QZVP}; do
            basfname=$(echo "$basis" | sed 's|+|p|g;s|*|s|g;s|(|p|g;s|)|p|g')
            cat > "${mol}_${basfname}_${func}.in" <<EOF
memory 8 gb

molecule {
symmetry c1
EOF
            if [[ ! -f ${mol}.xyz ]]; then
                echo ${mol}.xyz not found
                break
            fi
            cat ${mol}.xyz | awk '{if(NR>2 && NF>0) {print $0}}' >> ${mol}_${basfname}_${func}.in
            
            cat >> "${mol}_${basfname}_${func}.in" <<EOF
}

set basis $basis
set geom_maxiter 250

# Use a (75,302) quadrature grid
set dft_radial_points 75
set dft_spherical_points 302

# Very tight geometry optimization
set g_convergence gau_verytight
# Increase allowed number of geometry optimization steps
set geom_maxiter 250

# Use the Hueckel type guess
set guess huckel

my_dft = {
    "name": "my $func",
    "x_functionals": {"$xfunc": {}},
    "c_functionals": {"$cfunc": {}}
}
optimize('scf', dft_functional=my_dft)
EOF

            if [[ ! -f "${mol}_${basfname}_${func}.out" ]]; then
                echo "${mol}_${basfname}_${func}.in"
                psi4 -n 4 "${mol}_${basfname}_${func}.in"
            fi
        done
    done
done
