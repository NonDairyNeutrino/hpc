#include "dot.h"
float** matrix_multiply(float* mat[], float* mat_tran[], int n_rows, int n_cols){
    float** product = new float*[n_rows];

    for(int r = 0; r < n_rows; r++){
        product[r] = new float[n_cols];
        for(int c = 0; c < n_cols; c++){
            product[r][c] = dot(mat[r], mat_tran[c], n_rows);
        }
    }
    return product;
}