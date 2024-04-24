class Wall extends AABB {
  int identifier;

  //IDENTIFIER HELP 1 = top, 2 = right, 3 = left, 4 = bottom.

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
