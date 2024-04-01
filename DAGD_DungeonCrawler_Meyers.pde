float dt = 0;
float prevTime = 0;

Player player;
Camera camera;

ArrayList<Enemy> enemies = new ArrayList();
ArrayList<Wall> walls = new ArrayList();
ArrayList<Rocket> rockets = new ArrayList();
ArrayList<Rocket> enemyrockets = new ArrayList();
ArrayList<Shockwave> shockwaves = new ArrayList();

void setup() {
  size(1280, 720);

  player = new Player(width/2, height/2);
  camera = new Camera(player);

  for (int i = 0; i < 10; i++) {
    // Wall w = new Wall(random(width), random(height));
    // walls.add(w);
  }
  for (int i = 0; i < 3; i++) {
    Enemy e= new Enemy(random(width), random(height));
    enemies.add(e);
  }
}



void draw() {
  // BACKGROUND AND DELTA TIME
  calcDeltaTime();
  background(128);
  // println(keyCode);
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
