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
    var d = length(agent.pos, agent_j.pos);
    if (d > farRadius) {
      continue;
    }

    var f = d - (2.0 * agentRadius); // assume all agents have same size
    if (f < 0.0) {
      // 4.4 Long Range Collision
      var r = 2.0 * agentRadius;
      var r2 = r * r;
      var dt = params.deltaT;

      var dist = distance(agent.pos, agent_j.pos);
      if (dist < r) {
        r2 = (r - dist) * (r - dist);
      }

      var x_ij = agent.pos - agent_j.pos; // relative displacement
      var v_ij = (1.0/dt) * (agent.xp - agent.x - agent_j.xp + agent_j.x); // relative velocity

      var a = dot(v_ij, v_ij);
      var b = -dot(x_ij, v_ij);
      var c = dot(x_ij, x_ij) - r2;
      var discr = b*b - a*c;
      if (discr < 0.0 || abs(a) < eps) { return; }

      discr = sqrt(discr);

      // Compute exact time to collision
      var t = (b - discr)/a;

      // Prune out invalid case
      if (t < eps || t > t0) { return; }

      // Get time before and after collision
      var t_nocollision = dt * floor(t/dt);
      var t_collision = dt + t_nocollision;

      // Get collision and collision-free positions
      var xi_nocollision = agent.x + t_nocollision * agent.v;
      var xi_collision   = agent.x + t_collision * agent.v;
      var xj_nocollision = agent_j.x + t_nocollision * agent_j.v;
      var xj_collision   = agent_j.x + t_collision * agent_j.v;

      // Enforce collision free for x_collision using distance constraint
      var n = xi_collision - xj_collision;
      var d = length(n);

      var f = d - r;
      if (f < 0.0) {
        n = normalize(n);
        
        var k = k_longrange * exp(-t_nocollision*t_nocollision/t0);
        k = 1.0 - pow(1.0 - k, 1.0/(f32(itr + 1))); // TODO: itr not defined yet
        var w = 0.5;
        var dx = -w * f * n;

        // 4.5 Avoidance Model (not implemented)

        totalDx = totalDx + k * dx;
        neighborCount = neighborCount + 1;
      }
    }
  }

  if (neighborCount > 0) {
    agent.ppos = agent.ppos + avgCoeff * totalDx / f32(neighborCount);
  }

  // Write back
  agents_w.agents[index] = agent;
}