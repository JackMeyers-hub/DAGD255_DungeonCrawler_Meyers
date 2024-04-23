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
  final int EXPLODE_STATE = 1;
  final int ATTACK_STATE = 2;

  final int PISTOL_ENEMY = 0;
  final int SHOTGUN_ENEMY = 1;
  final int RIFLE_ENEMY = 2;


  int currentState;
  int enemyType;





  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
    setSize(35, 35);
    currentState = PATROL_STATE;
    //enemyType = round(random(0, 2));
    enemyType = 0;
  }

  void update() {
    calcAngleToPlayer();


    switch(currentState) {

    case PATROL_STATE:
      findPointAround();
      moveToPoint();
      checkIfAtPoint();
      if (distToPlayer() < 200) {
        currentState = ATTACK_STATE;
      }
      break;

    case ATTACK_STATE:

      switch(enemyType) {

      case PISTOL_ENEMY:
        calcAngleToPlayer();
        Bullet b = new Bullet(x, y, playerAngle);
        scenePlay.ebullets.add(b);

        break;

      case SHOTGUN_ENEMY:

        break;

      case RIFLE_ENEMY:

        break;
      }

      if (distToPlayer() > 200) {
        currentState = PATROL_STATE;
      }
      break;
    }




    super.update();
  }
  void draw() {
    pushMatrix();
    fill(0);
    stroke(3);
    //switch(currentState) {
    //case PATROL_STATE:
    //  fill(#FFFFFF);
    //  break;
    //case CHASE_STATE:
    //  fill(#FFFFFF);
    //  break;
    //case ATTACK_STATE:
    //  fill(#FFFFFF);
    //  break;
    //}
    //rotate(playerAngle);
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
    float dx = scenePlay.player.x - x;
    float dy = scenePlay.player.y - y;
    playerAngle = atan2(dy, dx);
  }

  void calcAngleAroundPlayer() {
    float dx = scenePlay.player.x - x;
    float dy = scenePlay.player.y - y;
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
    return dist(x, y, scenePlay.player.x, scenePlay.player.y);
  }

  void waitSeconds() {
    moveTime -= dt;
    if (moveTime <= 0) {
      canMove = false;
      moveTime = 2;
    }
  }

  void reverseDirection() {
    float timeout = 3;
    timeout -= dt;
    speedX *= -1;
    speedY*= -1;
    if (timeout <= 0) {
      canMove = false;
    }
  }

  void reverseTarget() {
    targetX = scenePlay.player.x + random(-100, 100);
    targetY = scenePlay.player.y + random(-100, 100);
  }

  boolean checkCollision(AABB other) {
    if (edgeR < other.edgeL) return false;
    if (edgeL > other.edgeR) return false;
    if (edgeB < other.edgeT) return false;
    if (edgeT > other.edgeB) return false;
    return true;
  }

  void setSpeed(float speed) {
    speedX = speedY = speed;
  }
  //
}
