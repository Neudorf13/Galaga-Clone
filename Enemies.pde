class Enemies extends Characters {
    
    //boolean moveRight;
    int lastShot;
    float startX, targetX;
    float startY, targetY;
    
    float t;
    int frameCounter;
    int numFrames;
    
    boolean right;
    boolean up;
    
    float xTargetOffSet;
    float yTargetOffSet;
  
    Enemies(float w, float h, float cx, float cy, int numFrames, float xTargetOffSet, float yTargetOffSet, boolean right, boolean up) {  
        super(w,h,cx,cy);

        lastShot = millis();
        
        this.xTargetOffSet = xTargetOffSet;
        this.yTargetOffSet = yTargetOffSet;
        
        this.right = right;
        this.up = up;
        
        this.startX = cx;
        
        if(this.right) {
          this.targetX = cx + xTargetOffSet;
        }
        else {
          this.targetX = cx - xTargetOffSet;
        }
        
        if(this.up) {
          this.targetY = cy - yTargetOffSet;
        }
        else {
          this.targetY = cy + yTargetOffSet;
        }
        
        
        this.startY = cy;
        this.targetY = cy + yTargetOffSet;
        
        
        this.t = 0;
        this.frameCounter = 0;
        
        this.numFrames = numFrames;
    }
    

    void testMove() {
       //println(this.targetY); 
      
       if(this.t <= 1) {
          this.t = (float) this.frameCounter/this.numFrames;
          float tPrime = 0.5 * (1 - cos(PI * this.t));
          this.centerX = lerp(startX, targetX, tPrime);
          this.centerY = lerp(startY, targetY, tPrime);
          this.frameCounter++;
       }
       
       if(t >= 1) {
        this.frameCounter = 0;
        this.startX = centerX;
        this.startY = centerY;
        this.t = 0;
        if(this.right) {
           this.right = false;
           this.targetX = centerX - abs(this.xTargetOffSet);
        }
        else {
           this.right = true;
           this.targetX = centerX+ abs(this.xTargetOffSet);
           
        }
        
        if(this.up) {
            this.up = false;
            this.targetY = centerY + abs(yTargetOffSet);
        }
        else {
            this.up = true;
            this.targetY = centerY - abs(this.yTargetOffSet);
        }
        
        
     }
       
    }

   
  
}
