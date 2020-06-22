class Player {
  int x, y, z;
  PVector lookAngle;
  int speed = 10;
  float turnSpeed = HALF_PI/(speed*3.5);

  Player(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
    lookAngle = new PVector (1, 1);
  }

  void Main() {
    camera(x, y, z+250, x+lookAngle.x*50, y+lookAngle.y*50, z+200, 0, 0, -1);
    x+=lookAngle.x*speed;
    y+=lookAngle.y*speed;

    if (mousePressed) {
      if (mouseButton == LEFT) {
        lookAngle.rotate(-turnSpeed);
      }
      if (mouseButton == RIGHT) {
        lookAngle.rotate(turnSpeed);
      }
    }
  }
}

class beamTrail extends Renderable {
  int x, y, z;

  beamTrail(int x, int y, int z) {
    this.x=x;
    this.y=y;
    this.z=z;
  }

  void render() {
    translate (x,y,z);
    noStroke();
    fill (255);
    box (10);
    translate (-x,-y,-z);
  }
}
