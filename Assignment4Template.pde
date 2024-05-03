boolean GAMEOVER = false;

PVector stars[];
MainCharacter mc;
Enemies e1;
Enemies e2;
Enemies e3;
Enemies e4;
Enemies e5;
Enemies e6;
Enemies e7;
Enemies e8;
ArrayList<Bullet> projectiles;
ArrayList<Enemies> enemyList;
ArrayList<Enemies> tempList;
Enemies enemies[];
int enemyShootingInterval;
PImage mcTexture;
PImage enemyTexture;
PImage attack_1_up;
PImage attack_2_up;
PImage attack_3_up;
PImage attack_4_up;

PImage attack_1_down;
PImage attack_2_down;
PImage attack_3_down;
PImage attack_4_down;

boolean level1;
boolean level2;
boolean level3;

boolean doneLevel1;
boolean doneLevel2;
boolean doneLevel3;

boolean VICTORY;

void setup() {
  //fullScreen(P3D);
  size(600, 600, P3D); // change the dimensions if desired
  //colorMode(RGB, 1.0f);
  textureMode(NORMAL); // use normalized 0..1 texture coords
  textureWrap(REPEAT);
  
  mcTexture = loadImage("MillenniumFalcon.png");
  enemyTexture = loadImage("Tie_Fighter.png");
  
  attack_1_up = loadImage("attack_1_up.png");
  attack_2_up = loadImage("attack_2_up.png");
  attack_3_up = loadImage("attack_3_up.png");
  attack_4_up = loadImage("attack_4_up.png");
  
  attack_1_down = loadImage("attack_1_down.png");
  attack_2_down = loadImage("attack_2_down.png");
  attack_3_down = loadImage("attack_3_down.png");
  attack_4_down = loadImage("attack_4_down.png");
  //resetMatrix(); // replace this with your chosen camera settings
  
  // do any additional setup here
  PVector eye = new PVector(0,0,100);
  
  camera(eye.x, eye.y, eye.z, 0, 0, 0, 0, 1, 0);
  
  float fovy = PI / 3;
  float aspect = float(width) / float(height);
  float zNear = 50;
  float zFar = 500;
  
  perspective(fovy, aspect, zNear, zFar);
  
  stars = generateStarField(20);
  mc = new MainCharacter(15,15,0,50);
  
  
  enemyList = new ArrayList<Enemies>();
  tempList = new ArrayList<Enemies>();
  projectiles = new ArrayList<Bullet>();
  
  
  level1 = false;
  level2 = false;
  level3 = false;
  
  doneLevel1 = false;
  doneLevel2 = false;
  doneLevel3 = false;
  VICTORY = false;
  
}


void draw() {

  background(0);
  
  drawStarField();
  
  if(!level1) {
     e1 = new Enemies(15,15,-30,-50,120,40,20,true, false);
     e2 = new Enemies(15,15,30,0,120,40,20,false, true);
     enemyList.add(e1);
     enemyList.add(e2);
     //enemyList.add(e3);
     level1 = true;
     enemyShootingInterval = 5000;
  }
  
  if(!level2 && doneLevel1) {
     e3 = new Enemies(15,15,25,-30,60,30,20,false, false);
     e4 = new Enemies(15,15,-25,-50,60,30,20,true, false);
     e5 = new Enemies(15,15,0,25,60,30,0,false, true);
     enemyList.add(e3);
     enemyList.add(e4);
     enemyList.add(e5);
     level2 = true;
     enemyShootingInterval = 3000;
  }
  
  if(!level3 && doneLevel2) {
     e6 = new Enemies(15,15,0,-50,30,30,0,true, false);
     e7 = new Enemies(15,15,25,25,30,30,0,true, true);
     e8 = new Enemies(15,15,-25,25,30,30,0,true, true);
     enemyList.add(e6);
     enemyList.add(e7);
     enemyList.add(e8);
     level3 = true;
     enemyShootingInterval = 1500;
  }
  
  if(!GAMEOVER) {
    
  
    mc.drawCharacter();
    drawEnemies();
    
    moveProjectiles();
    checkProjectiles();
    
    enemiesMove();
    enemiesAttack();
    
    checkColisions();
    
    if(moveLeft) {
      mc.moveLeft();
    }
    if(moveRight) {
      mc.moveRight();
    }
    if(moveUp) {
      mc.moveUp();
    }
    if(moveDown) {
      mc.moveDown();
    }
    if(!moveLeft && !moveRight && !moveUp && !moveDown) {
       mc.reCenter(); 
    }
    if(shoot) {
       Bullet tempBullet = new Bullet(10,10,mc.centerX,mc.centerY, true);
       projectiles.add(tempBullet);
       shoot = false;
    }
  }
  else if(VICTORY) {
      fill(0, 255, 0);
      textSize(12); // Set text size
      textAlign(CENTER, CENTER);
      text("VICTORY!", 0, 0);
  }
  else {
      fill(255, 0, 0);
      textSize(12); // Set text size
      textAlign(CENTER, CENTER);
      text("GAME OVER!", 0, 0);
  }
  
}

