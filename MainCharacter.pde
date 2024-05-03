boolean moveLeft;
boolean moveRight;
boolean moveUp;
boolean moveDown;

class MainCharacter extends Characters {
  
  float initX;
  float initY;
  
  MainCharacter(float w,float h, float cx, float cy) {
      super(w,h,cx,cy);
      this.initX = cx;
      this.initY = cy;
  }
  
  void reCenter() {
    
      if(this.initX > this.centerX) {
        this.centerX++;
      }
      if(this.initX < this.centerX) {
        this.centerX--;
      }
      if(this.initY > this.centerY) {
        this.centerY++;
      }
      if(this.initY < this.centerY) {
        this.centerY--;
      }
  }
  
  void moveLeft() {
      //this.centerX -=1;
      //float leftBound = (-1 * width / 2) + (this.characterWidth/2);
      this.centerX = constrain(this.centerX-1, -50, 50);
  }
  void moveRight() {
      //float rightBound = (width/2) - this.characterWidth;
      //this.centerX +=1;
      this.centerX = constrain(this.centerX+1, -50, 50);
  }
  void moveUp() {
      //this.centerY -=1;
      this.centerY = constrain(this.centerY-1, -50, 50);
  }
  void moveDown() {
      //this.centerY +=1;
      this.centerY = constrain(this.centerY+1, -50, 50);
  }
  
}
