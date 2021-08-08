#!/usr/bin/python3

import sys
from math import sqrt, acos, pi

textmode=False

if len(sys.argv) < 2:
    print('Usage: {} molecule(s)'.format(sys.argv[0]))
    sys.exit()

def dot(a, b):
    return sum([a[i]*b[i] for i in range(len(a))])
def length(a):
    return sqrt(dot(a,a))
def dist(a, b):
    ab = [a[i]-b[i] for i in range(len(a))]
    return length(ab)
def ang(a, b):
    return acos(dot(a,b) / (length(a)*length(b)))

for inputfile in sys.argv[1:]:
    with open(inputfile) as infile:
        data=infile.readlines()

        coords = []
        for line in data[2:]:
            x = line.split()
            coords.append([x[0], float(x[1]), float(x[2]), float(x[3])])
        if inputfile.find('c5h5nino') != -1:
            if len(coords) != 13:
                continue
            
            coords_ni = coords[10][1:]
            coords_n  = coords[11][1:]
            coords_o  = coords[12][1:]
            coords_c1 = coords[0][1:]
            coords_c2 = coords[1][1:]
            coords_h1 = coords[5][1:]
            coords_h2 = coords[6][1:]
            
            r_ni_c = dist(coords_ni, coords_c1)
            r_ni_n = dist(coords_ni, coords_n)
            r_n_o  = dist(coords_n, coords_o)
            r_c_c  = dist(coords_c1, coords_c2)
            r_c_h  = dist(coords_c1, coords_h1)

            if textmode:
                print('{:30s} {:10s} {:10s} {:10s} {:10s} {:10s}'.format('', 'r(NiC)', 'r(NiN)', 'r(CC)', 'r(NO)', 'r(CH)'))
                print('{:30s} {:-10.3f} {:-10.3f} {:-10.3f} {:-10.3f} {:-10.3f}'.format(inputfile[:-4], r_ni_c, r_ni_n, r_c_c, r_n_o, r_c_h))
            else:
                print('{:s}\t{:s}\t{:s}\t{:s}\t{:s}\t{:s}'.format('', 'r(NiC)', 'r(NiN)', 'r(CC)', 'r(NO)', 'r(CH)'))
                print('{:s}\t{:.3f}\t{:.3f}\t{:.3f}\t{:.3f}\t{:.3f}'.format(inputfile[:-4], r_ni_c, r_ni_n, r_c_c, r_n_o, r_c_h))

        elif inputfile.find('cl3tich3') != -1:
            if len(coords) != 8:
                continue

            coords_ti = coords[0][1:]
            coords_cl = coords[1][1:]
            coords_c  = coords[3][1:]
            coords_h  = coords[4][1:]

            r_ti_c  = dist(coords_ti, coords_c)
            r_ti_cl = dist(coords_ti, coords_cl)
            r_c_h   = dist(coords_c, coords_h)

            dr_cl_ti = [coords_cl[i]-coords_ti[i] for i in range(3)]
            dr_c_ti = [coords_c[i]-coords_ti[i] for i in range(3)]
            dr_c_h = [coords_c[i]-coords_h[i] for i in range(3)]
            
            ang_cl_ti_c = ang(dr_cl_ti, dr_c_ti)/pi*180
            ang_h_c_ti = ang(dr_c_h, dr_c_ti)/pi*180

            if textmode:
                print('{:30s} {:10s} {:10s} {:10s} {:10s} {:10s}'.format('', 'r(TiC)', 'r(TiCl)', 'r(CH)', 'A(ClTiC)', 'A(HCTi)'))
                print('{:30s} {:-10.3f} {:-10.3f} {:-10.3f} {:-10.2f} {:-10.2f}'.format(inputfile[:-4], r_ti_c, r_ti_cl, r_c_h, ang_cl_ti_c, ang_h_c_ti))
            else:
                print('{:s}\t{:s}\t{:s}\t{:s}\t{:s}\t{:s}'.format('', 'r(TiC)', 'r(TiCl)', 'r(CH)', 'A(ClTiC)', 'A(HCTi)'))
                print('{:s}\t{:.3f}\t{:.3f}\t{:.3f}\t{:.2f}\t{:.2f}'.format(inputfile[:-4], r_ti_c, r_ti_cl, r_c_h, ang_cl_ti_c, ang_h_c_ti))
            
        elif inputfile.find('cro2cl2') != -1:
            if len(coords) != 5:
                continue

            coords_cr = coords[0][1:]
            coords_o1 = coords[1][1:]
            coords_o2 = coords[2][1:]
            coords_cl1 = coords[3][1:]
            coords_cl2 = coords[4][1:]

            r_cr_o = dist(coords_cr, coords_o1)
            r_cr_cl = dist(coords_cr, coords_cl1)

            dr_cr_o1 = [coords_cr[i]-coords_o1[i] for i in range(3)]
            dr_cr_o2 = [coords_cr[i]-coords_o2[i] for i in range(3)]
            dr_cr_cl1 = [coords_cr[i]-coords_cl1[i] for i in range(3)]
            dr_cr_cl2 = [coords_cr[i]-coords_cl2[i] for i in range(3)]
            
            ang_o_cr_o = ang(dr_cr_o1, dr_cr_o2)/pi*180
            ang_cl_cr_cl = ang(dr_cr_cl1, dr_cr_cl2)/pi*180

            if textmode:
                print('{:30s} {:10s} {:10s} {:10s} {:10s}'.format('', 'r(CrO)', 'r(CrCl)', 'A(OCrO)', 'A(ClCrCl)'))
                print('{:30s} {:-10.3f} {:-10.3f} {:-10.2f} {:-10.2f}'.format(inputfile[:-4], r_cr_o, r_cr_cl, ang_o_cr_o, ang_cl_cr_cl))
            else:
                print('{:s}\t{:s}\t{:s}\t{:s}\t{:s}'.format('', 'r(CrO)', 'r(CrCl)', 'A(OCrO)', 'A(ClCrCl)'))
                print('{:s}\t{:.3f}\t{:.3f}\t{:.2f}\t{:.2f}'.format(inputfile[:-4], r_cr_o, r_cr_cl, ang_o_cr_o, ang_cl_cr_cl))

        elif inputfile.find('cro2f2') != -1:
            if len(coords) != 5:
                continue

            coords_cr = coords[0][1:]
            coords_o1 = coords[1][1:]
            coords_o2 = coords[2][1:]
            coords_f1 = coords[3][1:]
            coords_f2 = coords[4][1:]

            r_cr_o = dist(coords_cr, coords_o1)
            r_cr_f = dist(coords_cr, coords_f1)

            dr_cr_o1 = [coords_cr[i]-coords_o1[i] for i in range(3)]
            dr_cr_o2 = [coords_cr[i]-coords_o2[i] for i in range(3)]
            dr_cr_f1 = [coords_cr[i]-coords_f1[i] for i in range(3)]
            dr_cr_f2 = [coords_cr[i]-coords_f2[i] for i in range(3)]
            
            ang_o_cr_o = ang(dr_cr_o1, dr_cr_o2)/pi*180
            ang_f_cr_f = ang(dr_cr_f1, dr_cr_f2)/pi*180

            if textmode:
                print('{:30s} {:10s} {:10s} {:10s} {:10s}'.format('', 'r(CrO)', 'r(CrF)', 'A(OCrO)', 'A(FCrF)'))
                print('{:30s} {:-10.3f} {:-10.3f} {:-10.2f} {:-10.2f}'.format(inputfile[:-4], r_cr_o, r_cr_f, ang_o_cr_o, ang_f_cr_f))
            else:
                print('{:s}\t{:s}\t{:s}\t{:s}\t{:s}'.format('', 'r(CrO)', 'r(CrF)', 'A(OCrO)', 'A(FCrF)'))
                print('{:s}\t{:.3f}\t{:.3f}\t{:.2f}\t{:.2f}'.format(inputfile[:-4], r_cr_o, r_cr_f, ang_o_cr_o, ang_f_cr_f))

        elif inputfile.find('znch32') != -1:
            if len(coords) != 9:
                continue

            coords_zn = coords[0][1:]
            coords_c1 = coords[1][1:]
            coords_h1 = coords[2][1:]
            coords_h2 = coords[3][1:]

            r_zn_c = dist(coords_zn, coords_c1)
            r_c_h  = dist(coords_c1, coords_h1)

            dr_c_h1 = [coords_c1[i]-coords_h1[i] for i in range(3)]
            dr_c_h2 = [coords_c1[i]-coords_h2[i] for i in range(3)]
            
            ang_h_c_h = ang(dr_c_h1, dr_c_h2)/pi*180

            if textmode:
                print('{:30s} {:10s} {:10s} {:10s}'.format('', 'r(ZnC)', 'r(CH)', 'A(HCH)'))
                print('{:30s} {:-10.3f} {:-10.3f} {:-10.2f}'.format(inputfile[:-4], r_zn_c, r_c_h, ang_h_c_h))
            else:
                print('{:s}\t{:s}\t{:s}\t{:s}'.format('', 'r(ZnC)', 'r(CH)', 'A(HCH)'))
                print('{:s}\t{:.3f}\t{:.3f}\t{:.2f}'.format(inputfile[:-4], r_zn_c, r_c_h, ang_h_c_h))

        elif inputfile.find('znch34') != -1:
            if len(coords) != 17:
                continue

            coords_zn = coords[0][1:]
            coords_c1 = coords[1][1:]
            coords_h1 = coords[2][1:]
            coords_h2 = coords[3][1:]

            r_zn_c = dist(coords_zn, coords_c1)
            r_c_h  = dist(coords_c1, coords_h1)

            dr_c_h1 = [coords_c1[i]-coords_h1[i] for i in range(3)]
            dr_c_h2 = [coords_c1[i]-coords_h2[i] for i in range(3)]
            
            ang_h_c_h = ang(dr_c_h1, dr_c_h2)/pi*180

            if textmode:
                print('{:30s} {:10s} {:10s} {:10s}'.format('', 'r(ZnC)', 'r(CH)', 'A(HCH)'))
                print('{:30s} {:-10.3f} {:-10.3f} {:-10.2f}'.format(inputfile[:-4], r_zn_c, r_c_h, ang_h_c_h))
            else:
                print('{:s}\t{:s}\t{:s}\t{:s}'.format('', 'r(ZnC)', 'r(CH)', 'A(HCH)'))
                print('{:s}\t{:.3f}\t{:.3f}\t{:.2f}'.format(inputfile[:-4], r_zn_c, r_c_h, ang_h_c_h))
                
