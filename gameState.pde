
int gameState = 1; 
/*
      0 = Menu placeholder
 1 = main game loop
 2 = death animation loop
 */


void menuLoop() {
  //Placeholder
  if (gameState != 1)
    gameState=1;
}

void gameLoop() {
  background (0);

  //stroke (200);
  //fill (200);
  //rect (displayWidth/2, displayHeight/2, gameWidth, gameHeight);
  //camera( a, b, c, d, e, f, 0, 0, -1);

  // Change to have trail always be light  lights() during trail render
  pointLight(255, 255, 255, p1.x, p1.y, p1.z+200);


  keyboardDebugControls();

  if (cameraDebugMode) {
    noLights();
    camera(a+cx, b+cy, c+cz, d+cx, e+cy, f+cz, 0, 0, -1);
  }


  p1.Main();
  pushMatrix();
  p1.render();
  popMatrix();



  objectListTraverseMain(gameObjects);
  objectListTraverseRender(gameObjects);

  if (tick%2==0)
  {
    for (BeamTrail trail : trailList) {
      trail.BeamPoints.add(new BeamPoint (p1.x, p1.y, p1.z+50, p1.turnTilt, p1.lookAngle));
    }
  }

  tick++;
  //filter (BLUR, 3);
}

void deathLoop() {
  background (tick);

  //stroke (200);
  //fill (200);
  //rect (displayWidth/2, displayHeight/2, gameWidth, gameHeight);
  //camera( a, b, c, d, e, f, 0, 0, -1);

  // Change to have trail always be light  lights() during trail render
  pointLight(255, 255, 255, p1.x, p1.y, p1.z+200);


  keyboardDebugControls();

  if (cameraDebugMode) {
    noLights();
    camera(a+cx, b+cy, c+cz, d+cx, e+cy, f+cz, 0, 0, -1);
  }

  pushMatrix();
  p1.renderDeath();
  popMatrix();


  objectListTraverseRender(gameObjects);

  if (tick%2==0)
  {
    for (BeamTrail trail : trailList) {
      trail.BeamPoints.add(new BeamPoint (p1.x, p1.y, p1.z+50, p1.turnTilt, p1.lookAngle));
    }
  }

  tick++;
  println(tick);

  if (tick > 254)
    exit();
  //filter (BLUR, 3);
}
