# Installing Jmol open-source Java viewer for chemical structures
## Installing Jmol with package managers
The `Jmol` visualization software can be installed via
Linux distribution package managers or [Conda](conda.md) package manager.

On Fedora:
```
dnf install jmol
```
On Ubuntu:
```
apt install jmol
```
In Conda (other Linux distributions, macOS, native Windows, or Windows Subsystem for Linux):
```
conda install -c conda-forge jmol
```

## Installing Jmol from Sourceforge
Alternatively, Jmol can be downloaded directly from 
[Sourceforge](https://sourceforge.net/projects/jmol/files/Jmol/).
Java is required to run Jmol.

## Visualizing results generated under WSL in Jmol running on Windows
If you are using Windows Subsystem for Linux (WSL), and want to view 
files created inside WSL in Jmol that runs on Windows, any WSL directory 
can be easily viewed in Windows Explorer by executing the 
following command in WSL:
```
explorer.exe .
```
The files from the directory can be dragged and dropped for example
to Jmol main window.
 