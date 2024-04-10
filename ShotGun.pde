class ShotGun extends AABB {
  ShotGun(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {

    x += velocity.x * dt;
    y += velocity.y * dt;

    velocity.x *= .95;
    velocity.y *= .95;
  }

  void draw() {
    rect(x, y, 50, 100);
  }
}
