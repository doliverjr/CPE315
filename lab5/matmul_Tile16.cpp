#include <stdlib.h>
#include "matmul.h"

Matrix Allocate2ndMatrix(int height, int width, int init);

void matmul( float*, const float*, const float*, unsigned int, unsigned int, unsigned int);

////////////////////////////////////////////////////////////////////////////////
//! C = A * B
//! @param C          result matrix
//! @param A          matrix A 
//! @param B          matrix B
//! @param hA         height of matrix A
//! @param wB         width of matrix B
////////////////////////////////////////////////////////////////////////////////

void matmul(float* C, const float* A, const float* B, unsigned int hA,  unsigned int wA, unsigned int wB) { 
    unsigned int tileWidth = 16;
    unsigned int tileHeight = 16;
    
    for (unsigned int tileI = 0; tileI < hA / tileHeight; tileI++) {
        for (unsigned int tileJ = 0; tileJ < wA / tileWidth; tileJ++) {
            for (unsigned int i = 0; i < tileHeight; ++i) {
                for (unsigned int j = 0; j < tileWidth; ++j) {
                    double sum = 0;
                    for (unsigned int k = 0; k < wA; ++k) {
                        double a = A[tileI * wA * tileHeight + i * wA + k];
                        double b = B[tileJ * wB * tileWidth + j * wB + k];
                        sum += a * b;
                    }
                    C[tileI * tileHeight * hA + tileJ * tileWidth + i * wB + j] = (float)sum;
                }
            }
        }
    }
}

// Allocate a matrix of dimensions height*width
Matrix Allocate2ndMatrix(int height, int width)
{
  Matrix M;
  M.width = M.pitch = width;
  M.height = height;
  int size = M.width * M.height;
  M.elements = NULL;

  M.elements = (float*) malloc(size*sizeof(float));

  // Column-major allocation
  for(unsigned int i = 0; i < M.height; i++)
  {
    for (unsigned int j = 0; j < M.width; j++) {
        M.elements[j * M.height + i] = (rand() / (float)RAND_MAX);
    }
  }
  return M;
}	

