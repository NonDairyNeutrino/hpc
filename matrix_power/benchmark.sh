#!/bin/bash
hyperfine \
    --export-markdown benchmark.md\
    --export-csv      benchmark.csv\
    --min-runs 30\
    --command-name "Fortran" "bin/matrix_power $1 $2 $3"\
    --command-name "Python" "python src/matrix_power_python.py $1 $2"
