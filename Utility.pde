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
    mainObjectsPerType (objectTypeList);
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

  endlessFloor (10000, 100);
  popMatrix();
}

void mainObjectsPerType (ArrayList<Renderable> objectTypeList) {
  for (Renderable itemToRender : objectTypeList) {
    if (itemToRender.enabled) 
      itemToRender.Main();
  }
}
