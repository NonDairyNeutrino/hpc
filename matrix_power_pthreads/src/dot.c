// Define the dot product between vectors and matrices

// #include <stdio.h>
#include <stdlib.h>

// implementation of the dot product;
// input: two 1D arrays of floats of equal length;
// output: a float representing the dot product
float dot(float vec1[], float vec2[], int length) {
    float dot_product = 0; // initialize result

    for(int i = 0; i < length; i++) {
        // printf("vec1[%d] = %f, vec2[%d] = %f\n", i, vec1[i], i, vec2[i]);
        dot_product += vec1[i] * vec2[i];
    }
    return dot_product;
}

float** matrix_multiply(float* mat[], float* mat_tran[], int n_rows, int n_cols){
    // dynamically allocate memory for 2D array
    // use calloc instead of malloc to use product[i][j] notation
    // calloc also initializes the elements to be 0
    float (*product)[n_rows] = calloc(n_cols, sizeof(*product));

    // set the elements of the 2D array
    for(int r = 0; r < n_rows; r++){
        for(int c = 0; c < n_cols; c++){
            product[r][c] = dot(mat[r], mat_tran[c], n_rows);
        }
    }

    return *product;
}