class Bullet extends AABB {
  float lifeTime = 4;

  Bullet(float x, float y, float angle) {
    this.x = x;
    this.y = y;
    this.angle = angle;
    velocity = new PVector(800, 800);
    setSize(8, 8);
  }

  void update() {
    lifeTime -= dt;

    x += velocity.x * cos(angle) * dt;
    y += velocity.y * sin(angle) * dt;

    super.update();
  }

  void draw() {
    fill(255, 255, 0);
    ellipse(x-halfW, y-halfH, w, h);
  }
}
