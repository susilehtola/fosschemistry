# Installing Conda open source package manager

## Note about operating systems
Conda package manager is available both for
[Linux](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html) and 
[macOS](https://docs.conda.io/projects/conda/en/latest/user-guide/install/macos.html). 

Conda is also available Windows, but most quantum chemistry software can only be run under 
Windows Subsystem for Linux (WSL). If you wish to run Linux software under Windows, please 
[install WSL2 first](https://docs.microsoft.com/en-us/windows/wsl/install-win10). In the final
stage of installation, you may choose which Linux distribution to install. The instructions below
have been tested on Ubuntu 20.04 LTS, but should work with other distributions, too.

## Installing Conda on Linux
Download the Miniconda installer
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```
Install in `$HOME/miniconda3` (-b accepts the [license](https://www.anaconda.com/eula-anaconda-individual-edition)):
```
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
```

## Initializing Conda on Linux
Initialize `conda` by executing
```
. $HOME/miniconda3/etc/profile.d/conda.sh
```
If you want to initialize `conda` automatically when logging in,
you can add the above line in the bottom of a shell initialization 
file (for example, `$HOME/.bashrc` for `bash`).

## Activating the default Conda environment
The default `conda` environment can be activated by executing
```
conda activate
```
The currently active `conda` environment can be deactivated by executing
```
conda deactivate
```

## Creating new Conda environments
It is possible to create separate `conda` environments for different programs.
This is recommended especially when complex software packages with many dependencies
are installed. For example, a new environment called `nwchem` can be created with
```
conda create --name nwchem
```
The new environment can be activated with
```
conda activate nwchem
```
and later deactivated with 
```
conda deactivate
```

