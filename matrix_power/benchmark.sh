#!/bin/bash
echo "BEGINNING BENCHMARKS"

mkdir -p bench

hyperfine \
    --export-markdown bench/benchmark.md\
    --export-csv      bench/benchmark.csv\
    --min-runs 30\ # Need at least 30 to be statistically significant i.e. central limit theorem
    --parameter-list DIM 2,3,4,5,6,7,8,9,10\
    --parameter-list POWER 2,3,4,5,6,7,8,9,10\
    --command-name "Fortran - {DIM} - {POWER}" "bin/matrix_power {DIM} {POWER} $3"

echo "BENCHMARKS FINISHED. RESULTS IN bench/"
