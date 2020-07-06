
class beamTrail extends Renderable {
  //int x, y, z;
  ArrayList<beamPoint> beamPoints;

  beamTrail() {
    beamPoints = new ArrayList<beamPoint>();
  }

  void render() {

    beginShape(QUAD_STRIP);
    for (beamPoint point : beamPoints) {
      strokeWeight(4);
      stroke (255, 255, 255, 200);
      fill (50, 200, 250, 50);
      // noFill();




      vertex(point.x, point.y, point.z+105);
      vertex(point.x, point.y, point.z-5);
    }
    endShape();
  }


  void rendero() { //Make tilt solid
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
