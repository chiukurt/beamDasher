// Kurt Chiu 2020-05-10
int gameHeight, gameWidth;
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
}

int a=200, b=200, c=200, d, e, f;

void draw() {
  background (0);
  stroke (200);
  fill (200);
  rect (displayWidth/2, displayHeight/2, gameWidth, gameHeight);
  camera( a, b, c, d, e, f, 0, 0, -1);
  pointLight(255, 255, 255, a, b, c);


  if (cameraDebugMode)
    camera( a+cx, b+cy, c+cz, d+cx, e+cy, f+cz, 0, 0, -1);
  else
    camera( a, b, c, d, e, f, 0, 0, -1);
  keyboardDebugControls();

  endlessFloor (3000, 100);
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
