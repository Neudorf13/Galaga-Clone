class Characters {
  
    float characterWidth;
    float characterHeight;
    float centerX;
    float centerY;
    float radius;
    
    Characters(float w,float h, float cx, float cy) {
        this.characterWidth = w;
        this.characterHeight = h;
        this.centerX = cx;
        this.centerY = cy;
        this.radius = w/4;
    }
    
    void drawCharacter() {
      //fill(255);
      stroke(0);
      strokeWeight(2);
      
      beginShape(QUADS);
      if(this instanceof MainCharacter) {
        texture(mcTexture);
      }
      if(this instanceof Bullet) {
         
         Bullet tempBullet = (Bullet) this;
         if(tempBullet.friendly == true) {
            if(tempBullet.position == 1) {
              texture(attack_1_up);
            }
            if(tempBullet.position == 2) {
              texture(attack_2_up);
            }
            if(tempBullet.position == 3) {
              texture(attack_3_up);
            }
            if(tempBullet.position == 4) {
              texture(attack_4_up);
            }
         }
         else {
            if(tempBullet.position == 1) {
               texture(attack_1_down);
            }
            if(tempBullet.position == 2) {
               texture(attack_2_down);
            }
            if(tempBullet.position == 3) {
               texture(attack_3_down);
            }
            if(tempBullet.position == 4) {
               texture(attack_4_down);
            }
         }
         
      }
      if(this instanceof Enemies) {
         texture(enemyTexture); 
      }
      
      //texture(mcTexture);
      vertex(centerX - characterWidth/2, centerY - characterHeight/2,0,0);  //TL
      vertex(centerX + characterWidth/2, centerY - characterHeight/2,1,0);  //TR
      vertex(centerX + characterWidth/2, centerY + characterHeight/2,1,1); //BR
      vertex(centerX - characterWidth/2, centerY + characterHeight/2,0,1);  //BL
      endShape(); 
      
    }
    
    
}
