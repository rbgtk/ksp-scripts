function createCircularManeuverNode {
  local time is timespan(eta:apoapsis).
  local radial is 0.
  local normal is 0.
  local prograde is 0.

  local maneuver is node(time, radial, normal, prograde).

  until maneuver:orbit:eccentrity < 0.001 {
    set maneuver is improveManeuver(maneuver).
  }

  return maneuver.
}

