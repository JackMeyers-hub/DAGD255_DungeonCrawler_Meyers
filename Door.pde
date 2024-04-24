class Door extends AABB {

  Door(float x, float y, float gapSize) {
    this.x = x;
    this.y = y;
    setSize(gapSize, gapSize);
  }

  void update() {


    super.update();
  }

  void draw() {

    //    fill(255);
    //    rect(x-halfW, y-halfH, w, h);
  }
}
