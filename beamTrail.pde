
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

  //Calculates collisions
  // Create approximation PVector of dasher location in next draw() loop
  // determinme which chunk this point resides in
  // perform distance calculations for each beamPoint in the corresponding chunk
  // If the distance is less than the size of the object, collision occurs.
  //Example: Compare by axis, short circuit and skip remaining calculations if too far in 1 dimension
  void Main() {
    if (dasher.alive) {
      PVector dasherLocation = new PVector (dasher.x, dasher.y, dasher.z);
      PVector collisionEdge = dasher.lookAngle.copy();
      dasherLocation.add(collisionEdge.mult(80));



      //Optimize this check
      //Fix hit detection; some cases miss
         if (chunkValid (int(dasherLocation.x), int(dasherLocation.y))) {

        for (Collidable beamPoint : chunks[round(100+dasherLocation.x/100)][round(100+dasherLocation.y/100)].content) {
          PVector pointLocation = new PVector (beamPoint.x, beamPoint.y, beamPoint.z);
          if (dasherLocation.dist(pointLocation) <= dasher.size/2) {
            dasher.kill();
          }
        }
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
    //If chunk is valid, save xyz coordinates into the corresponding chunk content ArrayList
    if (chunkValid(x, y)) {
      chunks[round(100+x/100)][round(100+y/100)].content.add (new Collidable (x, y, z));
    }
  }
}
