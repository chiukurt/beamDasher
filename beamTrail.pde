
class BeamTrail extends Renderable {
  //int x, y, z;
  boolean affectedByLights=false;
  ArrayList<BeamPoint> BeamPoints;

  BeamTrail() {
    BeamPoints = new ArrayList<BeamPoint>();
  }

  //Calculates collisions TODO: Optimize for less calculations/performance boost
  void Main() {
    PVector playerLocation = new PVector (p1.x, p1.y);
    PVector collisionEdge = p1.lookAngle.copy();
    playerLocation.add(collisionEdge.mult(80));

    for (BeamPoint point : BeamPoints) {
      PVector pointLocation = new PVector (point.x, point.y);
      if (playerLocation.dist(pointLocation) <= p1.size/2) {
        p1.kill();
      }
    }
  }

  void render() {
    beginShape(QUAD_STRIP);
    noStroke();
    // shininess(i+1.0);
    strokeWeight(4);
    stroke (255, 255, 255, 200);
    fill (50, 200, 250, 100);

    for (BeamPoint point : BeamPoints) {
      vertex(point.x, point.y, point.z+105);
      vertex(point.x, point.y, point.z-5);
    }
    endShape();
    //specular(102, 102, 102);
  }


  void rendero() { //Make tilt solid
    int i = 0;
    strokeWeight(4);
    stroke (50, 200, 250, 50);

    BeamPoint pPoint = new BeamPoint (p1.x, p1.y, p1.z, 0, new PVector (0, 0));//Previous point

    for (BeamPoint point : BeamPoints) {
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

class BeamPoint extends Point3D {
  float tilt;
  PVector lookAngle;

  BeamPoint(int x, int y, int z) {
    super (x, y, z);
    this.tilt = 0;
  }
  BeamPoint(int x, int y, int z, float tilt, PVector lookAngle) {
    super (x, y, z);
    this.tilt = tilt;
    this.lookAngle = lookAngle.copy();
  }
}

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

class Point3D {
  int x, y, z;
  Point3D(int x, int y, int z) {
    this.x=x;
    this.y=y;
    this.z=z;
  }
}
