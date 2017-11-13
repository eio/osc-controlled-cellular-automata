int isLive(int k, int j, int i) {
  if (initGen[k][j][i] == true) {
    return 1;
  } else {
    return 0;
  }
}

void updateCube(int k, int j, int i) {
  int neighbors = 0;
  neighbors += isLive(k  ,j  ,i  );
  neighbors += isLive(k  ,j  ,i-1);
  neighbors += isLive(k  ,j  ,i+1);
  neighbors += isLive(k  ,j-1,i  );
  neighbors += isLive(k  ,j-1,i-1);
  neighbors += isLive(k  ,j-1,i+1);
  neighbors += isLive(k  ,j+1,i  );
  neighbors += isLive(k  ,j+1,i-1);
  neighbors += isLive(k  ,j+1,i+1);
  neighbors += isLive(k-1,j  ,i  );
  neighbors += isLive(k-1,j  ,i-1);
  neighbors += isLive(k-1,j  ,i+1);
  neighbors += isLive(k-1,j-1,i  );
  neighbors += isLive(k-1,j-1,i-1);
  neighbors += isLive(k-1,j-1,i+1);
  neighbors += isLive(k-1,j+1,i  );
  neighbors += isLive(k-1,j+1,i-1);
  neighbors += isLive(k-1,j+1,i+1);
  neighbors += isLive(k+1,j  ,i  );
  neighbors += isLive(k+1,j  ,i-1);
  neighbors += isLive(k+1,j  ,i+1);
  neighbors += isLive(k+1,j-1,i  );
  neighbors += isLive(k+1,j-1,i-1);
  neighbors += isLive(k+1,j-1,i+1);
  neighbors += isLive(k+1,j+1,i  );
  neighbors += isLive(k+1,j+1,i-1);
  neighbors += isLive(k+1,j+1,i+1);
    
  /////////////////////////////////
  /////// RULES TO LIVE BY ///////
  ///////////////////////////////

  // 1. one neighbor makes dead cells come to life
  
  if (initGen[k][j][i] == false) {
    if (neighbors == 1) {
        nextGen[k][j][i] = true;
    }
  }
    
  //if(nextGen[k][j][i] == false) {
  //  if(neighbors >= 1 && initGen[k][j][i] == true) {
  //      nextGen[k][j][i] = false;
  //  }
  //}
    
  // 2. two or more neighbors make live cells die
  
  if (initGen[k][j][i] == true) {
    if (neighbors >= 2) {
        nextGen[k][j][i]= false;
    }
  }
}
   

// turn border stroke on/off
 
void mouseClicked(){
  float Pitch = map(pitch, 10 , 120, 0, 255);
  stroke(255, 255, 255, Pitch);
  strokeWeight(2); 
}

void keyPressed() {
  noStroke();
}