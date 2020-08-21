
class BeamTrail extends Renderable {
  //int x, y, z;
  boolean affectedByLights=false;
  ArrayList<BeamPoint> BeamPoints;
  Dasher dasher;
  color trailColor;

  BeamTrail(Dasher dasher, color trailColor) {
    this.dasher = dasher;
    BeamPoints = new ArrayList<BeamPoint>();
    this.trailColor = trailColor;
  }

  BeamTrail(Dasher dasher) {
    this.dasher = dasher;
    BeamPoints = new ArrayList<BeamPoint>();
    this.trailColor = color (50, 200, 250, 100);
  }

  //Calculates collisions TODO: Optimize for less calculations/performance boost
  //Example: Compare by axis, short circuit and skip remaining calculations if too far in 1 dimension
  void Main() {
    PVector dasherLocation = new PVector (dasher.x, dasher.y, dasher.z);
    PVector collisionEdge = dasher.lookAngle.copy();
    dasherLocation.add(collisionEdge.mult(80));
    
    

    for (BeamPoint point : BeamPoints) {
      PVector pointLocation = new PVector (point.x, point.y, point.z);
      if (dasherLocation.dist(pointLocation) <= dasher.size/2) {
        //dasher.kill();
      }
    }
  }

  void render() {
    beginShape(QUAD_STRIP);
    noStroke();
    // shininess(i+1.0);
    strokeWeight(4);
    stroke (255, 255, 255, 200);
    fill (trailColor);

    for (BeamPoint point : BeamPoints) {
      vertex(point.x, point.y, point.z+105);
      vertex(point.x, point.y, point.z-5);
    }
    endShape();
    //specular(102, 102, 102);
  }

  //Old high latency beam 
  /*
  void rendero() { //Make tilt solid
   int i = 0;
   strokeWeight(4);
   stroke (50, 200, 250, 50);
   
   BeamPoint pPoint = new BeamPoint (dasher.x, dasher.y, dasher.z, 0, new PVector (0, 0));//Previous point
   
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
   }*/
}

class BeamPoint extends Point3D {
  float tilt;
  PVector lookAngle;

  /* BeamPoint(int x, int y, int z) {
   super (x, y, z);
   this.tilt = 0;
   }*/

  BeamPoint(int x, int y, int z, float tilt, PVector lookAngle) {
    super (x, y, z);
    this.tilt = tilt;
    this.lookAngle = lookAngle.copy();

    //Optimize this later
    if (round(100+x/100) >= 0 && round(100+x/100) < 200 && round(100+y/100) >= 0 && round(100+y/100) < 200) {
      println (round(100+x/100), round(100+y/100));
      chunks[round(100+x/100)][round(100+y/100)].content.add (new Collidable (x, y, z));
    }
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
