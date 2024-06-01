#!/usr/bin/bash
rm -f bench/benchmarks.csv # always start with a fresh benchmarking table
# bench/bench creates bench/benchmarks.csv
power=2;
echo "$power";
for dimension in {100..1000..100}; do
	# for power in {2..10}; do
		echo "Beginning dimension $dimension power $power";
		echo "Beginning O1";
		./bench/bench bin/main_O1 $dimension $power 0;
		echo "Beginning O2";
		./bench/bench bin/main_O2 $dimension $power 0;
		echo "Beginning O3";
		./bench/bench bin/main_O3 $dimension $power 0;
		echo "Beginning Ofast";
		./bench/bench bin/main_Ofast $dimension $power 0;
	# done
done
