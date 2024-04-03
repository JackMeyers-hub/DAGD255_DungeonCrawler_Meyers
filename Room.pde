class Room {

  float x, y;
  final float w = 1000, h = 600;
  float gapSize = 200;
  float wallThickness = 15;

  boolean topWall, leftWall, rightWall, bottomWall ;
  Door d1, d2, d3, d4;

  Room(float xPos, float yPos) {

    x = xPos;
    y = yPos;

    //TOP WALLS
    Wall w1 = new Wall(x, y, w - w/2 - gapSize/2, wallThickness);
    walls.add(w1);
    Wall w2 = new Wall(x + gapSize/2 + w1.w, y, w - w/2 - gapSize/2, wallThickness);
    walls.add(w2);
    d1 = new Door(x + w/2, y + wallThickness/2, gapSize);
    doors.add(d1);

    //RIGHT
    Wall w3 = new Wall(x, y, wallThickness, h - h/2 - gapSize/2);
    walls.add(w3);
    Wall w4 = new Wall(x, y + w3.h + gapSize/2, wallThickness, h - h/2 - gapSize/2);
    walls.add(w4);
    d2 = new Door(x + w - wallThickness/2, y + h/2, gapSize);
    doors.add(d2);
    ////BOTTOM
    //Wall w5 = new Wall(x, y, w - w/2 - gapSize/2, wallThickness);
    //walls.add(w5);
    //Wall w6 = new Wall(x + gapSize/2 + w1.w, y, w - w/2 - gapSize/2, wallThickness);
    //walls.add(w6);

    ////LEFT
    //Wall w7 = new Wall(x, y, w - w/2 - gapSize/2, wallThickness);
    //walls.add(w7);
    //Wall w8 = new Wall(x + gapSize/2 + w1.w, y, w - w/2 - gapSize/2, wallThickness);
    //walls.add(w8);
  }

  void update() {
    // COLLISION WITH TOP DOOR
    if (player.checkCollision(d1)) {
      if (!topWall) {
        topWall = true;
        Room r = new Room(x, y - h);
        rooms.add(r);
        r.bottomWall = true;
      }
    }
    // COLLISION WITH RIGHT DOOR
    if (player.checkCollision(d2)) {
      if (!rightWall) {
        rightWall = true;
        Room r = new Room(x + w, y);
        rooms.add(r);
        r.leftWall = true;
      }
    }
    //    // COLLISION WITH TOP DOOR
    //  if (player.checkCollision(d1));

    //}
    //    // COLLISION WITH TOP DOOR
    //  if (player.checkCollision(d1));
  }
}
