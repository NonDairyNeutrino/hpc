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
./build.sh                                      # builds and generates the project
./bin/matrix_power matrix_dimension power is_id # runs the executable
```

or build manually

```bash
cmake -B build         # creates a Makefile in build/
make --directory build # creates the executable in bin/
doxygen                # generates documentation
./bin/matrix_power     # runs the executable
```

## Dependencies
In order to build this project from source, dependencies are needed.
- FORTRAN Compiler: GNU Fortran (GCC) 13.2.1 20230801
- Build Platform  : cmake version 3.28.3, GNU Make 4.4.1
- Scripting lang  : Python 3.11.8
- Documenter      : Doxygen 1.10.0 

### FORTRAN COMPILER
The FORTRAN compiler used to create this project is the "GNU Fortran Project"'s `GFortran` version 13.2.1.  While `GFortran` was used, `gcc` should also work.

## Project Organization

## Source Code
Source code for matrix multiplication functionality in Fortran and Python can be found in src/.

### Binaries/Executables
Once compiled, binaries can be found in bin/.

### Documentation
Documentation (generated via Doxygen) for the functionality of this project can be found in both html and man-page formats in docs/.

### Benchmarking
Benchmarking utilities and results can be found in bench/.

### Report
The report and analysis for this project can be found in report/nathan_chapman_lab1.pdf.
