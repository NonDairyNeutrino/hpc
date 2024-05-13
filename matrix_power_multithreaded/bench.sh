# create benchmark results file and initialize with headers
# echo "DIMENSION,POWER,THREADED,@ELAPSED [s],TIME() [s]" > bench_results.csv

for dimension in {280..1000..20}; do
    for power in {10..100..10}; do
        compiled/bin/MatrixPowerMultiThreaded $dimension $power 1 --julia-args -t 23 >> bench/bench_results.csv
    done;
    cat bench/bench_results.csv > bench/bench_results_checkpoint.csv
done