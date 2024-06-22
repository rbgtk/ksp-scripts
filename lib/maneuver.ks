function executeManeuver {
  parameter maneuverNode. // type: node

  add maneuverNode.
  
  lock steering to maneuverNode:burnVector.
  set burnTime to getManeuverBurnTime(maneuverNode).
  set startBurn to time:seconds + maneuverNode:eta - burnTime / 2.
  lock maneuverComplete to isManeuverComplete(maneuverNode).

  wait until time:seconds > startBurn.

  lock throttle to 1.

  wait until maneuverComplete.
}

function getManeuverBurnTime {
  parameter maneuver.

  local isp is 0.

  list engines in myEngines.
  
  for engine in myEngines {
    if engine:ignition and not engine:flameout {
      set isp to isp + engine:isp * (engine:maxThrust / ship:maxThrust).
    }
  }
  
  local finalMass is ship:mass / (constant():e ^ (maneuver:deltaV:mag / (isp * ship:body:mu))).
  local fuelFlow is ship:maxThrust / (isp * ship:body:mu).
  local burnTime is (ship:mass - finalmass) / fuelFlow.

  return burnTime.
}

function isManeuverComplete {
  parameter maneuver.

  if not(defined originalVector) or originalVector = -1 {
    declare global originalVector is maneuver:burnVector.
  }

  if vang(originalVector, maneuver:burnVector) > 30 {
    declare global originalVector is -1.
    return true.
  }

  return false.
}
