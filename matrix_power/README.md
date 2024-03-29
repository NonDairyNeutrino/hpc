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
