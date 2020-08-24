
class DeathChunk extends Renderable {
  DeathChunkPoint point; //location
  int life;

  DeathChunk(int x, int y, int z) {
    point = new DeathChunkPoint(x, y, z);
    life = 255;
  }

  void Main() {
    point.Main();
    life--;
  }
  void render() {
    noStroke();
    fill (life);
    translate (point.x, point.y, point.z);
    box (40);
    translate (-point.x, -point.y, -point.z);
  }
}

class DeathChunkPoint extends Point3D {
  PVector v; // velocity
  DeathChunkPoint(int x, int y, int z) {
    super (x, y, z);
    this.v=PVector.random3D();
    v.mult(10);
  }

  void Main() {
    x+=v.x;
    y+=v.y;
    z+=v.z;
  }
}
