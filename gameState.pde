
int gameState = 1; 
/*
     0 = Menu placeholder
 1 = Main game loop
 2 = death animation loop
 */

void resetGame() {
  frameRate(60);
  imageMode (CENTER);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(20);
  // gameWidth = int(displayWidth*0.8);
  // gameHeight = int(displayHeight*0.8);
  gameHeight = int(displayHeight*0.9);
  gameWidth = int(gameHeight*10/16);

  //frustum(-8, 8, -4.5, 4.5, 3.5, 10000);
  frustum(-displayWidth/100, displayWidth/100, -displayHeight/100, displayHeight/100, 3.5, 10000);

  gameObjects = new ArrayList<ArrayList>(); //The master arrayList

  p1 = new Player (0, 0, 0);

  trailList = new ArrayList<BeamTrail>();
  deathChunkList = new ArrayList<DeathChunk>();

  trailList.add (new BeamTrail ());

  // playerList = new ArrayList <Player>();
  //playerList.add (p1);

  gameObjects.add (trailList);
  gameObjects.add (deathChunkList);
  // gameObjects.add (playerList);
}


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

  if (tick > 254) {
    resetGame();
    gameState = 0;
  }
  //filter (BLUR, 3);
}
