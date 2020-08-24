
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

void enableLightsCustom() {
  ambientLight(50, 50, 50);
  directionalLight(128, 128, 128, 0, 0, -1);
  lightFalloff(1, 0, 0);
  lightSpecular(100, 100, 100);
}

void renderObjectsPerType (ArrayList<Renderable> objectTypeList) {
  
  pushMatrix();
  for (Renderable itemToRender : objectTypeList) {
    if (itemToRender.enabled) {
      itemToRender.render();
    }
  }
  popMatrix();
  endlessFloor (arenaRadius, 1500);

}

void MainObjectsPerType (ArrayList<Renderable> objectTypeList) {
  for (Renderable itemToRender : objectTypeList) {
    if (itemToRender.enabled) 
      itemToRender.Main();
  }
}

void endlessFloor (int radius, int boxsize) {
  noStroke();
  //strokeWeight(3);
  // stroke (100);
  for (int i=-radius; i < radius; i+=boxsize) {
    for (int j=-radius; j <  radius; j+=boxsize) {

      fill(50);
      if ((i % (boxsize*2) >= boxsize) || (i % (boxsize*2) <= -boxsize))
        if ((j % (boxsize*2) >= boxsize) || (j % (boxsize*2) <= -boxsize))
          fill (50);

      if (!((i % (boxsize*2) >= boxsize) || (i % (boxsize*2) <= -boxsize)))
        if (!((j % (boxsize*2) >= boxsize) || (j % (boxsize*2) <= -boxsize)))
          fill (50);

      rect (round((i/boxsize)*boxsize), round((j/boxsize)*boxsize), boxsize-10, boxsize-10);
    }
  }


  strokeWeight(2);
  noFill();
  stroke (255);
  rect (0, 0, radius*2, radius*2);

  pushMatrix();
  for (int i= 1; i < 11; i ++) {
    stroke (150-i*15);
    translate(0, 0, 200);
    rect (0, 0, radius*2, radius*2);
  }

  popMatrix();
}
