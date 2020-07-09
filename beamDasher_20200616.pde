// Kurt Chiu 2020-05-10
/*
Stroke ignores light
 
 TODO: 
 Try PShape for beam trail
 https://processing.org/tutorials/pshape/
 
 */
int gameHeight, gameWidth;
ArrayList<ArrayList> gameObjects;
ArrayList<BeamTrail> trailList;
ArrayList<DeathChunk> deathChunkList;
ArrayList<Player> playerList; 
int a=200, b=200, c=500, d, e, f;
int tick;
int g=1, h=0, i=320;


Player p1;

public void settings() {
  //480*800 ideally
  size (displayWidth, displayHeight, P3D);
}

void setup() {
  resetGame();
}


void draw() {
  switch (gameState) {
  case 0:
    menuLoop();
    break;
  case 1:
    gameLoop();
    break;
  case 2:
    deathLoop();
    break;
  default:
  }
}

void mousePressed() {
}
