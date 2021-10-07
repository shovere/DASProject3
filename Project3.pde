import java.util.*;
import controlP5.*;
int unit = 10;
PShape coloredSquare;
PShape triangleFan;
PShape hexFan;
PShape monster;
CameraController controller = new CameraController();
//I didn't like the way camera movement worked as suggested in the p3.pdf doc
//there are two modes controlled by the radio button 
//couldn't quite figure out how to get the UI to work in 3D so the selection is a little janky
//this radio button is selected by pressing num1 or num2 on numpad/number bar
//mode 1: rotation
//this will rotate the camera about the target, as specified in the doc
//mode 2: click and grab to move
//this is where things may differ slightly, the doc seemed to suggest following the mouse to move at all times
//this produced very wacky movement that wasn't satisfying
//instead you must click and drag to move the camera relative to the target position
RadioButton cameraMovement;
ControlP5 cp5;

class CameraController {
   PVector position; 
   PVector target;
   float FOV = 50;
   float theta = 0;
   float phi = 0;
   float radius;
   int xClickedStart = -1;
   int yClickedStart = -1;
   
   ArrayList<PVector> targetList = new ArrayList<PVector>();
   int currPos = 0;
   
   int movementType;
   
   CameraController(){
     this.position = new PVector(width/2, -height/2, (height/2.0) / tan(PI*30.0 / 180.0));
     this.target = new PVector(0, 0, 0);
     this.radius = abs(target.dist(position));
     this.theta = (acos(position.y/radius)*180)/PI;
     this.phi = (acos(position.x/(radius*sin(radians(theta))))*180)/PI;
   }
   
   void Update(){
     if(movementType == 1){
       if(mousePressed == true){
         if(xClickedStart != -1 && yClickedStart != -1){
           phi += map(mouseX, xClickedStart, width-1, 0, 360);
           theta += map(mouseY, yClickedStart, height-1, 0, 179);
           position.x = target.x + radius*cos(radians(phi))*sin(radians(theta));
           position.y = target.y + radius*cos(radians(theta));
           position.z = target.z + radius*sin(radians(theta))*sin(radians(phi));
           xClickedStart = mouseX;
           yClickedStart = mouseY;
         }
         else {
           xClickedStart = mouseX;
           yClickedStart = mouseY;
         }
       }
       else {
         xClickedStart = -1;
         yClickedStart = -1;
       }
     }
     if(movementType == 0){
       phi += 1;
       position.x = target.x + radius*cos(radians(phi))*sin(radians(theta));
       position.y = target.y + radius*cos(radians(theta));
       position.z = target.z + radius*sin(radians(theta))*sin(radians(phi));
     }
     
    perspective(radians(FOV), width/(float)height, 0.1, 1000);
     
    camera(position.x, position.y, position.z, 
            target.x, target.y,target.z, 
            0, sin(radians(theta)),0);
   }
   
   void AddLookAtTarget(PVector target){
     targetList.add(target);
   }
   
   void cycleTarget(){
     this.target = targetList.get(currPos);
      position.x = target.x + radius*cos(radians(phi))*sin(radians(theta));
         position.y = target.y + radius*cos(radians(theta));
         position.z = target.z + radius*sin(radians(theta))*sin(radians(phi));
     currPos++;
     if(currPos >= targetList.size()){
         currPos = 0;
     }
   }
   
   void Zoom(float FOV){
     this.FOV += FOV*3;
   }
   
}

void setup(){
size(1600, 1000, P3D);
 monster = loadShape("monster.obj");
 
 cp5 = new ControlP5(this);
 cameraMovement = cp5.addRadioButton("Camera Movement")
                      .setPosition(200,200)
                      .setSize(40,40)
                      .setColorForeground(color(120))
                      .setColorActive(color(255))
                      .setColorLabel(color(255))
                      .setItemsPerRow(1)
                      .setSpacingColumn(50)
                      .addItem("Camera Rotate (press num1)",1)
                      .addItem("Click and Drag (press num2)",2);
                      
 cameraMovement.activate(0);
 controller.movementType = 0;
                      
 cp5.setAutoDraw(false);
 
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

  controller.AddLookAtTarget(new PVector(-unit*11, 0,0));
  controller.AddLookAtTarget(new PVector(-unit*10, 0,0));
  controller.AddLookAtTarget(new PVector(-unit*8.5, 0,0));
  controller.AddLookAtTarget(new PVector(-unit*6.2, -unit,0));
  controller.AddLookAtTarget(new PVector(-unit*4, -unit,0));
  controller.AddLookAtTarget(new PVector(0, 0,0));
  controller.AddLookAtTarget(new PVector(unit*7.5, 0,0));
}

void draw(){
  background(128);
  
  colorMode(RGB);
  for(int i = -10; i < 11; i ++){
    stroke(255);
    if(i==0)
      stroke(0,0,255);
    line(i*10,0,100, i*10,0,-100);
    if(i==0)
      stroke(255,0,0);
    line(100,0,i*10, -100,0,i*10);
  }
  
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
  translate(-unit*6.2, -unit,0);
  
  scale(unit);
  shape(triangleFan);
  popMatrix();
  
  pushMatrix();
  translate(-unit*4, -unit,0);
  
   scale(unit);
  shape(hexFan);
  popMatrix();
  
  pushMatrix();
  colorMode(RGB, 255, 255, 255);
  rotateZ(radians(180));
  monster.setStroke(false);
  monster.setFill(color(255,16,240));
  scale(0.5,0.5,1);
  shape(monster);
  popMatrix();
  
  pushMatrix();
  rotateZ(radians(180));
  translate(unit*-7.5,0,0);
  monster.setStroke(true);
  monster.setStroke(color(0,0,0));
  monster.setStrokeWeight(2.0f);
  monster.setFill(color(0,0,0,0));
  shape(monster);
  popMatrix();
  
  camera();
  cp5.draw();
  controller.Update();
  
}

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  controller.Zoom(e);
}

void keyPressed(){
  //spacebar
  if(keyCode == 32){
    controller.cycleTarget();
  }
  if(keyCode == 49){
    cameraMovement.activate(0);
    controller.movementType = 0;
  }
  if(keyCode == 50){
    cameraMovement.activate(1);
    controller.movementType = 1;
  }
  println(keyCode);
}
void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(cameraMovement)) {
    print("got an event from "+theEvent.getName()+"\t");
 }
}
