// Define the dot product between vectors and matrices

#include <cstdio>
#include <exception>
#include <iterator>
#include <numeric>
#include <math.h>
using namespace std;

float dot(float *vec1, float *vec2) {
    float dot_product = 0; // initialize result

    // get length of arrays
    int length1 = sizeof(&vec1) / sizeof(float);
    int length2 = sizeof(&vec2) / sizeof(float);

    // check if vectors have the same dimension
    printf("The length of vector1 is %d\n", length1);
    printf("The length of vector2 is %d\n", length2);

    if(length1 != length2){
        // sizes don't match
        printf("Array dimensions don't match.");
        terminate();
    } 
    else {
        // sizes do match
        for (int i = 0; i <= length1; i++) {
            printf("vec1[%d] = %f, vec2[%d] = %f\n", i, vec1[i], i, vec2[i]);
            dot_product += vec1[i] * vec2[i];
        }
    }
    return dot_product;
}
