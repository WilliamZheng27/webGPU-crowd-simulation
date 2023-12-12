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
const nearRadius : f32 = 2.0; // threshold for SR collision
const farRadius : f32 = 5.0;  // threshold for LR collision
const agentRadius : f32 = 1.0 // agent size (TODO: find the right size)
const blendFactor : f32 = 0.0385;
const k_shortrange : f32 = 1.0;
const avgCoeff : f32 = 1.2;

@binding(0) @group(0) var<uniform> params : SimParams;
@binding(1) @group(0) var<storage, read> agents_r : Agents;
@binding(2) @group(0) var<storage, read_write> agents_w : Agents;

@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID : vec3<u32>) {
  var index = GlobalInvocationID.x;
  var agent = agents_r.agents[index];

  var totalDx = vec3<f32>(0.0, 0.0, 0.0);
  var neighborCount = 0;
  for (var j = 0u; j < arrayLength(&agents_r.agents); j++) {
    if (idx == j) {
      continue;
    }

    var agent_j = agents_r.agents[j];
    var n = agent.ppos - agent_j.ppos;
    var d = length(n);
    if (d > nearRadius) {
      continue;
    }

    var f = d - (2.0 * agentRadius); // assume all agents have same size
    if (f < 0.0) {
      // 4.2 Short Range Collision
      n = normalize(n);
      var w = 0.5; // assume all agents have same weight
      var dx = -w * k_shortrange * f * n;

      // 4.2 Friction (not implemented yet)

      totalDx = totalDx + dx;
      neighborCount = neighborCount + 1;
    }
  }

  if (neighborCount > 0) {
    totalDx = avgCoeff * totalDx / f32(neighborCount);

    agent.pos = agent.pos + totalDx;
    agent.ppos = agent.ppos + totalDx;
  }

  // Write back
  agents_w.agents[index] = agent;
}