function createCircularManeuverNode {
  local nodeTime is time:seconds + eta:apoapsis.
  local dv_radial is 0.
  local dv_normal is 0.
  local dv_prograde is dv_apoapsis().

  return node(nodeTime, dv_radial, dv_normal, dv_prograde).
}

// calculates dV required to circularise at current apoapsis
function dv_apoapsis {
  local v1 is (ship:body:mu * (2 / (ship:apoapsis + ship:body:radius) - 2 / (ship:apoapsis + ship:periapsis + 2 * ship:body:radius))) ^ 0.5.
	local v2 is (ship:body:mu * (2 / (ship:apoapsis + ship:body:radius) - 2 / (2 * ship:apoapsis + 2 * ship:body:radius))) ^ 0.5.

  return abs(v2 - v1).
}
