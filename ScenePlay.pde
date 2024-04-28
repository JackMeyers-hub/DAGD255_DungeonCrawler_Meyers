class ScenePlay {


  boolean shotGunSpawned = false;
  boolean pShotGunSpawned = false;
  boolean rifleSpawned = false;
  boolean masterCheck = true;

  float zoomAmount = 1;
  float roomCD = .5;

  Player player;

  ShotGun shotgun;
  Rifle rifle;
  CrossHair crosshair;
  Camera camera;
  HUD hud;
  Hotbar hotbar;
  HealthBar healthbar;

  ArrayList<Enemy> enemies = new ArrayList();
  ArrayList<Wall> walls = new ArrayList();
  ArrayList<Room> rooms = new ArrayList();
  ArrayList<Chest> chests = new ArrayList();
  ArrayList<HealthPack> healthpacks = new ArrayList();
  ArrayList<Door> doors = new ArrayList();
  ArrayList<Particle> particles = new ArrayList();
  ArrayList<Floor> floors = new ArrayList();
  ArrayList<Bullet> bullets = new ArrayList();
  ArrayList<Bullet> ebullets = new ArrayList();



  ScenePlay() {

    noStroke();
    noCursor();

    player = new Player(width/2, height/2);
    camera = new Camera(player);


    hud = new HUD();
    crosshair = new CrossHair();
    hotbar = new Hotbar();
    healthbar = new HealthBar(width/2, 100);
  }
  void update() {




    //println(keyCode);
    //pushMatrix here
    roomCD -= dt;
    if (roomCD <= 0 && masterCheck) {
      println("ROOM SPAWNED");
      Room r = new Room(-camera.x, -camera.y);
      rooms.add(r);
      masterCheck = false;
    }

    pushMatrix();
    translate(-camera.x, -camera.y);

    camera.update();

    for (int i = 0; i < floors.size(); i++) {
      Floor f = floors.get(i);
      f.update();
    }

    for (int i = 0; i < walls.size(); i++) {
      Wall w = walls.get(i);
      w.update();

      //IDENTIFIER HELP 1 = top, 2 = right, 3 = left, 4 = bottom.


      if (w.checkCollision(player)) {
        player.applyFix(player.findOverlapFix(w));
      }

      for (int j = 0; j < enemies.size(); j++) {
        if (w.checkCollision(enemies.get(j))) {
          enemies.get(j).applyFix(enemies.get(j).findOverlapFix(w));
          enemies.get(j).reverseTarget();
        }
      }
    }

    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.update();

      if (e.isDead) {
        enemies.remove(e);
      }
    }


    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      p.update();
    }

    for (int i = 0; i < rooms.size(); i++) {
      Room r = rooms.get(i);
      r.update();
    }

    //println(rooms.size());

    for (int i = 0; i < doors.size(); i++) {
      Door d = doors.get(i);
      d.update();
    }



    for (int i = 0; i < bullets.size(); i++) {

      Bullet b = bullets.get(i);
      b.update();
      for (int j = 0; j < enemies.size(); j++) {
        if (b.checkCollision(enemies.get(j))) {
          enemies.get(j).isDead = true;

          int numParticles = (int)random(50, 80);
          for (int k = 0; k < numParticles; k++) {
            Particle p = new Particle(b.x, b.y);
            p.angle = radians(random(359));
            p.velocity = new PVector(random(150, 500), random(150, 500));
            p.friction = 0.95;
            particles.add(p);
          }
        }
      }

      for (int j = 0; j < walls.size(); j++) {

        if (walls.get(j).identifier == 1) {
          if (bullets.get(i).checkCollision(walls.get(j))) {
            bullets.get(i).velocity.y *= -1;
          }
        } else if (walls.get(j).identifier == 2) {
          if (bullets.get(i).checkCollision(walls.get(j))) {
            bullets.get(i).velocity.x *= -1;
          }
        } else if (walls.get(j).identifier == 3) {
          if (bullets.get(i).checkCollision(walls.get(j))) {
            bullets.get(i).velocity.x *= -1;
          }
        } else if (walls.get(j).identifier ==4) {
          if (bullets.get(i).checkCollision(walls.get(j))) {
            bullets.get(i).velocity.y *= -1;
          }
        }
      }

      if (b.lifeTime <= 0) bullets.remove(b);
    }



    for (int i = 0; i < chests.size(); i++) {
      Chest c = chests.get(i);
      c.update();
      if (c.checkCollision(player)) {
        player.applyFix(player.findOverlapFix(c));
      }
    }

    for (int i = 0; i < healthpacks.size(); i++) {
      HealthPack h = healthpacks.get(i);
      h.update();

      if (h.checkCollision(player)) {
        healthpacks.remove(i);
        if (player.playerHealth <= 85) {
          player.playerHealth += 15;
        }
      }
    }

    for (int i = 0; i < ebullets.size(); i++) {
      Bullet b = ebullets.get(i);
      b.update();

      if (b.checkCollision(player)) {
        scenePlay.player.playerHealth -= 1.5;
        //player will take damage
      }



      for (int j = 0; j < walls.size(); j++) {

        if (walls.get(j).identifier == 1) {
          if (ebullets.get(i).checkCollision(walls.get(j))) {
            ebullets.get(i).velocity.y *= -1;
          }
        } else if (walls.get(j).identifier == 2) {
          if (ebullets.get(i).checkCollision(walls.get(j))) {
            ebullets.get(i).velocity.x *= -1;
          }
        } else if (walls.get(j).identifier == 3) {
          if (ebullets.get(i).checkCollision(walls.get(j))) {
            ebullets.get(i).velocity.x *= -1;
          }
        } else if (walls.get(j).identifier ==4) {
          if (ebullets.get(i).checkCollision(walls.get(j))) {
            ebullets.get(i).velocity.y *= -1;
          }
        }
      }


      if (b.lifeTime <= 0) ebullets.remove(b);
    }

    if (shotgun != null) {
      shotgun.update();

      if (shotgun.checkCollision(player)) {
        println("SHOTGUN COLLECTED");
        player.hasShotgun = true;
        shotgun = null;
      }
    }

    if (rifle != null) {
      rifle.update();

      if (rifle.checkCollision(player)) {
        println("RIFLE COLLECTED");
        player.hasRifle = true;
        rifle = null;
      }
    }

    if (crosshair != null) crosshair.update();
    if (hotbar != null) hotbar.update();

    player.update();
    healthbar.update();
    //LATE UPDATE
    Mouse.update();
    Keyboard.update();

    if (player.playerHealth <= 0) switchToGameOver();
  }
  void draw() {

    //DRAW OBJECTS

    for (int i =0; i < floors.size(); i++) {
      Floor f = floors.get(i);
      f.draw();
    }


    for (int i = 0; i < walls.size(); i++) {
      Wall w = walls.get(i);
      w.draw();
    }

    for (int i = 0; i < doors.size(); i++) {
      Door d = doors.get(i);
      d.draw();
    }




    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.draw();
    }

    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      p.draw();
    }

    for (int i = 0; i < chests.size(); i++) {
      Chest c = chests.get(i);
      c.draw();
    }

    for (int i = 0; i < healthpacks.size(); i++) {
      HealthPack h = healthpacks.get(i);
      h.draw();
    }


    for (int i = 0; i < bullets.size(); i++) {

      Bullet b = bullets.get(i);
      b.draw();
    }

    for (int i = 0; i < ebullets.size(); i++) {

      Bullet b = ebullets.get(i);
      b.draw();
    }


    if (shotgun != null) {
      shotgun.draw();
    }


    if (rifle != null) {
      rifle.draw();
    }

    player.draw();

    //popMatrix here
    popMatrix();
    healthbar.draw();
    //DRAW HUD
    if (hud != null) {
      hud.draw();
    }
    if (hotbar != null) {
      hotbar.draw();
    }
    if (crosshair != null) {
      crosshair.draw();
    }
  }
}
