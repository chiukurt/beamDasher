// Kurt Chiu 2020-05-10
/*
Stroke ignores light

TODO: 
Try PShape for beam trail
https://processing.org/tutorials/pshape/

*/
int gameHeight, gameWidth;
ArrayList<ArrayList> gameObjects;
ArrayList<beamTrail> trailList;
ArrayList<Player> playerList; 
int a=200, b=200, c=500, d, e, f;
int tick;
int g=1, h=0, i=320;


Player p1;

public void settings(){
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

  trailList = new ArrayList<beamTrail>();
  trailList.add (new beamTrail ());

  // playerList = new ArrayList <Player>();
  //playerList.add (p1);

  gameObjects.add (trailList);
  // gameObjects.add (playerList);
}



void draw() {
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
    for (beamTrail trail : trailList) {
      trail.beamPoints.add(new beamPoint (p1.x, p1.y, p1.z+50, p1.turnTilt, p1.lookAngle));
    }
  }

  tick++;
  //filter (BLUR, 3);
}

void mousePressed() {
}
