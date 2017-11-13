// "Rhythmicosm" by wobkat
// To be used with the "Gyro + Accelerometer" interface 
// of Charlie Roberts' "Control OSC" application for iOS

import ddf.minim.*;
import ddf.minim.ugens.*;
import oscP5.*;
import netP5.*;
import processing.video.*;
OscP5 oscP5;
Minim minim;
AudioSample weav;
AudioOutput out;
AudioPlayer player;
int windowX = 1280;
int windowY = 800;
int cube = 20;
int columns = 30;
int rows = 30;
int layers = 30;
float dimension = 8;
float margin = 0;
boolean[][][] initGen;
boolean[][][] nextGen;
float accX;
float accY;
float accZ;
float xRot;
float yRot;
float zRot;
float pitch;
float roll;
float yaw;
float noiseVal;
float noiseScale=0.02; 
float framed;
PVector eye;
PVector cen;
PVector up;
//PFont myFont = createFont("Free Sans", 10);

void setup() {
  PFont myFont = createFont("Free Sans", 10);
  //size(windowX, windowY, OPENGL);
  size(1200, 800);
  
  //float frameR = map(pitch, 10 , 120, 20, 200);
  frameRate(1000);
  
  background(0);
  noStroke();
  
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  
  weav = minim.loadSample("letitbeallineed.mp3", 512);
  
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
    
  eye = new PVector(width/2, height/2, height);
  cen = new PVector(width/2, height/2, 0);
  up = new PVector(0, 1, 0); // +y axis is up
    
  //player = minim.loadFile("letiatbeatll.mp3");  
  //play the file
  //player.play();
          
  textFont(myFont);
  //isNoStroke = true;
  oscP5 = new OscP5(this,12000);
  
  initGen = new boolean[layers+2][rows+2][columns+2];
  nextGen = new boolean[layers+2][rows+2][columns+2];
   
  for (int k = 0; k < layers; k++) {
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < columns; i++) {
          initGen[k][j][i] = false;
      }
    }
  }
  
  initGen[(layers/2)][(rows/2)][(columns/2)] = true;
  initGen[(layers/6)][(rows/6)][(columns/6)] = true;
  initGen[(layers/10)][(rows/10)][(columns/10)] = true;        
  
  //initGen[(layers/2)][(rows/2)][(columns/2)+1] = true;
  //initGen[(layers/2)][(rows/2)][(columns/2)-1] = true;
  //initGen[(layers/2)][(rows/2)+1][(columns/2)] = true;
  //initGen[(layers/2)][(rows/2)-1][(columns/2)] = true;
  //initGen[(layers/2)+1][(rows/2)][(columns/2)] = true;
  //initGen[(layers/2)-1][(rows/2)][(columns/2)] = true;
}


/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/* incoming osc messages are forwarded to the oscEvent method. */
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/accelerometer")==true) {
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("fff")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      float ax = theOscMessage.get(0).floatValue();  
      float ay = theOscMessage.get(1).floatValue();
      float az = theOscMessage.get(2).floatValue();
      //println("accel values: "+ax+", "+ay+", "+az);
      accX = ax;
      accY = ay;
      accZ = az;
      return;
    }  
  } 
  if (theOscMessage.checkAddrPattern("/gyro") == true) {
    /* check if the typetag is the right one. */
    if (theOscMessage.checkTypetag("ffffff")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      float gx = theOscMessage.get(0).floatValue();  
      float gy = theOscMessage.get(1).floatValue();
      float gz = theOscMessage.get(2).floatValue();
      float pit = theOscMessage.get(3).floatValue();  
      float rol = theOscMessage.get(4).floatValue();
      float ya = theOscMessage.get(5).floatValue();
      //println("gyro values: "+xRot+", "+yRot+", "+zRot+","+pitch+","+roll+","+yaw);
      xRot = gx;
      yRot = gy;
      zRot = gz;
      pitch = pit;
      roll = rol;
      yaw = ya;
      return;
    }  
  } 
}

void draw() {
  float acceX = map(accX, 34 , 90, 0, 1000/2);
  float acceY = map(accY, 34 , 90, 0, 800/2);
  float acceZ = map(accZ, 34 , 90, 0, 400);
  
  //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  camera(accelX, accelY, accelZ, accelX, accelY, accelZ, accelX, accelY, accelZ); 
  lights();
  //println(frameRate);
  showScene();     
  updateScene();
}