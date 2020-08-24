class Chunk {
  ArrayList<Collidable> content;
  Chunk() {
    content = new ArrayList<Collidable>();
  }
}

class Collidable extends Point3D {
  //Height, width? Shape, type?
  Collidable (int x, int y, int z) {
    super (x, y, z);
  }
}

class Point3D {
  int x, y, z;
  Point3D(int x, int y, int z) {
    this.x=x;
    this.y=y;
    this.z=z;
  }
}

//Tests if x and y coordinates are within existing chunk limits
boolean chunkValid (int x, int y) {
  final int cSize = 100;
  final int cMax = 199; //array index 0~199

  if (round(cSize+x/cSize) >= 0 && round(cSize+x/cSize) < cMax 
    && round(cSize+y/cSize) >= 0 && round(cSize+y/cSize) < cMax)
    return true;  
  return false;
}
