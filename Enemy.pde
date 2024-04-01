class Enemy extends AABB {


  float speedX = 100, speedY = 100;
  float targetX, targetY;
  float moveAngle;
  float moveTime = 2;
  float attackCD = 1;


  boolean atEdge;
  boolean playerSpotted;
  boolean canAttack;
  boolean canMove = false;

  final int PATROL_STATE = 0;
  final int CHASE_STATE = 1;
  final int ATTACK_STATE = 2;

  int currentState;


  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
    setSize(50, 50);
    currentState = PATROL_STATE;
  }

  void update() {

    switch(currentState) {
    case PATROL_STATE:
      findPointAround();
      moveToPoint();
      checkIfAtPoint();
      if (distToPlayer() < 300) {
        currentState = ATTACK_STATE;
      }
      break;

    case ATTACK_STATE:

      if (distToPlayer() > 300) {
        currentState = PATROL_STATE;
      }
      break;
    }




    super.update();
  }
  void draw() {
    pushMatrix();
    switch(currentState) {
    case PATROL_STATE:
      fill(0, 255, 0);
      break;
    case CHASE_STATE:
      fill(255, 255, 0);
      break;
    case ATTACK_STATE:
      fill(255, 0, 0);
      break;
    }
    rotate(playerAngle);
    rect(x-halfW, y-halfH, w, h);
    popMatrix();
  }

  // shoot in direction of player (have variables to control accuracy)

  // roam
  void findPointAround() {
    if (!canMove) {

      while (true) {
        targetX = random(x - 200, x + 200);
        targetY = random(y - 200, y + 200);
        canMove = true;
        setSpeed(200);
        break;
      }
    }
  }

  void moveToPoint() {
    if (canMove) {
      moveAngle = atan2(targetY- y, targetX - x);
      x += speedX * cos(moveAngle) * dt;
      y += speedY * sin(moveAngle) * dt;
    }
  }

  void calcAngleToPlayer() {
    float dx = camera.x + player.x - x;
    float dy = camera.y + player.y - y;
    playerAngle = atan2(dy, dx);
  }

  void checkIfAtPoint() {
    float dis = dist(x, y, targetX, targetY);

    if (dis <= 3) {
      speedX = speedY = 0;
      waitSeconds();
    }
  }

  float distToPlayer() {
    return dist(x, y, player.x, player.y);
  }

  void waitSeconds() {
    moveTime -= dt;
    if (moveTime <= 0) {
      canMove = false;
      moveTime = 2;
    }
  }

  void setSpeed(float speed) {
    speedX = speedY = speed;
  }
  //
}
