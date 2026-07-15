#pragma once

__constant__ float coefficients[4];
__managed__ int managed_counter;

__host__ __device__ inline int clamp_index(int index, int count) {
    return index < count ? index : count - 1;
}
