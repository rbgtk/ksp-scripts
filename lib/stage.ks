function safeStage {
  wait until stage:ready.
  stage.
}

function autoStage {
  if ship:stageDeltaV(ship:stageNum):current = 0 { 
    safeStage().
  }
}
