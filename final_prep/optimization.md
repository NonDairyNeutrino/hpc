# Compiler Optimization
- The compiler can either optimize for execution time or binary size
# Dependencies
## Data Dependencies
- A data dependence exists between two statements if they read and write to the same location in memory
- Dependence <-> Read after write
- Anti-dependence <-> write after read
- Output dependence <-> write after write
- Can fix anti- and output dependencies by renaming and/or copying variables
## Control Dependencies
- An instruction is control dependent on a preceding instruction if the outcome of the latter can determine if the former should be executed
## Why manually optimize code?
Some dependencies such as data dependencies might be redundant in the sequential case, but another thread might need it.  As such, When multi-threading, it might be a good idea to turn-off,  compiler optimization, and hence optimization is the developer's responsibility.

## Optimization Tips
- Minimize operations by increasing loads and assignments
- Test Promotion: move loop-independent test out of the loop
	- Conditions in a loop also disallow the compiler to vectorize the loop
- Loop Peeling: boundary conditions can be moved out of the loop
- Loop Fission: the body of the loop is broken into multiple loops, each executing its own independent instructions
	- Fission mitigates the number of cache misses
- Loop Fusion: if a cache can hold several values, multiple loops can be condensed into one
- If you have multiple cores, the iterations of a for loop can be "chunked" into that many operations at the same time.
# Optimizing C++ Software
- Portability: When multi-threading, it might be a good idea to turn-off, compiler optimization, and hence optimization is the developer's responsibility.
- Security: There is no checking for array bounds violations and/or invalid pointers, so always initialize pointers to zero, and consider using container classes for arrays.
- Global/static variables can be used to communicate between CPUs or even machines
- `union` allocates arrays in the same memory space