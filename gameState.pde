
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
  frustum(-displayWidth/100, displayWidth/100, -displayHeight/100, displayHeight/100, 3.5, arenaRadius*2);

  gameObjects = new ArrayList<ArrayList>(); //The master arrayList

  chunks = new Chunk[2*arenaRadius/100][2*arenaRadius/100];
  for (int i = 0; i < 2*arenaRadius/100; i++)
    for (int j = 0; j < 2*arenaRadius/100; j++)
      chunks[i][j]=new Chunk();



  trailList = new ArrayList<BeamTrail>();
  deathChunkList = new ArrayList<DeathChunk>();
  dasherList = new ArrayList<Dasher>();
  p1 = new Player (0, 0, 0);
  dasherList.add (p1);

  for (int i = 1; i < 4; i++)
    dasherList.add (new Dasher (0, i*2000, 0));

  // playerList = new ArrayList <Player>();
  //playerList.add (p1);

  gameObjects.add (trailList);
  gameObjects.add (deathChunkList);
  gameObjects.add (dasherList);
  // gameObjects.add (playerList);
}

void menuLoop() {
  //Placeholder
  if (gameState != 1)
    gameState=1;
}

void gameLoopRender() {
  pointLight(255, 255, 255, p1.x, p1.y, p1.z+200);
  background (0);
  if (cameraDebugMode) {
    noLights();
    camera(a+cx, b+cy, c+cz, d+cx, e+cy, f+cz, 0, 0, -1);
  }

  objectListTraverseRender(gameObjects);
}

void gameLoopMain() {
  // Change to have trail always be light  lights() during trail render
  tick++;
  keyboardDebugControls();

  objectListTraverseMain(gameObjects);
}

void deathLoop() {
  tick++;
  if (tick > 100) {
    resetGame();
    gameState = 0;
  }
}
