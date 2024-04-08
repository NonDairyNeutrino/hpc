"""! @file matrix_power_python.py
@brief python implementation of matrix powers
"""
from copy import copy
from sys import argv
from random import random

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
        power = copy(A)
        for i in range(p - 1):
            power = matrix_multiply(A, power)
        return power

matrix_dimension, power = argv[1:]
matrix_dimension        = int(matrix_dimension)
power                   = int(power)

matrix = [[random() for col in range(matrix_dimension)] for row in range(matrix_dimension)]
print(matrix_power(power, matrix))
