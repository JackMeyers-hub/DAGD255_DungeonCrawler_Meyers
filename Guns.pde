class ShotGun extends AABB {

  float speedX = 100, speedY = 100;
  // float Rad = random(0,radians(360));

  ShotGun(float x, float y) {
    this.x = x - w/2;
    this.y = y - h/2;

    setSize(50, 100);

    velocity.x = random(100, 300);
    velocity.y = random(100, 300);
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
    super.update();
  }

  void draw() {
    fill(#585858);
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
    return atan2(scenePlay.player.y - y, scenePlay.player.x - x);
  }

  float distanceToPlayer() {
    return dist(x, y, scenePlay.player.x, scenePlay.player.y);
  }
}

class Rifle extends AABB {

  float speedX = 100, speedY = 100;
  // float Rad = random(0,radians(360));

  Rifle(float x, float y) {
    this.x = x - w/2;
    this.y = y - h/2;

    setSize(25, 100);

    velocity.x = random(100, 300);
    velocity.y = random(100, 300);
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
    super.update();
  }

  void draw() {
    fill(#585858);
    rect(x - w/2, y - h/2, 25, 100);
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
    return atan2(scenePlay.player.y - y, scenePlay.player.x - x);
  }

  float distanceToPlayer() {
    return dist(x, y, scenePlay.player.x, scenePlay.player.y);
  }
}
