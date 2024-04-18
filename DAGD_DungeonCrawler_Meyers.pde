float dt = 0;
float prevTime = 0;
boolean leftPressed, rightPressed, pLeftPressed, pRightPressed;

boolean shotGunSpawned = false;

float zoomAmount = 1;

Player player;
ShotGun shotgun;
CrossHair crosshair;
Camera camera;
HUD hud;
Hotbar hotbar;
ArrayList<Enemy> enemies = new ArrayList();
ArrayList<Wall> walls = new ArrayList();
ArrayList<Room> rooms = new ArrayList();
ArrayList<Door> doors = new ArrayList();
ArrayList<Rocket> rockets = new ArrayList();
ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Rocket> enemyrockets = new ArrayList();


void setup() {
  size(1280, 720);
  noStroke();
  noCursor();

  player = new Player(width/2, height/2);
  camera = new Camera(player);

  Room r = new Room(-camera.x, -camera.y);
  rooms.add(r);

  //for (int i = 0; i < 3; i++) {
  //  Enemy e= new Enemy(random(width), random(height));
  //  enemies.add(e);
  //}
  hud = new HUD();
  crosshair = new CrossHair();
  hotbar = new Hotbar();
}



void draw() {
  // BACKGROUND AND DELTA TIME
  calcDeltaTime();
  background(0);
  //println(keyCode);
  //pushMatrix here

    text("PLAYER X:" + round(player.x), 100, 50);
      text("PLAYER Y:" + round(player.y), 100, 70);
  pushMatrix();
  translate(-camera.x, -camera.y);





  //SPAWN



  //UPDATE
  

  
  camera.update();

  for (int i = 0; i < walls.size(); i++) {
    Wall w = walls.get(i);
    w.update();

    if (w.checkCollision(player)) {
      player.applyFix(player.findOverlapFix(w));
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

  //  for (int i = 0; i < enemies.size(); i++) {
  //    Enemy e = enemies.get(i);
  //    e.update();

  //    if (e.checkCollision(player)) {
  //      enemies.remove(e);
  //    }
  //  }

  for (int i = 0; i < bullets.size(); i++) {

    Bullet b = bullets.get(i);
    b.update();

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
      println("poof");
      player.hasShotgun = true;
      shotgun = null;
    }
  }

  if (crosshair != null) crosshair.update();
  if (hotbar != null) hotbar.update();

  player.update();

  //LATE UPDATE
  Mouse.update();
  Keyboard.update();

  //DRAW OBJECTS




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



  //for (int i = 0; i < enemies.size(); i++) {
  //  Enemy e = enemies.get(i);
  //  e.draw();
  //}



  for (int i = 0; i < bullets.size(); i++) {

    Bullet b = bullets.get(i);
    b.draw();
  }

  if (shotgun != null) {
    shotgun.draw();
  }

  player.draw();
  //popMatrix here
  popMatrix();
  //DRAW HUD
  hud.update();
  hud.draw();
  hotbar.draw();
  crosshair.draw();
}

void calcDeltaTime() {
  float currTime = millis();
  dt = (currTime - prevTime) / 1000.0;
  prevTime = currTime;
}

void mousePressed() {
  if (mouseButton == LEFT) leftPressed = true;
  if (mouseButton == RIGHT) rightPressed = true;
}

void mouseReleased() {
  if (mouseButton == LEFT) leftPressed = false;
  if (mouseButton == RIGHT) rightPressed = false;
}
void keyPressed() {
  Keyboard.handleKeyDown(keyCode);
}

void keyReleased() {
  Keyboard.handleKeyUp(keyCode);
}

//void mousePressed() {
//  if (mouseButton == LEFT) {
//    Mouse.handleKeyDown(Mouse.LEFT);
//  }
//}

//void mouseReleased() {
//  if (mouseButton == LEFT) {
//    Mouse.handleKeyUp(Mouse.LEFT);
//  }
//}
