float dt = 0;
float prevTime = 0;

Player player;
Camera camera;

ArrayList<Enemy> enemies = new ArrayList();
ArrayList<Wall> walls = new ArrayList();
ArrayList<Room> rooms = new ArrayList();
ArrayList<Door> doors = new ArrayList();
ArrayList<Rocket> rockets = new ArrayList();
ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Rocket> enemyrockets = new ArrayList();
ArrayList<Shockwave> shockwaves = new ArrayList();

void setup() {
  size(1280, 720);

  player = new Player(width/2, height/2);
  camera = new Camera(player);

  Room r = new Room(camera.x, camera.y);
  rooms.add(r);

  //for (int i = 0; i < 3; i++) {
  //  Enemy e= new Enemy(random(width), random(height));
  //  enemies.add(e);
  //}
}



void draw() {
  // BACKGROUND AND DELTA TIME
  calcDeltaTime();
  background(128);
  //println(keyCode);
  //pushMatrix here
  pushMatrix();
  translate(-camera.x, -camera.y);





  //SPAWN



  //UPDATE
  camera.update();

  for (int i = 0; i < rockets.size(); i++) {
    Rocket r = rockets.get(i);
    r.update();

    if (r.lifeTime <= 0) {
      rockets.remove(r);
    }
  }

  for (int i = 0; i < shockwaves.size(); i++) {
    Shockwave w = shockwaves.get(i);
    w.update();
  }

  for (int i = 0; i < rooms.size(); i++) {
    Room r = rooms.get(i);
    r.update();
  }

  for (int i = 0; i < doors.size(); i++) {
    Door d = doors.get(i);
    d.update();
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

    if (e.checkCollision(player)) {
      enemies.remove(e);
    }
  }

  for (int i = 0; i < bullets.size(); i++) {

    Bullet b = bullets.get(i);
    b.update();

    if (b.lifeTime <= 0) b.isDead = true;
  }


  player.update();

  //LATE UPDATE
  Keyboard.update();

  //DRAW OBJECTS

  for (int i = 0; i < rockets.size(); i++) {
    Rocket r = rockets.get(i);
    r.draw();
  }

  for (int i = 0; i < walls.size(); i++) {
    Wall w = walls.get(i);
    w.draw();
  }

  for (int i = 0; i < enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.draw();
  }

  for (int i = 0; i < shockwaves.size(); i++) {
    Shockwave w = shockwaves.get(i);
    w.draw();
  }

  for (int i = 0; i < bullets.size(); i++) {

    Bullet b = bullets.get(i);
    b.draw();
  }


  player.draw();
  //popMatrix here
  popMatrix();
  //DRAW HUD
}

void calcDeltaTime() {
  float currTime = millis();
  dt = (currTime - prevTime) / 1000.0;
  prevTime = currTime;
}

void keyPressed() {
  Keyboard.handleKeyDown(keyCode);
}

void keyReleased() {
  Keyboard.handleKeyUp(keyCode);
}
