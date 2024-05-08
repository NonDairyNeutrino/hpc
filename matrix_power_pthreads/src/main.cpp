#include <stdio.h>
#include <pthread.h>

#include "dot.h"
#include "matrix.h"

#define NUM_THREADS 8
#define NUM_ITERATIONS 1e2

int main() {
  // initialize vectors
  float vec1[3] = {1, 1, 1};
  float vec2[3] = {1,2,3};
  // initialize matrices
  float mat[3][3] = {{1,0,0},{0,1,0},{0,0,1}};
  float mat_tran[3][3];
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
      mat_tran[i][j] = mat[j][i];
    }
  }
  // calculate dot product
  float result = dot(vec1, vec2, 3);
  printf("The dot product is %f\n", result);
  // calculate matrix multiplication
  float** matrix_product = matrix_multiply(mat, mat_tran, 3, 3);
  return 0;
}
