void showScene(){
  background(0);

  float accelX = map(accX, 34 , 90, 0, 666);
  float accelY = map(accY, 34 , 90, 0, 666);
  float accelZ = map(accZ, 34 , 90, 0, 666);
  
  float rotX = map(xRot, 30 , 70, 0, 255);
  float rotY = map(yRot, 30 , 70, 0, 700);
  float rotZ = map(zRot, 30 , 70, 0, 700);

  float Pitch = map(pitch, 10 , 120, 0, 255);
  float Roll = map(roll, 10 , 120, 0, 255);
  float Yaw = map(yaw, 10 , 120, 0, 255);
  float Peach = map(pitch, 10 , 120, 0, 360);
  float Role = map(roll, 10 , 120, 0, 360);
  float Yah = map(yaw, 10 , 120, 0, 360);

  pushMatrix();
  translate((width-xRot)/2, height/2, accelX);
  //int r = 4000;
  float r = frameCount * 0.02;
  rotateY(Peach + HALF_PI);
  rotateX(Role + QUARTER_PI);
  rotateZ(Yah + QUARTER_PI);
 
  for (float k = 1; k < layers-1; k += 1) {
    pushMatrix();
    for (float j = 1; j < rows-1; j += 1) {
      pushMatrix();
      for (float i = 1; i < columns-1; i += 1) {
        pushMatrix();
        translate(
          (k - (layers/2)) * dimension,
          (j - (rows/2)) * dimension,
          (i - (columns/2)) * dimension
        );
      
        ///////////////////////////////
        ///// if cell is alive... /////
        ///////////////////////////////
       
        if (initGen[int(k)][int(j)][int(i)] == true) {      
          fill(random(Pitch),random(Roll),random(Yaw),random(Pitch));       
          int radii = int(random(9));
          switch (radii) {
            case 0:
              sphere(dimension/6);
            break;
            
            case 1:
              sphere(dimension/2);
            break;
            
            case 2:
              box(dimension/2);
            break;
            
            case 3:
              box(dimension/6);
            break;
            
            case 4:
              sphere(dimension/3);
            break;
            
            case 5:
              sphere(dimension/4);
            break;
            
            case 6:
              box(dimension/3);
            break;
            
            case 7:
              sphere(dimension/5);
            break;
            
            case 8:
              box(dimension/5);
            break;
            
            case 9:
              box(dimension/4);
            break;
          }
         
          sphereDetail(5);
          int sounds = int(random(1000));
          switch (sounds) {
            case 111:
              weav.trigger();
            break;   
          }
           
          ////// VOLUME CONTROL OF INDIVIDUAL SAMPLES //////
          /////////// (similar to opacity) /////////////////
          float pitchGain = map(pitch, 10 , 120, -30, 0);
          float accelGain = map(accX, 34 , 90, -30, 0);
          // float yawGain = map(yaw, 10 , 120, -50, 0);
          weav.setGain(pitchGain  + (accelGain / 2));
        }
        popMatrix();
      }
      popMatrix();
    }
    popMatrix();
  }
  popMatrix();
}