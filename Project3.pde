import java.util.*;
int unit = 10;
int theta = 110;
float phi = 120;
float radius = 200;
PShape coloredSquare;
PShape triangleFan;
PShape hexFan;

class cameraController {
   PVector position; 
   PVector target;
   ArrayList<PVector> targetList = new ArrayList<PVector>();
   int currPos = 0;
   cameraController(PVector position, PVector target){
     this.position = new PVector(position.x, position.y, position.z);
     this.target = new PVector(target.x, target.y, target.z); 
     AddLookAtTarget(this.target);
   }
   void Update(){
     camera(position.x, position.y, position.z, target.x, target.y,target.z, 0,1,0);
   }
   void AddLookAtTarget(PVector target){
     targetList.add(target);
   }
   void cycleTarget(){
     this.target = targetList.get(currPos);
     currPos++;
     if(currPos >= targetList.size()){
         currPos = 0;
     }
   }
   void Zoom(float FOV){
     perspective(radians(FOV), width/(float)height, 0.1, 1000);
   }
   
}

void setup(){
size(1600, 1000, P3D);
perspective(radians(50.0f), width/(float)height, 0.1, 1000);

coloredSquare = createShape();
coloredSquare.beginShape(TRIANGLE);
   coloredSquare.fill(color(255,0,0));
   coloredSquare.vertex(unit/2, unit/2, unit/2);
   coloredSquare.vertex(-unit/2, unit/2, unit/2);
   coloredSquare.vertex(-unit/2, -unit/2, unit/2);
   
   coloredSquare.fill(color(0,255,0));
   coloredSquare.vertex(unit/2, -unit/2, unit/2);
   coloredSquare.vertex(unit/2, unit/2, unit/2);
   coloredSquare.vertex(-unit/2, -unit/2, unit/2);
   
   coloredSquare.fill(color(0,0,255));
   coloredSquare.vertex(-unit/2, -unit/2, unit/2);
   coloredSquare.vertex(-unit/2, -unit/2, -unit/2);
   coloredSquare.vertex(unit/2, -unit/2, unit/2);
   
   coloredSquare.fill(color(255,255,0));  
   coloredSquare.vertex(-unit/2, -unit/2, -unit/2);
   coloredSquare.vertex(unit/2, -unit/2, unit/2);
   coloredSquare.vertex(unit/2, -unit/2, -unit/2);
   
  coloredSquare. fill(color(0,255,255));
   coloredSquare.vertex(unit/2, -unit/2, unit/2);
   coloredSquare.vertex(unit/2, unit/2, -unit/2);
   coloredSquare.vertex(unit/2, unit/2, unit/2);
   
   coloredSquare.fill(color(255,0,255));
   coloredSquare.vertex(unit/2, -unit/2, -unit/2);
   coloredSquare.vertex(unit/2, -unit/2, unit/2);
   coloredSquare.vertex(unit/2, unit/2, -unit/2);
   
   coloredSquare.fill(color(128,128,128)); 
   coloredSquare.vertex(-unit/2,-unit/2, -unit/2);
   coloredSquare.vertex(unit/2, -unit/2, -unit/2);
   coloredSquare.vertex(unit/2, unit/2, -unit/2);
   
   coloredSquare.fill(color(128,0,0)); 
   coloredSquare.vertex(-unit/2, -unit/2, -unit/2);
   coloredSquare.vertex(-unit/2, unit/2, -unit/2);
   coloredSquare.vertex(unit/2, unit/2, -unit/2);
   
   coloredSquare.fill(color(0,128,0)); 
   coloredSquare.vertex(-unit/2, -unit/2, -unit/2);
   coloredSquare.vertex(-unit/2, unit/2, -unit/2);
   coloredSquare.vertex(-unit/2, unit/2, unit/2);
   
   coloredSquare.fill(color(0,0,128)); 
   coloredSquare.vertex(-unit/2, -unit/2, -unit/2);
   coloredSquare.vertex(-unit/2, -unit/2, unit/2);
   coloredSquare.vertex(-unit/2, unit/2, unit/2);
   
   coloredSquare.fill(color(128,128,0)); 
   coloredSquare.vertex(-unit/2, unit/2, unit/2);
   coloredSquare.vertex(-unit/2, unit/2, -unit/2);
   coloredSquare.vertex(unit/2, unit/2, unit/2);
   
   coloredSquare.fill(color(0,128,64)); 
   coloredSquare.vertex(-unit/2, unit/2, -unit/2);
   coloredSquare.vertex(unit/2, unit/2, unit/2);
   coloredSquare.vertex(unit/2, unit/2, -unit/2);
 
coloredSquare.endShape(); 

triangleFan = createShape();
triangleFan.beginShape(TRIANGLE);
  colorMode(HSB, 360, 100,100);
  for(int i =1; i< 21; i++){
    triangleFan.fill(color(360,100,100));
    triangleFan.vertex(1,0);
    triangleFan.fill(color(18*(i), 100, 100));
    triangleFan.vertex(cos(radians(18*i)), sin(radians(18*i)));
    triangleFan.fill(color(18*(i+1), 100, 100));
    triangleFan.vertex(cos(radians(18*(i+1))), sin(radians(18*(i+1))));
  }
triangleFan.endShape();

hexFan = createShape();
hexFan.beginShape(TRIANGLE);
  colorMode(HSB, 360, 100,100);
  for(int i =1; i < 5; i++){
    hexFan.fill(color(360,100,100));
    hexFan.vertex(1,0);
    hexFan.fill(color(60*i, 100, 100));
    hexFan.vertex(cos(radians(60*i)), sin(radians(60*i)));
    hexFan.fill(color(60*(i+1), 100, 100));
    hexFan.vertex(cos(radians(60*(i+1))), sin(radians(60*(i+1))));
  }
hexFan.endShape();

camera(0,0, (height/2.0) / tan(PI*30.0 / 180.0), 0, 0, 0, 0, 1, 0);

}

void draw(){
   lights();
  background(0);
  camera(radius*cos(radians(phi))*sin(radians(theta)),radius*cos(radians(theta)), radius*sin(radians(theta)*sin(radians(phi))), // eyeX, eyeY, eyeZ
         0.0, 0, 0.0, // centerX, centerY, centerZ
         0.0,sin(radians(theta)),0); // upX, upY, upZ
  
  for(int i = -10; i < 11; i ++){
    colorMode(RGB);
    stroke(255);
    if(i==0)
      stroke(0,0,255);
    line(i*10,0,100, i*10,0,-100);
    if(i==0)
      stroke(255,0,0);
    line(100,0,i*10, -100,0,i*10);
  }
  //theta++;
  //phi++;
  pushMatrix();
    translate(-unit*10, 0,0);
   shape(coloredSquare);
  popMatrix();
  
  pushMatrix();
   translate(-unit*11, 0,0);
   scale(.1);
   shape(coloredSquare);
  popMatrix();
  
  pushMatrix();
   translate(-unit*8.5, 0,0);
   scale(1.5,3,1.5);
   shape(coloredSquare);
  popMatrix();
  
  pushMatrix();
  translate(-unit*6.2, -unit*1,0);
  
  scale(unit);
  shape(triangleFan);
  popMatrix();
  
  pushMatrix();
  translate(-unit*4, -unit*1,0);
  
   scale(unit);
  shape(hexFan);
  popMatrix();
}
