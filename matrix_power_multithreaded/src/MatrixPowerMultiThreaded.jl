module MatrixPowerMultiThreaded
export julia_main

include("matrix.jl") # use definitions from matrix.jl
using LinearAlgebra: I # include only the identity matrix constructor

function julia_main() :: Cint
    try
        # pass in and convert arguments from the command line in the tuple ARGS to 64 bit integers
        dimension, power, isRandom = parse.(Int, ARGS)
        @assert dimension >= 1 "Matrix dimension must be at least 1"
        @assert power >= 2 "Matrix power must be at least 2"
        @assert isRandom == 0 || isRandom == 1 "Please provide whether to use an identity matrix"
    catch e
        if e isa ArgumentError
            println("Arguments must be positive integers")
        elseif e isa AssertionError
            display(e)
        end
    end

    if Bool(isRandom) # construct a boolean from isRandom which is either 0 or 1
        # square matrix of random number between 0 and 1
        # defaults to Float64
        mat = rand(dimension, dimension)
    else
        # identity matrix with 2 along the diagonal
        # converted to dense matrix of Float64
        mat = 2 * I(dimension) |> Matrix{Float64}
    end
    
    # println("Using ", Threads.nthreads(), " threads")
    # println("DIMENSION,POWER,THREADED,@ELAPSED [s],TIME() [s]")
    for thread_behavior in ["none", "element", "row", "column"]
        start = time()
        elapsedTime = @elapsed matrixPower(mat, power; threaded=thread_behavior)
        final = time()
        println(dimension, ",", power, ",", thread_behavior, ",", round(elapsedTime, sigdigits = 3), ",", round(final - start, sigdigits = 3))
    end
    return 0
end
end