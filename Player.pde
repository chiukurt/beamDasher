class Player extends Renderable {
  int x, y, z;
  PVector lookAngle;

  float turnTilt = 0;
  float turnSpeed = 0;

  //Constants
  int speed = 20; // Movement speed
  final int speedMax = 40;
  final int speedMin = 20;
  final float size=150;

  final float turnSpeedMax = HALF_PI/(speed*1.5);
  final int turnTiltMax = 7;
  final float tiltRate = 10; // Larger number = slower turn/ # of cycles to hit max
  float turnGoal = 0; // Amount mouse is offset from center screen

  boolean alive = true;

  float zvel;

  boolean hasJumped = false;


  Player(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
    lookAngle = new PVector (0, 1);
  }


  void render() {

    translate(round(x), round(y), round(z+100));
    rotateZ (lookAngle.heading());
    rotateX (round(turnTilt*HALF_PI/30.0));
    noStroke();
    fill (150);
    box (size);


    translate (-90, h, g+234);
    println (i+" "+h+" "+(g+100));
    rotateZ  (HALF_PI);
    rotateX (-HALF_PI+PI*30/180.0);
    noLights();
    stroke(255);
    fill(255);
    textSize(32);

    text ("Testing123123123", 0, 0, 0);
    text ("456456456Testing", 0, 0, -100);
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
    //gameState=2;
    // tick=0;
  }

  void Main() {
    //Controls, movement, jumping

    //Jumping
    if (z>0)
      zvel--;
    if (z<=0) {
      zvel = 0;
      z=0;
    }

    if (pmouseY - mouseY > displayHeight/10) {
      zvel= 20;
    }

    /* doubleclick jump
     if (mouseDoubleClicked) {
     zvel= 20;
     hasJumped=true;
     mouseDoubleClicked = false;
     }*/

    z+=zvel;


    //Boundary collision
    if (x>arenaRadius || x<-arenaRadius || y>arenaRadius || y<-arenaRadius)
      kill();

    //Set to player viewpoint
    if (!cameraDebugMode)
      camera(
        x-lookAngle.x*140, y-lookAngle.y*140, z+320, 
        x+lookAngle.x*10, y+lookAngle.y*10, z+200, 
        0, 0, -1);

    x+=lookAngle.x*speed;
    y+=lookAngle.y*speed;
    //println (g+" "+h+" "+ i);

    //Add gradual tilt
    //if (mousePressed) {

    if (mousePressed && mouseDoubleClicked && speed < speedMax) {
      speed++;
    } else if (!mousePressed && speed > speedMin)
      speed--;

    /* Left click acceleration
     //Acceleration
     if (mouseButton == LEFT && speed < speedMax) 
     speed++;
     else if (mouseButton != LEFT && speed > speedMin)
     speed--;
     */

    //Perspective warp on speed boost
    frustum(-displayWidth/100, displayWidth/100, -displayHeight/100, displayHeight/100, 4-speed/20.0, arenaRadius*2);


    //Turning
    turnGoal = turnSpeedMax*abs((displayWidth/2-mouseX)/(displayWidth/2.0));

    if (turnSpeed < turnGoal) 
      turnSpeed += turnSpeedMax/tiltRate;
    else
      turnSpeed -= turnSpeedMax/tiltRate;

    if (mouseX<displayWidth/2) {
      lookAngle.rotate(-turnSpeed);
      if (turnTilt < turnGoal) 
        turnTilt += turnTiltMax/tiltRate;
    } else {
      lookAngle.rotate(turnSpeed);
      if (turnTilt > -turnGoal) {
        turnTilt -= turnTiltMax/tiltRate;
      }
    }
  }
}
