class ShotGun extends AABB {

  float speedX = 100, speedY = 100;
  // float Rad = random(0,radians(360));

  ShotGun(float x, float y) {
    this.x = x - w/2;
    this.y = y - h/2;

    setSize(50, 100);
  }

  void update() {
    x += velocity.x * dt;
    y += velocity.y * dt;

    velocity.x *= .95;
    velocity.y *= .95;

    if (distanceToPlayer() <= 200 ) {
      angleToPlayer();
      moveToPlayer();
    }
  }

  void draw() {
    rect(x - w/2, y - h/2, 50, 100);
  }

  void moveToPlayer() {
    setSpeed(150);
    x += speedX * cos(angleToPlayer()) * dt;
    y += speedY * sin(angleToPlayer()) * dt;
  }

  void setSpeed(float speed) {
    speedX = speedY = speed;
  }

  float angleToPlayer() {
    return atan2(player.y - y, player.x - x);
  }

  float distanceToPlayer() {
    return dist(x, y, player.x, player.y);
  }
}
