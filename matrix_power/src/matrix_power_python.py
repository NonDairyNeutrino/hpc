"""! @file matrix_power_python.py
@brief python implementation of matrix powers
"""
import copy as cp
import sys

def matrix_multiply(A, B):
    """! @brief Multiply two matrices
    @param[in] A The left matrix
    @param[in] B The right matrix
    @return The product of the two matrices
    """
    product = [[0 for j in range(len(B))] for i in range(len(A))]
    for i in range(len(A)):
        for j in range(len(B[1])):
           product[i][j] = sum(A[i][k] * B[k][j] for k in range(len(B)))
    return product

def matrix_power(p, A):
    """! @brief Calculate the power of a matrix
    @param[in] p The exponent
    @param[in] A The matrix
    @return The power of the matrix
    """
    if p == 1:
        return A
    else:
        power = cp.copy(A)
        for i in range(p - 1):
            power = matrix_multiply(A, power)
        return power

p = int(sys.argv[1])
matrix = [[2,0,0],[0,2,0],[0,0,2]]
print(matrix_power(p, matrix))
