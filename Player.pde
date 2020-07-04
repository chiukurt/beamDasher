class Player extends Renderable {
  int x, y, z;
  PVector lookAngle;

  float turnTilt = 0;
  float turnSpeed = 0;

  //Constants
  int speed = 20; // Movement speed
  float turnSpeedMax = HALF_PI/(speed*1.5);
  int turnTiltMax = 7;

  float tiltRate = 10; // Larger number = slower turn/ # of cycles to hit max

  Player(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
    lookAngle = new PVector (0, 1);
  }


  void render() {
    noStroke();
    fill (150);
    translate(x, y, z+100);
    rotateZ (lookAngle.heading());
    rotateX (turnTilt*HALF_PI/30);
    box (150);

    translate(-x, -y, -z);
  }

  void Main() {
    if (!cameraDebugMode)
      camera(
        x-lookAngle.x*140, y-lookAngle.y*140, z+320, 
        x+lookAngle.x*10, y+lookAngle.y*10, z+200, 
        0, 0, -1);

    x+=lookAngle.x*speed;
    y+=lookAngle.y*speed;
    //println (g+" "+h+" "+ i);

    //Add gradual tilt
    if (mousePressed) {
      if (turnSpeed < turnSpeedMax) {
        turnSpeed += turnSpeedMax/tiltRate;
      }


      if (mouseX<displayWidth/2) {
        lookAngle.rotate(-turnSpeed);
        if (turnTilt < turnTiltMax) {
          turnTilt += turnTiltMax/tiltRate;
        }
      } else {
        lookAngle.rotate(turnSpeed);
        if (turnTilt > -turnTiltMax) {
          turnTilt -= turnTiltMax/tiltRate;
        }
      }
    } else {
      if (turnSpeed > 0) 
        turnSpeed -= turnSpeedMax/tiltRate;
      if (turnTilt > 0)
        turnTilt -= turnTiltMax/tiltRate;
      if (turnTilt < 0)
        turnTilt += turnTiltMax/tiltRate;
    }
  }
  
}

class beamTrail extends Renderable {
  //int x, y, z;
  ArrayList<beamPoint> beamPoints;

  beamTrail() {
    beamPoints = new ArrayList<beamPoint>();
  }

  void render() { //Make tilt solid
    int i = 0;
    strokeWeight(4);
    stroke (50, 200, 250, 50);

    beamPoint pPoint = new beamPoint (p1.x, p1.y, p1.z, 0, new PVector (0, 0));//Previous point

    for (beamPoint point : beamPoints) {
      PVector tempPoint = pPoint.lookAngle.copy();
      PVector tempPoint2 = pPoint.lookAngle.copy();

      tempPoint.rotate(HALF_PI);
      tempPoint2.rotate(-HALF_PI);


      if ( i > 0) {
        stroke (50, 200, 250, 50);
        for (int j = 0; j < 100; j+=5) {
          line (
            pPoint.x+(tempPoint.x*pPoint.tilt*5)/100*-j, 
            pPoint.y+(tempPoint.y*pPoint.tilt*5)/100*-j, 
            pPoint.z+j, 
            point.x+(tempPoint.x*pPoint.tilt*5)/100*-j, 
            point.y+(tempPoint.y*pPoint.tilt*5)/100*-j, 
            point.z+j);
        }

        stroke (255, 255, 255, 100);


        line (
          pPoint.x, 
          pPoint.y, 
          pPoint.z-5, 
          point.x, 
          point.y, 
          point.z-5);


        line (
          pPoint.x+tempPoint2.x*pPoint.tilt*5, 
          pPoint.y+tempPoint2.y*pPoint.tilt*5, 
          pPoint.z+105, 
          point.x+tempPoint2.x*pPoint.tilt*5, 
          point.y+tempPoint2.y*pPoint.tilt*5, 
          point.z+105);
      }
      pPoint = point;
      i++;
    }
    strokeWeight(1);
  }
}

class beamPoint {
  int x, y, z;
  float tilt;
  PVector lookAngle;

  beamPoint(int x, int y, int z) {
    this.x=x;
    this.y=y;
    this.z=z;
    this.tilt = 0;
  }
  beamPoint(int x, int y, int z, float tilt, PVector lookAngle) {
    this.x=x;
    this.y=y;
    this.z=z;
    this.tilt = tilt;
    this.lookAngle = lookAngle.copy();
  }
}
