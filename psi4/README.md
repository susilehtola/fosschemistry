# Illustrations of Psi4 calculations
[Psi4](https://psicode.org/psi4manual/master/index.html) is an *ab initio* quantum chemistry program designed for efficient, high-accuracy simulations of molecular properties. This document illustrates the basic use of `Psi4` for structural optimizations and energy comparisons.

## Installing Psi4

### Fedora
To install `Psi4` on Fedora Linux distribution, simply open a terminal and execute
```
dnf install psi4
```
after which you can run `Psi4` jobs as:
```
psi4 runfile.in
```
or in parallel with e.g. 4 cores as:
```
psi4 -n 4 runfile.in
```
In either case, Psi4 will write the output in the file `runfile.out`.

### Conda (Other Linux distributions, macOS, and Windows Subsystem for Linux)
If you do not have Conda open source package management system installed, please [install Conda first](../conda.md).

`Psi4` Conda installation involves many packages and the safest choice is to install it in a new Conda environment.
Start by creating a new Conda environment and activating it:
```
conda create --name psi4
conda activate psi4
```
Next, you can find the actual installation command from
[https://psicode.org/installs/latest](https://psicode.org/installs/latest). 
Here, we install version 1.4rc2:
```
conda install psi4=1.4rc2 python=3.8 -c psi4/label/dev 
```
After the installation, you can run `Psi4` jobs as:
```
psi4 runfile.in
```
or in parallel on e.g. 4 cores as:
```
psi4 -n 4 runfile.in
```
In either case, Psi4 will write the output in the file `runfile.out`.