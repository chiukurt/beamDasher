class Dasher extends Renderable {
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
  //Used to stop death animation after certain threshhold
  int deathTimer;
  final int deathTimerMax = 100;

  float zvel=0;

  boolean hasJumped = false;

  color trailColor;

  BeamTrail beamTrail; 

  Dasher(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
    lookAngle = new PVector (1, 0);
    beamTrail = new BeamTrail(this);

    trailList.add(beamTrail);
  }


  void render() {

    if (alive) {

      translate(round(x), round(y), round(z+100));
      rotateZ (lookAngle.heading());
      rotateX (round(turnTilt*HALF_PI/30.0));
      noStroke();
      fill (150);
      box (size);

      rotateX (-round(turnTilt*HALF_PI/30.0));
      rotateZ (-lookAngle.heading());
      translate(-round(x), -round(y), -round(z+100));
      
    } else if (deathTimer < deathTimerMax) {
      deathTimer++;
      if (tick%3==0)
        deathChunkList.add(new DeathChunk(x, y, z));

      //Optimize death animation 
      for (DeathChunk chunk : deathChunkList) {
        if (chunk.life > 0) {
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
      translate(-x, -y, -z-100);
    }
  }

  void kill() {
    alive = false;
  }

  void Main() {
    if (alive) {
      //Controls, movement, jumping
      x+=lookAngle.x*speed;
      y+=lookAngle.y*speed;

      if (turnSpeed < turnGoal) 
        turnSpeed += turnSpeedMax/tiltRate;
      else
        turnSpeed -= turnSpeedMax/tiltRate;

      if (tick%2==0)
        beamTrail.BeamPoints.add(new BeamPoint (round(x), round(y), z+50, turnTilt, lookAngle));


      if (x>arenaRadius || x<-arenaRadius || y>arenaRadius || y<-arenaRadius) 
        kill();
    }
  }
}
