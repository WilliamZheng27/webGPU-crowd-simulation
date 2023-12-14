# Final Report

## Summary



## Background

### Algorithm



### Data Structures



### Operations



### Input/Output



### Computational Intensive Parts



### Dependency Graph

TODO: Break down the workload. Where are the dependencies in the program? How much parallelism is there? Is it data-parallel? Where is the locality? Is it amenable to SIMD execution?

## Implementation

### Language & API



### Data Structure Mapping

TODO: Describe how you mapped the problem to your target parallel machine(s). IMPORTANT: How do the data structures and operations you described in part 2 map to machine concepts like cores and threads. (or warps, thread blocks, gangs, etc.)

### Optimization



## Results

### Windows (Nvidia GTX 1060)

| Implementation        | Rendering Time (us) | FPS  |
| --------------------- | ------------------- | ---- |
| Baseline (JavaScript) |                     |      |
| WebGPU                |                     |      |

### macOS (Apple M1 Pro)

| Implementation        | Rendering Time (us) | FPS  |
| --------------------- | ------------------- | ---- |
| Baseline (JavaScript) |                     |      |
| WebGPU                |                     |      |

## References

- WebGPU-samples:https://github.com/webgpu/webgpu-samples
- Position-based real-time simulation of large crowds: https://web.cs.ucla.edu/~dt/papers/cag19/cag19.pdf
- Original Implementation from the paper: https://github.com/tomerwei/pbd-crowd-sim/tree/master

## Work Distribution



