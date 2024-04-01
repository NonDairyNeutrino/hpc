# Matrix Powers with FORTRAN

## Introduction

The goal of this project is to highlight the differences between using a
scripting language such as python vs a compiled and otherwise more high-performance
language such C/C++ or FORTRAN. This project chooses to do-so with python and FORTRAN.

## Building & Running
The build process for this project uses CMake with the GNU gfortran compiler.
To build the make files, generate the executable, and run it, use either the
included build script

```bash
./build.sh         # builds and generates the project
./bin/matrix_power # runs the executable
```

or build manually

```bash
cmake -B build         # creates a Makefile in build/
make --directory build # creates the executable in bin/
./bin/matrix_power     # runs the executable
```

## Dependencies
This project depends on a few keys softwares
- FORTRAN Compiler: GNU Fortran (GCC) 13.2.1 20230801
- Build Platform  : cmake version 3.28.3, GNU Make 4.4.1
- Scripting lang  : Python 3.11.8

### FORTRAN COMPILER
The FORTRAN compiler used to create this project is the "GNU Fortran Project"'s `GFortran` version 13.2.1.  `GFortran` can be installed on Linux based systems with

#### Debian-based (Debian, Ubuntu, Mint, etc…)

```bash
sudo apt install gfortran
```

#### RPM-based (Red Hat Enterprise Linux, CentOS, Fedora, openSUSE)
```bash
sudo dnf install gcc-gfortran
```

#### Arch-based (Arch Linux, EndeavourOS, Manjaro, etc…)
```bash
sudo pacman -Syu gcc-fortran
```

More information such as installing on other distributions, Windows, or MacOS can be found on the [FORTRAN website](https://fortran-lang.org/en/learn/os_setup/install_gfortran/#linuxFORTRAN).