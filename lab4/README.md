# Lab 4 Matrix Addition

Justin Nguyen (justinnuwin)

## Build Instructions

### Build and run Matrix Addtion Utility

`$ make`

`$ ./matadd`

To get performance info run:

`$ perf stat ./matadd 2>&1 > /dev/null`
> Note this will only run on RPi2 and RPi3

### Run testing script
This will compile matadd at various optimization levels and run it a few times.
Results will be compiled to `$output` in their respective shell scripts by running:

#### Profiling with perf at multiple optimization levels

`$ chmod +x perf_matadd.sh`

`$ ./perf_matadd.sh` 

#### Profiling with gprof at a single optimization level

`$ chmod +x prof_matadd.sh`

`$ ./prof_matadd.sh`

#### Profiling with perf at various loop unrolling levels

`$ cd loopUnrolling/`

`$ chmod +x perf_matadd.sh`

`$ ./perf_matadd.sh` 

:octocat:
