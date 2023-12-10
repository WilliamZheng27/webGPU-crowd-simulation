# webGPU-crowd-simulation Milestone Report

## Work We've Done
We have studied the basics of WebGPU and built a simple 2D Boids simulation through a tutorial as both a practice and a starting point for implementing the crowd simulation algorithm. We have also thoroughly read the crowd simulation algorithm paper listed in the proposal.

## Goals Review
We were able to finish the first two milestones on time (proposal & webGPU Demo), but behind schedule for the latest milestone (implementing the algorithm with WebGPU) due to our Thanksgiving travel plan. We still believe we will be able to complete all deliverables, and the updated schedule and goals are listed below.
| Date | Goals |
| --- | ----- |
| 12/9 | Implement the algorithm using WebGPU API (Weisheng & Yuxiao)<br> Render the simulation in 3D (Weisheng)|
| 12/12 | Optimize the algorithm for real-time framerate (Yuxiao) |
| 12/14 | Final Report (Weisheng) |


## Poster Session Plan

We plan to come up with the following result:

- A running WebGPU implementation of the crowd-simulation algorithm described in the paper
  - With/without long-range collision
  - With/without collision avoidance
  - With/without obstacles
  - Different number of agents
  - Different sizes of agents
- Benchmark (render time for each frame)
  - Naive JavaScript Implementation without using compute shader
  - CUDA (Provided by the paper)
  - WebGPU on CUDA
  - WebGPU on Metal

## Issues

- WebGPU is quite new so it's not supported by all browsers and platforms.
- Debugging programs on it could be quite tricky.
- We don't know if we can correctly implement the full algorithm since it involves many stages and optimizations
- There are limited resources out there for this new standard.
