using LinearAlgebra
using BenchmarkTools

include("matrix.jl")

dimension, power = parse.(Int, ARGS)

mat = 2 * I(dimension) |> Matrix{Float64}
println("Using ", Threads.nthreads(), " threads")
for thread_behavior in ["none", "element", "row", "column"]
    println("Beginning thread behavior: $thread_behavior")
    @time matrixPower(mat, power; threaded=thread_behavior) |> display
end