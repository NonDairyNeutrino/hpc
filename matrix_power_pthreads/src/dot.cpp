// Define the dot product between vectors and matrices

#include <cstdio>
#include <exception>
#include <iterator>
#include <numeric>
#include <math.h>
using namespace std;

float dot(float vec1[], float vec2[]) {
    int length1 = sizeof(vec1) / sizeof(float);
    int length2 = sizeof(vec2) / sizeof(float);
    // check if vectors have the same dimension
    if(length1 != length2){
        // sizes don't match
        printf("Array dimensions don't match.");
        terminate();
    } 
    else {
        // sizes do match
        int sum = 0;
        for (int i = 0; i < length1; i++) {
            sum += vec1[i] * vec2[i];
        }
    }
}
