class Player extends AABB {

  int level = 1;
  boolean isBursting;
  boolean hasShotgun = false;
  boolean hasRifle = false;

  float burstCD = 0;
  float numBursts = 3;
  float shotGunCD = .40;
  float rifleCD = .13;
  float playerHealth;

  PVector location = new PVector();



  int invItem = 0;

  final int PISTOL = 0;
  final int SHOTGUN = 1;
  final int RIFLE = 2;


  PVector midPoint = new PVector();

  Player(float xPos, float yPos) {

    x = xPos;
    y = yPos;
    setSize(40, 40);
    playerHealth = 10;
  }

  void update() {

    calcAngleToMouse();
    burstCD -= dt;

    if (Keyboard.isDown(Keyboard.LEFT)) {
      velocity.x = - 250;
    }
    if (Keyboard.isDown(Keyboard.RIGHT)) {
      velocity.x =  250;
    }
    if (Keyboard.isDown(Keyboard.UP)) {
      velocity.y = - 250;
    }
    if (Keyboard.isDown(Keyboard.DOWN)) {
      velocity.y =  250;
    }



    switch(invItem) {
    case PISTOL:

      if (leftPressed && !pLeftPressed) {
        Bullet b = new Bullet(x, y, angle);
        scenePlay.bullets.add(b);
      }
      break;

    case SHOTGUN:
      if (scenePlay.player.hasShotgun == true) {

        shotGunCD -= dt;
        if (shotGunCD <= 0) {
          if (leftPressed && !pLeftPressed) {

            Bullet b = new Bullet(x, y, angle);
            scenePlay.bullets.add(b);

            Bullet b2 = new Bullet(x, y, angle + radians(10));
            scenePlay.bullets.add(b2);

            Bullet b3 = new Bullet(x, y, angle - radians(10));
            scenePlay.bullets.add(b3);
            shotGunCD = 0.43;
          }
        }
      }
      break;

    case RIFLE:
      if (hasRifle == true) {
        rifleCD -= dt;
        if (rifleCD <= 0) {
          if (leftPressed) {
            Bullet b = new Bullet(x, y, angle);
            scenePlay.bullets.add(b);
            rifleCD = .13;
          }
        }
      }
      break;
    }





    if (Keyboard.isDown(Keyboard.Q)) {
      Bullet b = new Bullet(x, y, angle);
      scenePlay.bullets.add(b);
    }

    if (Keyboard.isDown(Keyboard.ONE)) {
      invItem = PISTOL;
    }
    if (Keyboard.isDown(Keyboard.TWO)) {
      invItem = SHOTGUN;
    }
    if (Keyboard.isDown(Keyboard.THREE)) {
      invItem = RIFLE;
    }



    //velocity
    x += velocity.x * dt;
    y += velocity.y * dt;

    //friction
    velocity.x *= .95;
    velocity.y *= .95;

    super.update();
    pLeftPressed = leftPressed;
  }

  void draw() {
    fill(0);
    pushMatrix();
    noStroke();
    translate(x, y);
    rotate(angle);
    rect(-halfW, -halfH, w, h);
    popMatrix();
  }



  @Override void applyFix(PVector fix) {
    x += fix.x;
    y += fix.y;
    if (fix.x != 0) {
      // If we move the player left or right, the player must have hit a wall, so we set horizontal velocity to zero.
      velocity.x = 0;
    }
    if (fix.y != 0) {
      // If we move the player up or down, the player must have hit a floor or ceiling, so we set vertical velocity to zero.
      velocity.y = 0;
      if (fix.y < 0) {
        // If we move the player up, we must have hit a floor.
      }
      if (fix.y > 0) {
        // If we move the player down, we must have hit our head on a ceiling.
      }
    }
    // recalculate AABB (since we moved the object AND we might have other collisions to fix yet this frame):
    calcAABB();
  }
}

class CrossHair {

  CrossHair() {
  }

  void update() {
  }

  void draw() {
    noStroke();
    fill(0);
    ellipse(mouseX, mouseY, 8, 8);
  }
}
