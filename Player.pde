class Player {
  int x, y, z;
  PVector lookAngle;
  float turnTilt = HALF_PI;

  //Constants
  int speed = 10;
  float turnSpeed = HALF_PI/(speed*3.5);
  int turnTiltMax = 10;

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

    //Add gradual tilt
    if (mousePressed) {
      if (mouseButton == LEFT) {
        lookAngle.rotate(-turnSpeed);
        turnTilt = turnTiltMax;
      }
      if (mouseButton == RIGHT) {
        lookAngle.rotate(turnSpeed);
        turnTilt = -turnTiltMax;
      }
    }
    else {
    turnTilt = 0;
    }
  }
}

class beamTrail extends Renderable {
  int x, y, z;
  ArrayList<beamPoint> beamPoints;

  beamTrail() {
    beamPoints = new ArrayList<beamPoint>();
  }

  void render() {
    for (beamPoint point : beamPoints) {
      translate (point.x, point.y, point.z);
      noStroke();
      fill (255);
      box (10);
      translate (-point.x, -point.y, -point.z);
    }
  }
}

class beamPoint {
  int x, y, z;

  beamPoint(int x, int y, int z) {
    this.x=x;
    this.y=y;
    this.z=z;
  }
}
