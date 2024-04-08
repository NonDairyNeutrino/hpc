#!/bin/bash
hyperfine "bin/matrix_power $1 $2 $3" "python src/matrix_power_python.py $1 $2"
