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

  ArrayList<Enemy> enemies = new ArrayList();
  ArrayList<Wall> walls = new ArrayList();
  ArrayList<Room> rooms = new ArrayList();
  ArrayList<Door> doors = new ArrayList();
  ArrayList<Floor> floors = new ArrayList();
  ArrayList<Rocket> rockets = new ArrayList();
  ArrayList<Bullet> bullets = new ArrayList();
  ArrayList<Rocket> enemyrockets = new ArrayList();


  ScenePlay() {

    noStroke();
    noCursor();

    player = new Player(width/2, height/2);
    camera = new Camera(player);


    hud = new HUD();
    crosshair = new CrossHair();
    hotbar = new Hotbar();
  }
  void update() {

    //println(keyCode);
    //pushMatrix here
    roomCD -= dt;
    println(roomCD);
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

      if (w.checkCollision(player)) {
        player.applyFix(player.findOverlapFix(w));
      }
    }

    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.update();

      if (e.isDead) {
        enemies.remove(e);
      }
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
        }
      }
      if (b.lifeTime <= 0) bullets.remove(b);
    }

    for (int i = 0; i < rockets.size(); i++) {
      Rocket r = rockets.get(i);
      r.update();

      if (r.lifeTime <= 0) {
        rockets.remove(r);
      }
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

    //LATE UPDATE
    Mouse.update();
    Keyboard.update();
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

    for (int i = 0; i < rockets.size(); i++) {
      Rocket r = rockets.get(i);
      r.draw();
    }



    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.draw();
    }



    for (int i = 0; i < bullets.size(); i++) {

      Bullet b = bullets.get(i);
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

    text("PLAYER X:" + round(player.x), 100, 50);
    text("PLAYER Y:" + round(player.y), 100, 70);
  }
}
