class Wall extends AABB {

  Wall(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;


    setSize(w, h);
  }

  void update() {

    super.update();
  }
  void draw() {
    fill(0);
    rect(x-halfW, y-halfH, w, h);
  }
}
