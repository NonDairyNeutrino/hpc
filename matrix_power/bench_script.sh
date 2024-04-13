#!/usr/bin/bash
rm -f bench/benchmarks.csv # always start with a fresh benchmarking table

# bench/bench creates bench/benchmarks.csv
for dimension in {100..1000..20}; do
	for power in {10..100..10}; do
		echo "Beginning dimension $dimension power $power";
		./bench/bench bin/main $dimension $power 0;
		# src/matrix_power_python.py doesn't print progress
		./bench/bench python src/matrix_power_python.py $dimension $power;
	done
done
