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


  int numRooms = 0;



  Room(float xPos, float yPos) {
    enemySpawn = 2;//round(random(2,4));

    Floor f = new Floor(xPos - 5, yPos+1, w - 90, h - 95);
    scenePlay.floors.add(f);

    if (scenePlay.rooms.size() >= 1) {
      if (enemySpawn == 2) {


        Enemy e1= new Enemy(xPos + random(0, w - 90), yPos + random(0, h- 95));
        scenePlay.enemies.add(e1);

        Enemy e2= new Enemy(xPos + random(0, w - 90), yPos + random(0, h- 95));
        scenePlay.enemies.add(e2);

        //        println(e1.x);
        //        println(e1.y);

        //        println(e2.x);
        //        println(e2.y);
      } else if (enemySpawn == 3) {
        Enemy e1= new Enemy(xPos + random(w, w - 90), yPos + random(h, h- 95));
        scenePlay.enemies.add(e1);

        Enemy e2= new Enemy(xPos + random(w, w - 90), yPos + random(h, h- 95));
        scenePlay.enemies.add(e2);

        Enemy e3= new Enemy(xPos + random(w, w - 90), yPos + random(h, h- 95));
        scenePlay.enemies.add(e3);
        //println(e1.x);
        //println(e1.y);

        //println(e2.x);
        //println(e2.y);

        //println(e3.x);
        //println(e3.y);
      } else if (enemySpawn == 4) {
        Enemy e1= new Enemy(xPos + random(w, w - 90), yPos + random(h, h- 95));
        scenePlay.enemies.add(e1);

        Enemy e2= new Enemy(xPos + random(w, w - 90), yPos + random(h, h- 95));
        scenePlay.enemies.add(e2);

        Enemy e3= new Enemy(xPos + random(w, w - 90), yPos + random(h, h- 95));
        scenePlay.enemies.add(e3);

        Enemy e4= new Enemy(xPos + random(w, w - 90), yPos + random(h, h- 95));
        scenePlay.enemies.add(e4);
        //println(e1.x);
        //println(e1.y);

        //println(e2.x);
        //println(e2.y);

        //println(e3.x);
        //println(e3.y);

        //println(e4.x);
        //println(e4.y);
      }
    }



    x = xPos;
    y = yPos;

    // TOP WALLS
    Wall w1 = new Wall(x + platformWidth/2, y + wallThickness/2, platformWidth, wallThickness);
    scenePlay.walls.add(w1);
    w1.identifier = 1;
    Wall w2 = new Wall(w1.x + gapSize/2 + w1.w, y + wallThickness/2, platformWidth, wallThickness);
    scenePlay.walls.add(w2);
    w2.identifier = 1;
    d1 = new Door(x + w/2 - gapSize/4, y + wallThickness/2, wallThickness);
    scenePlay.doors.add(d1);

    //RIGHT WALLS
    Wall w3 = new Wall(w1.x + w/2 + w1.w/2, y + platformHeight/2, wallThickness, platformHeight);
    scenePlay.walls.add(w3);
    w3.identifier = 2;
    Wall w4 = new Wall(w1.x + w/2 + w1.w/2, w3.y + w3.h + gapSize/2, wallThickness, platformHeight);
    scenePlay.walls.add(w4);
    w4.identifier = 2;
    d2 = new Door(w1.x + w/2 + w1.w/2, y + h/2 - gapSize/4, wallThickness);
    scenePlay.doors.add(d2);

    // LEFT WALLS
    Wall w7 = new Wall(w1.x - platformWidth/2, y + platformHeight/2, wallThickness, platformHeight);
    scenePlay.walls.add(w7);
    w7.identifier = 3;
    Wall w8 = new Wall(w1.x - platformWidth/2, w7.y + w7.h + gapSize/2, wallThickness, platformHeight);
    scenePlay.walls.add(w8);
    w8.identifier = 3;
    d4 = new Door(w1.x - platformWidth/2, y + h/2 - gapSize/4, wallThickness);
    scenePlay.doors.add(d4);

    // BOTTOM WALLS
    Wall w5 = new Wall(x + platformWidth/2, y + platformHeight*2 + gapSize/2, platformWidth, wallThickness);
    scenePlay.walls.add(w5);
    w5.identifier = 4;
    Wall w6 = new Wall(w5.x + gapSize/2 + w1.w, y + platformHeight*2 + gapSize/2, platformWidth, wallThickness);
    scenePlay.walls.add(w6);
    w6.identifier = 4;
    d3 = new Door(x + w/2 - gapSize/4, y + platformHeight*2 + gapSize/2, wallThickness);
    scenePlay.doors.add(d3);
  }

  void update() {
    enemySpawn = round(random(2, 4));
    //println("ENEMY SPAWN" + enemySpawn);
    // COLLISION WITH TOP DOOR
    if (scenePlay.player.checkCollision(d1)) {
      if (!topWall) {
        numRooms++;
        topWall = true;
        Room r = new Room(x, y - h + platformHeight/2 - 50 );
        scenePlay.rooms.add(r);
        r.bottomWall = true;
      }
    }

    // COLLISION WITH RIGHT DOOR
    if (scenePlay.player.checkCollision(d2)) {
      if (!rightWall) {
        numRooms++;
        rightWall = true;
        Room r = new Room(x + w/2 + platformWidth + 5, y);
        scenePlay.rooms.add(r);
        r.leftWall = true;
      }
    }
    // COLLISION WITH LEFT DOOR
    if (scenePlay.player.checkCollision(d4)) {
      if (!leftWall) {
        numRooms++;
        leftWall = true;
        Room r = new Room(x - platformWidth - w/2 - 5, y);
        scenePlay.rooms.add(r);
        r.rightWall = true;
      }
    }
    // COLLISION WITH BOTTOM DOOR
    if (scenePlay.player.checkCollision(d3)) {
      if (!bottomWall) {
        numRooms++;
        bottomWall = true;
        Room r = new Room(x, y + h - gapSize/2 );
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
