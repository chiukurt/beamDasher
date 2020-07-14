class Player extends Renderable {
  int x, y, z;
  PVector lookAngle;

  float turnTilt = 0;
  float turnSpeed = 0;

  //Constants
  int speed = 20; // Movement speed
  float turnSpeedMax = HALF_PI/(speed*1.5);
  int turnTiltMax = 7;
  float turnGoal = 0; // Amount mouse is offset from center screen

  float tiltRate = 10; // Larger number = slower turn/ # of cycles to hit max

  float size=150;

  boolean alive = true;


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
    box (size);
    translate(-x, -y, -z);
  }

  void renderDeath() {
    if (tick%3==0)
      deathChunkList.add(new DeathChunk(x, y, z));
    for (DeathChunk chunk : deathChunkList) {
      if (chunk.life>0) {
        chunk.Main();
        chunk.render();
      }
    }


    noStroke();
    fill (150, 150, 150, 255-tick);
    translate(x, y, z+100);
    rotateZ (lookAngle.heading());
    rotateX (turnTilt*HALF_PI/30);
    box (size);
    translate(-x, -y, -z);
  }

  void kill() {
    gameState=2;
    tick=0;
  }

  void Main() {

    if (x>arenaRadius || x<-arenaRadius || y>arenaRadius || y<-arenaRadius)
      kill();

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
      turnGoal = turnSpeedMax*abs((displayWidth/2-mouseX)/(displayWidth/2.0));

      if (turnSpeed < turnGoal) {
        turnSpeed += turnSpeedMax/tiltRate;
      } else
        turnSpeed -= turnSpeedMax/tiltRate;


      if (mouseX<displayWidth/2) {
        lookAngle.rotate(-turnSpeed);
        if (turnTilt < turnGoal) {
          turnTilt += turnTiltMax/tiltRate;
        }
      } else {
        lookAngle.rotate(turnSpeed);
        if (turnTilt > -turnGoal) {
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
