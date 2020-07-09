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
ArrayList<Player> playerList; 
int a=200, b=200, c=500, d, e, f;
int tick;
int g=1, h=0, i=320;


Player p1;

public void settings() {
  //480*800
  size (displayWidth, displayHeight, P3D);
}

void setup() {
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
  trailList.add (new BeamTrail ());

  // playerList = new ArrayList <Player>();
  //playerList.add (p1);

  gameObjects.add (trailList);
  // gameObjects.add (playerList);
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