PVector[] generateStarField(int numberOfStars) {
  
  PVector points[] = new PVector[numberOfStars];
  
  for(int i = 0; i < numberOfStars; i++) {
      float randomX = random(-200, 200);
      float randomY = random(-200, 200);
      PVector point = new PVector(randomX, randomY, -300);
      points[i] = point;
  }
  
  return points;
}

void drawStarField() {
    fill(255); // Set fill color to black
    stroke(255); // Set stroke color to black
    strokeWeight(5); // Set stroke weight for visibility
    
    for(int i = 0; i < stars.length; i++) {
       point(stars[i].x, stars[i].y, stars[i].z); 
    }
}

void moveProjectiles() {
   for(Bullet bullet : projectiles) {
        bullet.move();
        bullet.drawCharacter();
   }
  
}

void checkProjectiles() {
  for(int i = 0; i < projectiles.size(); i++) {
        if(projectiles.get(i).friendly && projectiles.get(i).centerY < -100) {
           projectiles.remove(i); 
        }
        else if(!projectiles.get(i).friendly && projectiles.get(i).centerY > 100){
           projectiles.remove(i); 
        }
   }
}

void drawEnemies() {
    for(Enemies enemy : enemyList) {
       enemy.drawCharacter();
    }
}  

void enemiesMove() {

    for(int i = 0; i < enemyList.size(); i++) {
        //enemyList.get(i).move();
        enemyList.get(i).testMove();
    }
    
}




void enemiesAttack() {
   
   for(int i = 0; i <  enemyList.size(); i++) {
      if(millis() - enemyList.get(i).lastShot > enemyShootingInterval) {
          Bullet tempBullet = new Bullet(10,10,enemyList.get(i).centerX,enemyList.get(i).centerY,false);
          projectiles.add(tempBullet);
          enemyList.get(i).lastShot = millis();
      }
   }
}


void checkColisions() {

   for(Bullet bullet : projectiles) {
       float radiusSumPlayer = mc.radius + bullet.radius; 
       if(!bullet.friendly && radiusSumPlayer > dist(mc.centerX, mc.centerY, bullet.centerX, bullet.centerY)) {
            println("Player with Enemy bullet!");
            GAMEOVER = true;
        }

        for(Enemies enemy : enemyList) {
          float radiusSumEnemy = enemy.radius + bullet.radius;
          
          if(bullet.friendly && radiusSumEnemy > dist(enemy.centerX, enemy.centerY, bullet.centerX, bullet.centerY)) {
              println("Enemy with Player bullet!");
              tempList.add(enemy);
          }
          
          //float enemyPlayerRadius = enemy.radius + mc.radius;
          //if(enemyPlayerRadius > dist(enemy.centerX, enemy.centerY, mc.centerX, mc.centerY)) {
          //    println("CRASH! BANG! WHERE DO YOU?");
          //    GAMEOVER = true;
          //}
        }
        for(Enemies enemy: tempList) {
           enemyList.remove(enemy);
           if(enemyList.isEmpty()) {
               print("test");
               handleLevelProgression();
           }
        }
        tempList.clear();
   }
   
   for(int i = 0; i < projectiles.size(); i++) {
      for(int j = i+1; j < projectiles.size(); j++) {
         Bullet a = projectiles.get(i);
         Bullet b = projectiles.get(j);
         float bulletBulletRadius = a.radius + b.radius;
         
         if(a.friendly != b.friendly && bulletBulletRadius > dist(a.centerX, a.centerY, b.centerX, b.centerY)) {
             println("Opposite Bullets Collided!");
             GAMEOVER = true;
         }
         
      }
   
   }
   
   for(Enemies enemy : enemyList) {
       float enemyPlayerRadius = enemy.radius + mc.radius;
          if(enemyPlayerRadius > dist(enemy.centerX, enemy.centerY, mc.centerX, mc.centerY)) {
              println("CRASH! BANG! WHERE DO YOU?");
              GAMEOVER = true;
          }
   }

}

void handleLevelProgression() {
    if(!doneLevel1) {
       doneLevel1 = true; 
    }
    else if(!doneLevel2) {
       doneLevel2 = true; 
    }
    else if(!doneLevel3) {
       doneLevel3 = true;
       GAMEOVER = true;
       VICTORY = true;
    }
}
