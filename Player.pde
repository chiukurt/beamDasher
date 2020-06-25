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
    camera(x, y, z+230, x+lookAngle.x*30, y+lookAngle.y*30, z+200, 0, 0, -1);
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
    } else {
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
    int i = 0;
    strokeWeight(4);
    stroke (50, 200, 250, 50);

    beamPoint temp = new beamPoint (p1.x, p1.y, p1.z);

    for (beamPoint point : beamPoints) {
      if ( i > 0) {
        stroke (50, 200, 250, 50);
        for (int j = 0; j < 100; j+=5) {
          line (temp.x, temp.y, temp.z+j, point.x, point.y, point.z+j);
        }

        stroke (255, 255, 255, 100);
        line (temp.x, temp.y, temp.z-5, point.x, point.y, point.z-5);
        line (temp.x, temp.y, temp.z+105, point.x, point.y, point.z+105);
      }
      temp = point;
      i++;
    }
    strokeWeight(1);
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
