boolean[] keys = new boolean[526];
boolean cameraDebugMode=false;

int cx, cy, cz;

// placeholder, movement based on XYZ axis
// Change to movement based on player LOOK vector
void keyboardDebugControls() {
  if (keys ['O']) {
    cameraDebugMode= true;
  }
  if (!keys ['O']) {
    cameraDebugMode= false;
  }
  if (keys['W']) {
    g--;
  }
  if (keys['S']) {
    g++;
  }
  ;  
  if (keys['A']) {
    h--;
  }
  if (keys['D']) {
    h++;
  }
   if (keys['Q']) {
    i--;
  }
  if (keys['E']) {
    i++;
  }
  

  /*
  if (keys['W']) {
   dx+= (sin((float)thetaXY*(PI/180.0))*playerSpeed);
   dy+= (cos((float)thetaXY*(PI/180.0))*playerSpeed);
   }
   if (keys['S']) {
   dx-= (sin((float)thetaXY*(PI/180.0))*playerSpeed);
   dy-= (cos((float)thetaXY*(PI/180.0))*playerSpeed);
   }
   ;  
   if (keys['A']) {
   dx+= (sin(((float)(thetaXY+90)*(PI/180.0)))*playerSpeed);
   dy+= (cos(((float)(thetaXY+90)*(PI/180.0)))*playerSpeed);
   }
   if (keys['D']) {
   dx-= (sin(((float)(thetaXY+90)*(PI/180.0)))*playerSpeed);
   dy-= (cos(((float)(thetaXY+90)*(PI/180.0)))*playerSpeed);
   }
   */




  if (keys['Q'])
    cz++;
  if (keys['E'])
    cz--;
}

void keyPressed()
{ 
  keys[keyCode] = true;
}

void keyReleased()
{ 
  keys[keyCode] = false;
}
