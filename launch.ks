// define functions

function main {
  
  printCountdown(2).

  doLaunch().
  doAscent().
  doShutdown().

}

function printCountdown {

  PARAMETER seconds.

  IF seconds < 3 SET seconds TO 3.

  FROM {local count is seconds.} 
    UNTIL count = 0 
    STEP {set count to count - 1.} 
    DO { print count. wait 1. }

  PRINT "Launch!".

}

function doLaunch {
  LOCK throttle TO 1.
  doStage().
}

function doAscent {
  LOCK pitch TO 90 - 1.01 * alt:radar^0.409511.    
  LOCK steering TO heading(90, pitch).
  
  until apoapsis > 90000 {
    IF NOT(defined oldThrust) {
      DECLARE GLOBAL oldThrust TO ship:availablethrust.
    }

    if ship:availablethrust < (oldThrust - 10) {
      doStage().
      WAIT 1.
      DECLARE GLOBAL oldThrust TO ship:availablethrust.
    }
  }
}

function doShutdown {
  SAS ON.
  WAIT 1.
  SET SASMODE TO "prograde".
  LOCK throttle TO 0.

  PRINT "Shutdown complete".
}

function doStage {
  WAIT UNTIL stage:ready.
  STAGE.
}

main().
