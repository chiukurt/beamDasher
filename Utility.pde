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
  for (Renderable itemToRender : objectTypeList) {
    if (itemToRender.enabled) {
      itemToRender.render();
    }
  }
  popMatrix();
}

void mainObjectsPerType (ArrayList<Renderable> objectTypeList) {
  for (Renderable itemToRender : objectTypeList) {
    if (itemToRender.enabled) 
      itemToRender.Main();
  }
}
