struct Agent {
  pos : vec2<f32>, // current position
  vel : vec2<f32>,
  ppos: vec2<f32>, // planed/predicted position, updated in different stages
}
struct SimParams {
  deltaT : f32,
  rule1Distance : f32,
  rule2Distance : f32,
  rule3Distance : f32,
  rule1Scale : f32,
  rule2Scale : f32,
  rule3Scale : f32,

  goal1: vec2<f32>,
  goal2: vec2<f32>,
}
struct Agents {
  agents : array<Agent>,
}

// constants copied from the paper
const nearRadius : f32 = 2.0;
const farRadius : f32 = 5.0;
const blendFactor : f32 = 0.0385;