# webGPU-crowd-simulation
Weisheng Li, Yuxiao Zheng  
https://github.com/WilliamZheng27/webGPU-crowd-simulation

## Summary
We plan to implement a read-time crowd simulation algorithm using the WebGPU API

## Background
The algorithm can be broken down into five stages:

1. **Velocity Planning**: advect the agent based on a calculated velocity field.
2. **Neighbor Searching**: find the nearest neighbor and assign to hash grid.
3. **Stability Solving**: resolve any collisions that remain from the previous time step for stability.
4. **Constraint Solving**: project the main constraints and correct agents' positions.
5. **Velocity Finalizing**: finalize the velocity and update the final position of the agent

![Compute Pipeline](img/algorithm_description.png)

Crowd simulation algorithms require computing the velocity and updating the position of all agents
in the scene simultaneously, which creates an opportunity for parallelization. The algorithm was
originally implemented in CUDA kernels. We plan to implement it with shader programs in WebGPU instead
and measure the performance.

## The Challenge
The first challenge comes from the fact that WebGPU originates from modern graphics APIs like
Direct3D 12, Metal, and Vulkan, and is very different from CUDA. We need to study this new technology
from scratch for this project.

Parallelizing the algorithm is also non-trivial. The constraint groups can be solved in parallel using
techniques like a Jacobi solver. The neighbor-finding process, similar to what we have encountered in
the n-body simulation problem, can also be accelerated by techniques like hash grids.

## Resources
The algorithm we plan to implement is based on the paper: [Position-Based Real-Time Simulation of Large Crowds](https://tomerwei.github.io/pdfs/mig2017.pdf).
Our implementation will start from scratch but will use the CUDA implementation that comes with the
paper as a reference. Since WebGPU runs on Google Chrome, we will develop and test our implementation on our own computers.

## Goals & Deliverables
### Plan
We plan to have a runable version of this algorithm that could accept input in a certain format, run the simulation with local GPU through WebGPU interfaces, and output the result.
### Goal
We wish we could achieve a real-time visualization for the simulation project, including UI for adjusting parameters, loading presets and the real time position and movement of the agents.

## Platform Choice
We choose WebGPU as our platform, because this is quite a new method which just officially been adopted into the standard recently. It allow us to have GPU access directly in the brower so that we could run heavy rendering jobs directly from the browser. However, just like the transition from OpenGL to CUDA, we are also curious about the potential of runing scietific computation workload using this new API and the possibilities of having simulation tasks running easily just as using ChatGPT. 

## Schedule
| Date | Progress |
| --- | ----- |
| 11/15 | Proposal |
| 11/22 | Research & Demo for using WebGPU API |
| 11/30 | Implementation of the algorithm using WebGPU API |
| 12/10 | Visualization |
