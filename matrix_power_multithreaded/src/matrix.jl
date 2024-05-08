# matrix multiplication
function dot(vec1 :: Vector{Float64}, vec2 :: Vector{Float64}) :: Float64
    dot_product = 0
    for i in 1:length(vec1)
        dot_product += vec1[i] * vec2[i]
    end
    return dot_product
end

function matrix_multiply(mat1 :: Matrix{Float64}, mat2 :: Matrix{Float64}; threaded="none")
    if threaded == "none"
        product = Matrix(undef, size(mat1)[1], size(mat2)[2])
        # do regular matrix multiplication
        for i in eachrow(mat1)
            for j in eachcol(mat2)
                product[i,j] = dot(mat1[i,:], mat2[:,j])
            end
        end

    elseif threaded == "element"
        # matrix multiplication where each element of the product
        # is calculated in its own threaded
    elseif threaded == "row"
        # matrix multiplication where each row of the product
        # is calculated in its own threaded
    elseif threaded == "column"
        # matrix multiplication where each column of the product
        # is calculated in its own threaded
    end
end
