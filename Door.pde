class Door extends AABB {

  Door(float x, float y, float gapSizeH, float gapSizeW) {
    this.x = x;
    this.y = y;
    setSize(gapSizeW, gapSizeH);
  }

  void update() {


    super.update();
  }

  void draw() {

    //fill(255);
    //rect(x-halfW, y-halfH, w, h);
  }
}
