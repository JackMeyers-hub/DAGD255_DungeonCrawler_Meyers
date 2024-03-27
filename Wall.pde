class Wall extends AABB {

  Wall(float x, float y) {
    this.x = x;
    this.y = y;
    float sizeX = random(50, 200);
    float sizeY = random(50, 200);
    setSize(sizeX, sizeY);
  }

  void update() {

    super.update();
  }
  void draw() {
    fill(0);
    rect(x-halfW, y-halfH, w, h);
  }
}
