class Room {

  float x, y; // These variables are room dimensions
  final float w = 1000, h = 600; // These variables are room dimensions
  float gapSize = 200;
  float wallThickness = 15;

  boolean topWall, leftWall, rightWall, bottomWall;
  Door d1, d2, d3, d4;

  float platformWidth = w - w/2 - gapSize/2;
  float platformHeight = h - h/2 - gapSize/2;


  Room(float xPos, float yPos) {

    x = xPos;
    y = yPos;

    // TOP WALLS
    Wall w1 = new Wall(x + platformWidth/2, y + wallThickness/2, platformWidth, wallThickness);
    walls.add(w1);
    Wall w2 = new Wall(w1.x + gapSize/2 + w1.w, y + wallThickness/2, platformWidth, wallThickness);
    walls.add(w2);
    d1 = new Door(x + w/2 - gapSize/4, y + wallThickness/2, wallThickness);
    doors.add(d1);

    //RIGHT WALLS
    Wall w3 = new Wall(w1.x + w/2 + w1.w/2, y + platformHeight/2, wallThickness, platformHeight);
    walls.add(w3);
    Wall w4 = new Wall(w1.x + w/2 + w1.w/2, w3.y + w3.h + gapSize/2, wallThickness, platformHeight);
    walls.add(w4);
    d2 = new Door(w1.x + w/2 + w1.w/2, y + h/2 - gapSize/4, wallThickness);
    doors.add(d2);

    //// BOTTOM WALLS
    //Wall w1 = new Wall(x + platformWidth/2, y + wallThickness/2, platformWidth, wallThickness);
    //walls.add(w1);
    //Wall w2 = new Wall(w1.x + gapSize/2 + w1.w, y + wallThickness/2, platformWidth, wallThickness);
    //walls.add(w2);
    //d1 = new Door(x + w/2 - gapSize/4, y + wallThickness/2, wallThickness);
    //doors.add(d1);

    // LEFT WALLS
    Wall w7 = new Wall(w1.x - platformWidth/2, y + platformHeight/2, wallThickness, platformHeight);
    walls.add(w7);
    Wall w8 = new Wall(w1.x - platformWidth/2, w7.y + w7.h + gapSize/2, wallThickness, platformHeight);
    walls.add(w8);
    d4 = new Door(w1.x - platformWidth/2, y + h/2 - gapSize/4, wallThickness);
    doors.add(d4);
  }

  void update() {

    // COLLISION WITH TOP DOOR
    if (player.checkCollision(d1)) {
      if (!topWall) {
        topWall = true;
        Room r = new Room(x, y - h + platformHeight/2);
        rooms.add(r);
        r.bottomWall = true;
      }
    }

    // COLLISION WITH RIGHT DOOR
    if (player.checkCollision(d2)) {
      if (!rightWall) {
        rightWall = true;
        Room r = new Room(x + w - platformWidth/2, y);
        rooms.add(r);
        r.leftWall = true;
      }
    }

    if (player.checkCollision(d4)) {
      if (!leftWall) {
        leftWall = true;
        Room r = new Room(x - platformWidth - w/2, y);
        rooms.add(r);
        r.rightWall = true;
      }
    }
  }
}
