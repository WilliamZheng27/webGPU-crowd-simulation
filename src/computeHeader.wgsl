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
const agentSpeed : f32 = 1.0;     // TODO: find the right value
const nearRadius : f32 = 2.0;     // threshold for SR collision
const farRadius : f32 = 5.0;      // threshold for LR collision
const cohesionRadius : f32 = 5.0  // threshold for cohesion
const agentRadius : f32 = 1.0     // agent size (TODO: find the right size)
const blendFactor : f32 = 0.0385;
const k_shortrange : f32 = 1.0;
const avgCoeff : f32 = 1.2;
const eps : f32 = 0.0001;
const t0 : f32 = 20.0;