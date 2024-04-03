class Player extends AABB {

  int level = 1;
  boolean isBursting;
  float burstCD = 0;
  float numBursts = 3;

  PVector midPoint = new PVector();

  Player(float xPos, float yPos) {

    x = xPos;
    y = yPos;
    setSize(50, 50);
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

    if (rightPressed && !pRightPressed) {
      isBursting = true;
      spawnRocketBurst();
      println("fired");
    }

    if (leftPressed && !pLeftPressed) {
      Bullet b = new Bullet(x, y, angle);
      bullets.add(b);
    }

    if (Mouse.isDown(Mouse.RIGHT)) {
      println("RIGHT MOUSE");
    }

    if (Keyboard.isDown(Keyboard.Q)) {
      Bullet b = new Bullet(x, y, angle);
      bullets.add(b);
    }

    //velocity
    x += velocity.x * dt;
    y += velocity.y * dt;

    //friction
    velocity.x *= .95;
    velocity.y *= .95;

    super.update();
  }

  void draw() {
    fill(#FF347E);
    pushMatrix();
    noStroke();
    translate(x, y);
    rotate(angle);
    rect(-halfW, -halfH, w, h);
    popMatrix();
  }

  void spawnRocketBurst() {
    if (isBursting) {

      if (burstCD <= 0) {
        numBursts--;
        if (numBursts > 0) {
          //spawn

          println("is Spawing");
          for (int i = 00; i < 3; i++) {
            Rocket r = new Rocket(x, y, angle);
            rockets.add(r);
            println("Rocket Spawned");
          }
          burstCD = 0.35;
        } else {
          numBursts = 3;
          isBursting = false;
          println("Rocket Reset");
        }
      }
    }
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
