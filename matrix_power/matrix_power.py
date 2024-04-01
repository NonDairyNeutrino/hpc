# python implementation of matrix multiplication
import copy as cp
import sys
def matrix_multiply(A, B):
    # multiply two matrices
    # inputs: two matrices
    # outputs: the product of the input matrices
    product = [[0 for j in range(len(B))] for i in range(len(A))]
    for i in range(len(A)):
        for j in range(len(B[1])):
           product[i][j] = sum(A[i][k] * B[k][j] for k in range(len(B)))
    return product

def matrix_power(p, A):
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
