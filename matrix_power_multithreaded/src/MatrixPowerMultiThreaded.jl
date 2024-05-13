module MatrixPowerMultiThreaded
export julia_main

include("matrix.jl") # use definitions from matrix.jl
using LinearAlgebra: I # include only the identity matrix constructor

function julia_main() :: Cint
    dimension, power, isRandom = parse.(Int, ARGS)

    if Bool(isRandom)
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