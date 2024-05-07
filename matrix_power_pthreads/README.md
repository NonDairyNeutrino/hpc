# Multithreaded Matrix Powers

Naive matrix multiplication has a time complexity of _O(N^2)_.
Thankfully, each element of the product matrix is independent of all the others.
Because of this independence, each of these elements can be calculated in parallel.

The goal of this work is to implement parallel/multithreaded matrix multiplication.
It is to be done in C using the pthreads library.
