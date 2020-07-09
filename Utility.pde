class Renderable extends Object {
  boolean enabled=true;
  void render() {
  }
  void Main() {
  }
}

void objectListTraverseRender(ArrayList<ArrayList> gameObjects) {
  for (ArrayList objectTypeList : gameObjects) {
    renderObjectsPerType (objectTypeList);
  }
}

void objectListTraverseMain(ArrayList<ArrayList> gameObjects) {
  for (ArrayList objectTypeList : gameObjects) {
    MainObjectsPerType (objectTypeList);
  }
}

ArrayList<Renderable> CleanObjectList  (ArrayList<Renderable> objectTypeList) {
  ArrayList<Renderable> cleanedList = new ArrayList<Renderable>();
  for (Renderable itemToPreserve : objectTypeList) 
    if (itemToPreserve.enabled) 
      cleanedList.add(itemToPreserve);
  return cleanedList;
}

void renderObjectsPerType (ArrayList<Renderable> objectTypeList) {
  pushMatrix();

  translate (p1.x, p1.y, p1.z);
  //rotateZ (p1.lookAngle.heading());
  // rotateX (p1.turnTilt*HALF_PI/30);
  translate (-p1.x, -p1.y, -p1.z);

  // Rotate based on player facing 
  //rotateZ(p1.turnTilt);

  for (Renderable itemToRender : objectTypeList) {
    if (itemToRender.enabled) {
      itemToRender.render();
    }
  }

  endlessFloor (10000, 1500);
  popMatrix();
}

void MainObjectsPerType (ArrayList<Renderable> objectTypeList) {
  for (Renderable itemToRender : objectTypeList) {
    if (itemToRender.enabled) 
      itemToRender.Main();
  }
}

void endlessFloor (int radius, int boxsize) {
  //noStroke();
  strokeWeight(3);
  stroke (100);
  for (int i=int(a)-radius; i < b + radius; i+=boxsize) {
    for (int j=int(a)-radius; j < b + radius; j+=boxsize) {

      fill(50);
      if ((i % (boxsize*2) >= boxsize) || (i % (boxsize*2) <= -boxsize))
        if ((j % (boxsize*2) >= boxsize) || (j % (boxsize*2) <= -boxsize))
          fill (50);

      if (!((i % (boxsize*2) >= boxsize) || (i % (boxsize*2) <= -boxsize)))
        if (!((j % (boxsize*2) >= boxsize) || (j % (boxsize*2) <= -boxsize)))
          fill (50);

      rect (round((i/boxsize)*boxsize), round((j/boxsize)*boxsize), boxsize, boxsize);
    }
  }
}
