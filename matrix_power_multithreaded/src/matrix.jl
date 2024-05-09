using LinearAlgebra
using BenchmarkTools

# matrix multiplication
function dot(vec1 :: Vector{Float64}, vec2 :: Vector{Float64}) :: Float64
    dot_product = 0
    for i in 1:length(vec1)
        dot_product += vec1[i] * vec2[i]
    end
    return dot_product
end

function matrixMultiply(mat1 :: Matrix{Float64}, mat2 :: Matrix{Float64}; threaded="none")
    # initialize product matrix
    product = Matrix{Float64}(undef, size(mat1)[1], size(mat2)[2])
    # choose behavior based on specified threading
    if threaded == "none"
        # do regular matrix multiplication
        # println("Proceeding with sequential matrix multiplication...")
        for i in 1:size(mat1)[1]
            for j in 1:size(mat2)[2]
                product[i,j] = dot(mat1[i,:], mat2[:,j])
            end
        end

    elseif threaded == "element"
        # matrix multiplication where each element of the product
        # is calculated in its own threaded
        # println("Proceeding with element-threaded matrix multiplication...")
        Threads.@threads for i in 1:size(mat1)[1]
            Threads.@threads for j in 1:size(mat2)[2]
                product[i,j] = dot(mat1[i,:], mat2[:,j])
            end
        end
    elseif threaded == "row"
        # matrix multiplication where each row of the product
        # is calculated in its own threaded
        # println("Proceeding with row-threaded matrix multiplication...")
        Threads.@threads for i in 1:size(mat1)[1]
            for j in 1:size(mat2)[2]
                product[i,j] = dot(mat1[i,:], mat2[:,j])
            end
        end
    elseif threaded == "column"
        # matrix multiplication where each column of the product
        # is calculated in its own threaded
        # println("Proceeding with column-threaded matrix multiplication...")
        for i in 1:size(mat1)[1]
            Threads.@threads for j in 1:size(mat2)[2]
                product[i,j] = dot(mat1[i,:], mat2[:,j])
            end
        end
    end
    return product
end

function matrixPower(mat :: Matrix{Float64}, power :: Int; threaded = "none")
    mat_pow = mat
    for p in 2:power
        println("Beginning power: $p")
        mat_pow = matrixMultiply(mat, mat_pow; threaded = threaded)
    end
    return mat_pow
end

mat = 2 * I(1000) |> Matrix{Float64}
println("Using ", Threads.nthreads(), " threads")
for thread_behavior in ["none", "element", "row", "column"]
    println("Beginning thread behavior: $thread_behavior")
    @time matrixPower(mat, 10; threaded=thread_behavior) |> display
end