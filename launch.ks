
runpath("0:/lib/stage.ks").

set countdownSeconds to 5.
set targetApoapsis to 120000.
set ascentComplete to false.

until ascentComplete {

  from {
    local countdown is countdownSeconds.
  } until countdown = 0 step {
    set countdown to countdown - 1.
  } do {
    print countdown.
    wait 1.
  }

  print "Launch!".

  lock throttle to 1.
  lock pitch to 90 - ship:verticalspeed / 20.
  lock steering to heading(90,pitch,0).

  safeStage().

  until ship:apoapsis > targetApoapsis {
    // stage when needed
  }

  lock throttle to 0.
  lock steering to heading(90,0,0).

  set ascentComplete to true.
}

