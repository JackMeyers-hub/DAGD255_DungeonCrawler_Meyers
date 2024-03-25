class Camera {
  float x, y;
  float tx, ty;
  float distance;
  Player target;
  float dx, dy;



  Camera(Player p) {
    target = p;
    tx = target.x - width/2;
    ty = target.y - height/2;
    x = tx;
    y = ty;
  }


  void update() {
    // get player position and offset with halfw and height.
    tx = target.x - width/2;
    ty = target.y - height/2;

    // calc distance between player position and offset.
    dx = tx - x;
    dy = ty - y;

    // move the camera position with easing from dx and dy.
    x += dx * 0.1;
    y += dy * 0.1;
  }
}
