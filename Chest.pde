class Chest extends AABB {

  boolean hasOpened = false;
  Chest(float x, float y) {
    this.x = x;
    this.y = y;
    setSize(50, 50);
  }

  void update() {

    if ( distToPlayer() <= 100 && Keyboard.onDown(Keyboard.E) && hasOpened == false) {
      HealthPack h = new HealthPack(x, y);
      scenePlay.healthpacks.add(h);
      hasOpened = true;
    }

    super.update();
  }

  void draw() {
    noStroke();
    fill(#C65134);
    rect(x - w/2, y - h/2, w, h);
  }

  float distToPlayer() {
    return dist(x, y, scenePlay.player.x, scenePlay.player.y);
  }
}




class HealthPack extends AABB {
  float speedX = 100, speedY = 100;

  HealthPack(float x, float y) {

    this.x = x - w/2;
    this.y = y - h/2;

    setSize(50, 50);

    velocity.x = random(100, 300);
    velocity.y = random(100, 300);
  }

  void update() {
    angle = -1 * angleToPlayer();

    x += velocity.x * cos(angle) * dt;
    y += velocity.y * sin(angle) * dt;

    velocity.x *= .95;
    velocity.y *= .95;


    for (int i = 0; i < scenePlay.healthpacks.size(); i++) {


      if (scenePlay.healthpacks.get(i).isDead) scenePlay.healthpacks.remove(i);
    }



    super.update();
  }

  void draw() {
    noStroke();
    fill(#0F8926);
    rect(x - w/2, y - h/2, w, h);
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
