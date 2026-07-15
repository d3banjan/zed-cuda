#include <cuda_runtime.h>

__device__ float square(float value) {
    return value * value;
}

__global__ void square_kernel(float *out, const float *in, int count) {
    __shared__ float tile[32];
    int index = blockIdx.x * blockDim.x + threadIdx.x;

    if (index < count) {
        tile[threadIdx.x] = square(in[index]);
        out[index] = tile[threadIdx.x];
    }
}

void launch(float *out, const float *in, int count, cudaStream_t stream) {
    square_kernel<<<1, 32, 0, stream>>>(out, in, count);
}
