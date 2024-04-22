class Room {

  float x, y; // These variables are room dimensions
  final float w = 1300, h = 800; // These variables are room dimensions
  float gapSize = 200;
  float wallThickness = 15;

  float enemySpawn = 0;


  boolean topWall, leftWall, rightWall, bottomWall;
  Door d1, d2, d3, d4;

  float platformWidth = w - w/2 - gapSize/2;
  float platformHeight = h - h/2 - gapSize/2;



  Room(float xPos, float yPos) {
    println("ROOM SPAWNED");
    enemySpawn = round(random(2, 4));

    Floor f = new Floor(xPos - 5, yPos+1, w - 95, h - 95);
    scenePlay.floors.add(f);

    if (scenePlay.rooms.size() >= 1) {
      if (enemySpawn == 2) {
        //if (getRoomAtLocation(xPos, yPos).x = xPos) {

        Enemy e1= new Enemy(xPos + random(w), yPos + random(h));
        scenePlay.enemies.add(e1);

        Enemy e2= new Enemy(xPos + random(w), yPos + random(h));
        scenePlay.enemies.add(e2);
        //}
      } else if (enemySpawn == 3) {
        Enemy e1= new Enemy(xPos + random(w), yPos + random(h));
        scenePlay.enemies.add(e1);

        Enemy e2= new Enemy(xPos + random(w), yPos + random(h));
        scenePlay.enemies.add(e2);

        Enemy e3= new Enemy(xPos + random(w), yPos + random(h));
        scenePlay.enemies.add(e3);
      } else if (enemySpawn == 4) {
        Enemy e1= new Enemy(xPos + random(w), yPos + random(h));
        scenePlay.enemies.add(e1);

        Enemy e2= new Enemy(xPos + random(w), yPos + random(h));
        scenePlay.enemies.add(e2);

        Enemy e3= new Enemy(xPos + random(w), yPos + random(h));
        scenePlay.enemies.add(e3);

        Enemy e4= new Enemy(xPos + random(w), yPos + random(h));
        scenePlay.enemies.add(e4);
      }
    }



    x = xPos;
    y = yPos;

    // TOP WALLS
    Wall w1 = new Wall(x + platformWidth/2, y + wallThickness/2, platformWidth, wallThickness);
    scenePlay.walls.add(w1);
    Wall w2 = new Wall(w1.x + gapSize/2 + w1.w, y + wallThickness/2, platformWidth, wallThickness);
    scenePlay.walls.add(w2);
    d1 = new Door(x + w/2 - gapSize/4, y + wallThickness/2, wallThickness);
    scenePlay.doors.add(d1);

    //RIGHT WALLS
    Wall w3 = new Wall(w1.x + w/2 + w1.w/2, y + platformHeight/2, wallThickness, platformHeight);
    scenePlay.walls.add(w3);
    Wall w4 = new Wall(w1.x + w/2 + w1.w/2, w3.y + w3.h + gapSize/2, wallThickness, platformHeight);
    scenePlay.walls.add(w4);
    d2 = new Door(w1.x + w/2 + w1.w/2, y + h/2 - gapSize/4, wallThickness);
    scenePlay.doors.add(d2);

    // LEFT WALLS
    Wall w7 = new Wall(w1.x - platformWidth/2, y + platformHeight/2, wallThickness, platformHeight);
    scenePlay.walls.add(w7);
    Wall w8 = new Wall(w1.x - platformWidth/2, w7.y + w7.h + gapSize/2, wallThickness, platformHeight);
    scenePlay.walls.add(w8);
    d4 = new Door(w1.x - platformWidth/2, y + h/2 - gapSize/4, wallThickness);
    scenePlay.doors.add(d4);

    // BOTTOM WALLS
    Wall w5 = new Wall(x + platformWidth/2, y + platformHeight*2 + gapSize/2, platformWidth, wallThickness);
    scenePlay.walls.add(w5);
    Wall w6 = new Wall(w5.x + gapSize/2 + w1.w, y + platformHeight*2 + gapSize/2, platformWidth, wallThickness);
    scenePlay.walls.add(w6);
    d3 = new Door(x + w/2 - gapSize/4, y + platformHeight*2 + gapSize/2, wallThickness);
    scenePlay.doors.add(d3);

    // SPAWN SHOTGUN IF NOT PREVIOUSLY SPAWNED
    if (scenePlay.shotGunSpawned == false) {
      float randShotgun = random(1);
      println("SHOTGUN PERCENT: " + randShotgun);
      if (randShotgun <= .25) {

        scenePlay.shotgun = new ShotGun( random(x + 50, x + w - 50), random(y + 100, y + h - 100));
        println("X: " + x + " ShotgunX: " + scenePlay.shotgun.x);
        println("Y: " + y + " ShotgunY: " + scenePlay.shotgun.y);
        scenePlay.shotGunSpawned = true;
      }
    }

    if (scenePlay.shotGunSpawned && scenePlay.pShotGunSpawned == true) {
      if (scenePlay.rifleSpawned == false) {
        float randRifle = random(1);
        println("RIFLE PERCENT: " + randRifle);
        if (randRifle <= .25) {

          scenePlay.rifle = new Rifle( random(x + 50, x + w - 50), random(y + 100, y + h - 100));
          println("X: " + x + " RifleX: " + scenePlay.rifle.x);
          println("Y: " + y + " RifleY: " + scenePlay.rifle.y);
          scenePlay.rifleSpawned = true;
        }
      }
    }
  }

  void update() {
    enemySpawn = random(2, 4);

    // COLLISION WITH TOP DOOR
    if (scenePlay.player.checkCollision(d1)) {
      if (!topWall) {
        topWall = true;
        Room r = new Room(x, y - h + platformHeight/2 - 45 );
        scenePlay.rooms.add(r);
        r.bottomWall = true;
      }
    }

    // COLLISION WITH RIGHT DOOR
    if (scenePlay.player.checkCollision(d2)) {
      if (!rightWall) {
        rightWall = true;
        Room r = new Room(x + w/2 + platformWidth, y);
        scenePlay.rooms.add(r);
        r.leftWall = true;
      }
    }
    // COLLISION WITH LEFT DOOR
    if (scenePlay.player.checkCollision(d4)) {
      if (!leftWall) {
        leftWall = true;
        Room r = new Room(x - platformWidth - w/2, y);
        scenePlay.rooms.add(r);
        r.rightWall = true;
      }
    }
    // COLLISION WITH BOTTOM DOOR
    if (scenePlay.player.checkCollision(d3)) {
      if (!bottomWall) {
        bottomWall = true;
        Room r = new Room(x, y + h - gapSize/2 - 6);
        scenePlay.rooms.add(r);
        r.topWall = true;
      }
    }


    scenePlay.pShotGunSpawned = scenePlay.shotGunSpawned;
  }

  Room GetRoomAtLocation(float x, float y) {
    for (int i = 0; i < scenePlay.rooms.size(); i++) {
      Room r = scenePlay.rooms.get(i);
      if (r.x == x && r.y == y) {
        return r;
      }
    }
    return null;
  }
}

class Floor extends AABB {

  Floor(float x, float y, float w, float h) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void update() {
  }

  void draw() {
    fill(#ffffff);
    rect(x, y, w, h);
  }
}
