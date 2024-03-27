class Enemy extends AABB {
  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
    setSize(150, 150);
  }

  void update() {

    super.update();
  }
  void draw() {
    fill(255, 0, 0);
    rect(x-halfW, y-halfH, w, h);
  }
}
