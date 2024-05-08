#include <stdio.h>
#include <pthread.h>

#include "dot.h"

#define NUM_THREADS 8
#define NUM_ITERATIONS 1e2

int main() {
  // initialize vectors
  float vec1[3] = {1, 1, 1};
  float vec2[3] = {1,2,3};
  // calculate dot product
  float result = dot(vec1, vec2, 3);
  // print result
  printf("The dot product is %f\n", result);
  return 0;
}
