include Makefile.rule

# Run make in all subdirectories and for all PDFs
SUBDIRS := $(wildcard */.)
all: $(SUBDIRS) $(DOCS)

$(SUBDIRS):
	$(MAKE) -C $@
.PHONY: all $(SUBDIRS)	

# Files to include in supporting information
SUPPINFO=README.pdf conda.pdf jmol.pdf nwchem/README.pdf		\
nwchem/cisplatin/cisplatin.in nwchem/cisplatin/cisplatin.out		\
nwchem/cisplatin/cisplatin.molden nwchem/cisplatin/cisplatin-opt.xyz	\
nwchem/transplatin/transplatin.in nwchem/transplatin/transplatin.out	\
nwchem/transplatin/transplatin-opt.xyz psi4/README.pdf $(wildcard	\
psi4/methylcyclohexane/*.in) $(wildcard psi4/methylcyclohexane/*.out)	\
$(wildcard psi4/methylcyclohexane/*.gbs) $(wildcard			\
psi4/methylcyclohexane/geomopt/*.in) $(wildcard				\
psi4/methylcyclohexane/geomopt/*.out) $(wildcard			\
psi4/transition_metals/geomopt/*.in) $(wildcard				\
psi4/transition_metals/geomopt/*.out) qe/README.pdf $(wildcard		\
qe/*/*.in) $(wildcard qe/*/*.out) $(wildcard qe/*/*/*.in) $(wildcard	\
qe/*/*/*.out) xtb/README.pdf xtb/cisplatin/cisplatin.molden		\
xtb/cisplatin/cisplatin.out xtb/cisplatin/cisplatin.xyz			\
xtb/cisplatin/xtb-molden.out xtb/cisplatin/xtbopt.xyz			\
xtb/methylcyclohexane/crest_conformers.xyz				\
xtb/methylcyclohexane/crest.energies xtb/methylcyclohexane/crest.out	\
xtb/methylcyclohexane/methylcyclohexane.xyz				\
xtb/transplatin/transplatin.out xtb/transplatin/transplatin.xyz		\
xtb/transplatin/xtbopt.xyz

# Rule for making supporting information
suppinfo.zip: $(SUBDIRS) $(DOCS)
	zip suppinfo.zip ${SUPPINFO}
