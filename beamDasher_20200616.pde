// Kurt Chiu 2020-05-10
int gameHeight, gameWidth;
ArrayList<ArrayList> gameObjects;
ArrayList<beamTrail> trailList;
int a=200, b=200, c=200, d, e, f;
int tick;


Player p1;
void setup() {
  size (displayWidth, displayHeight, P3D);
  imageMode (CENTER);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(20);
  // gameWidth = int(displayWidth*0.8);
  // gameHeight = int(displayHeight*0.8);
  gameHeight = int(displayHeight*0.9);
  gameWidth = int(gameHeight*10/16);

  frustum(-8, 8, -4.5, 4.5, 3.5, 10000);

  gameObjects = new ArrayList<ArrayList>(); //The master arrayList



  trailList = new ArrayList<beamTrail>();
  trailList.add (new beamTrail ());

  gameObjects.add (trailList);

  p1 = new Player (0, 0, 0);
}



void draw() {
  background (0);

  //stroke (200);
  //fill (200);
  //rect (displayWidth/2, displayHeight/2, gameWidth, gameHeight);
  //camera( a, b, c, d, e, f, 0, 0, -1);

  // Change to have trail always be light  lights() during trail render
  pointLight(255, 255, 255, p1.x, p1.y, p1.z+100);

  if (cameraDebugMode)
    camera( a+cx, b+cy, c+cz, d+cx, e+cy, f+cz, 0, 0, -1);
  keyboardDebugControls();



  objectListTraverseMain(gameObjects);
  objectListTraverseRender(gameObjects);
  p1.Main();

  if (tick%2==0)
  {
    for (beamTrail trail : trailList) {
      trail.beamPoints.add(new beamPoint (p1.x, p1.y, p1.z+50));
    }
  }

  tick++;
  //filter (BLUR, 3);
}

void mousePressed() {
}



void endlessFloor (int radius, int boxsize) {
  noStroke();
  for (int i=int(a)-radius; i < b + radius; i+=boxsize) {
    for (int j=int(a)-radius; j < b + radius; j+=boxsize) {

      fill(120);
      if ((i % (boxsize*2) >= boxsize) || (i % (boxsize*2) <= -boxsize))
        if ((j % (boxsize*2) >= boxsize) || (j % (boxsize*2) <= -boxsize))
          fill (100);

      if (!((i % (boxsize*2) >= boxsize) || (i % (boxsize*2) <= -boxsize)))
        if (!((j % (boxsize*2) >= boxsize) || (j % (boxsize*2) <= -boxsize)))
          fill (100);

      rect (round((i/boxsize)*boxsize), round((j/boxsize)*boxsize), boxsize, boxsize);
    }
  }
}
