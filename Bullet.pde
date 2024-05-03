boolean shoot;

class Bullet extends Characters {
   
   boolean friendly;
   int position;
   int traveled;
  
   Bullet(float w, float h, float cx, float cy, boolean friendly) {
      super(w,h,cx,cy);
      this.friendly = friendly;
      this.position = 1;
      this.traveled = 0;
   }
  
   
   void move() {
      if(this.friendly) {
          this.centerY--;
      }
      else {
          this.centerY++;
          if(doneLevel2) {
            this.centerY++;
          }
      }
      
      this.traveled++;
      
      if(this.traveled >= 5) {
        if(this.position == 4) {
         this.position = 1;
        }
        else {
           this.position++;
        }
        this.traveled = 0;
      }
      
      
   }
}
