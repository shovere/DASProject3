import java.util.*;

class camera {
   PVector position; 
   PVector target;
   PVector cameraUp;
   ArrayList<PVector> targetList = new ArrayList<PVector>();
   int currPos = 0;
   camera(PVector position, PVector target, PVector cameraUp){
     this.position = new PVector(position.x, position.y, position.z);
     this.target = new PVector(target.x, target.y, target.z); 
     this.cameraUp = new PVector(cameraUp.x, cameraUp.y, cameraUp.z);
     AddLookAtTarget(this.target);
   }
   void Update(){
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
  stroke(255);
  line(100, 100, 0, -100, -100,0);
}

void draw(){
   stroke(255);
  line(100, 100, 0, -100, -100,0);
}
