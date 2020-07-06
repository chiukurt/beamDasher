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
