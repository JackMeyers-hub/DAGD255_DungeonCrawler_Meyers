class Shockwave {
  float x, y;
  float radius = 10;
  boolean isDead;
  float lifeTime;
  float alpha;

  Shockwave(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    alpha -= 255 * dt;

    radius += 300 * dt;

    if (alpha <= 0) isDead = true;
  }

  void draw() {
    noFill();
    stroke(255, 0, 0, alpha);
    strokeWeight(3);
    ellipse(x, y, radius * 2, radius * 2);
    noStroke();
  }
}
