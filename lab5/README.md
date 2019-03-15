# cpe315-lab5
Cache Optimization

Justin Nguyen @justinnuwin

Lab 5 Completed!

### Build Instructions
Original matmul

`$ make`

Matrix B Column Major matmul

`$ make BColMaj`

16 x 16 Tile matmul

`$ make Tile16`

32 x 32 Tile matmul

`$ make Tile32`

### Purpose
To optimize data cache accesses for the matrix multiply application.

### Measurements
You can measure the number of cache misses and cache references using:
    perf stat -e cache-misses -e cache-references ./mm > myout



