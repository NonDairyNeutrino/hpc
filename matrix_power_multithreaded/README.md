# Multithreaded Matrix Powers

Naive matrix powers has a time complexity of _O(N^3)_.
Thankfully, each element of the product matrix is independent of all the others.
Because of this independence, each of these elements can be calculated in parallel.

The goal of this work is to implement parallel/multithreaded matrix multiplication.

# Running the Code
There are two options to run the code: from a compiled binary, or using Julia.

## Using the Binary

If you do not have Julia installed on your machine (or if you just want to use the binary), the code can be ran with 

```Julia
path/to/package/compiled/bin/MatrixPowerMultiThreaded DIMENSION POWER ISRANDOM --julia-args -t NUM_THREADS
```

where `DIMENSION` is the dimension of the matrix to be powered, `POWER` is the power the matrix to which the matrix is to be raised, `ISRANDOM` is either `0` for `false` or `1` for `true`, and `NUM_THREADS` is the number of threads the program uses/the size of the thread pool that is initialized when the program begins.

## Using Julia

If Julia is installed, you can invoke

```Julia
julia -t NUM_THREADS path/to/package/src/MatrixPowerMultiThreadedScript.jl DIMENSION POWER ISRANDOM
```

with parameters defined as above.