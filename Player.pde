class Player extends Dasher {

  Player(int x, int y, int z) {
    super(x, y, z);
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

    if (pmouseY - mouseY > displayHeight/10 && z == 0) {
      zvel= 20;
    }

    z+=zvel;  //Boundary collision
    if (alive && x>arenaRadius || x<-arenaRadius || y>arenaRadius || y<-arenaRadius) {
      kill();
      gameState = 2;
    }

    //Set to player viewpoint
    if (!cameraDebugMode)
      camera(
        x-lookAngle.x*140, y-lookAngle.y*140, z+320, 
        x+lookAngle.x*10, y+lookAngle.y*10, z+200, 
        0, 0, -1);

    if (mousePressed && mouseDoubleClicked && speed < speedMax) {
      speed++;
    } else if (!mousePressed && speed > speedMin)
      speed--;

    //Perspective warp on speed boost
    frustum(-displayWidth/100, displayWidth/100, -displayHeight/100, displayHeight/100, 4-speed/20.0, arenaRadius*2);

    //Turning
    turnGoal = turnSpeedMax*abs((displayWidth/2-mouseX)/(displayWidth/2.0));

    super.Main();


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
  

  void kill() {
    super.kill();
    gameState=2;
    tick=0;
  }
}
