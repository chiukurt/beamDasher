// Kurt Chiu 2020-05-10
/*

 Stroke ignores light
 
 TODO: 
 Try PShape for beam trail
 https://processing.org/tutorials/pshape/
 
 //Modify entity-beam collision using forward lookangle
 
 Modify collision code for efficiency
 
 Customize lighting
 
 Make a UI that follows the player camera and angle
 
 //Fix jumping collision
 
 //Handle multiple tap inputs on android to allow jumping and acceleration independant from turning
 
 //Turn double click to jump into an upwards swipe to jump
 //Turn acceleration into double tap
 
 */
int gameHeight, gameWidth;
ArrayList<ArrayList> gameObjects;
ArrayList<BeamTrail> trailList;
ArrayList<DeathChunk> deathChunkList;
ArrayList<Player> playerList; 
int a=200, b=200, c=500, d, e, f;
int tick;
int g=0, h=0, i=-1;

int arenaRadius = 10000;

final int screenL = 0;
final int screenR = displayWidth;
final int screenM = displayWidth/2;

int dblClickTimer = 20;
boolean mouseDoubleClicked = false;

Player p1;

public void settings() {
  //480*800 ideally
  size (displayWidth, displayHeight, P3D);
}

void setup() {
  resetGame();
  // smooth(4);
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
    dblClickTimer--;
  }
}

void mousePressed() {
  if (dblClickTimer > 0) 
    mouseDoubleClicked = true;
  dblClickTimer = 30;
}

void mouseReleased() {
  mouseDoubleClicked = false;
}
