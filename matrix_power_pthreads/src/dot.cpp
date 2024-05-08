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