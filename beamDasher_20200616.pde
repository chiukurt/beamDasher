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
int g=1, h=0, i=0;

final int screenL = 0;
final int screenR = displayWidth;
final int screenM = displayWidth/2;


Player p1;

public void settings() {
  //480*800 ideally
  size (displayWidth, displayHeight, P3D);
}

void setup() {
  resetGame();
}


void draw() {
  //game is paused when tabbing out
  if (focused) {
    switch (gameState) {
    case 0:
      menuLoop();
      break;
    case 1:
      gameLoopMain();
      gameLoopRender();
      break;
    case 2:
      deathLoop();
      gameLoopRender();
      break;
    default:
    }
  }
}

void mousePressed() {
}
