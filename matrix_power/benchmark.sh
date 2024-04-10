#!/bin/bash
echo "BEGINNING BENCHMARKS"

mkdir -p bench

hyperfine \
    --export-markdown bench/benchmark.md      \
    --export-csv      bench/benchmark.csv     \
    --min-runs 30                             \
    --command-name "Fortran - 100 - 100"\
    "bin/matrix_power 100 100 0"\
    --command-name "Python - 100 - 100"\
    "python src/matrix_power_python.py 100 100"
#    --parameter-list DIM 10,20   \
#    --parameter-list POWER 10,100 \
#    --command-name "Fortran - {DIM} - {POWER}"\
#    "bin/matrix_power 1000 100 0"

echo "BENCHMARKS FINISHED. RESULTS IN bench/"
