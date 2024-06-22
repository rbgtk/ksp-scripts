
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
    autoStage().
  }

  set ascentComplete to true.

}

lock throttle to 0.

unlock throttle.
unlock steering.

sas on.
wait until sas.
set sasmode to "prograde".

print "Ascent complete.".

