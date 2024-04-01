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
    setSize(100, 100);
    currentState = PATROL_STATE;
  }

  void update() {

    switch(currentState) {
    case PATROL_STATE:

      break;

    case ATTACK_STATE:


      break;
    }




    super.update();
  }
  void draw() {
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
    rect(x-halfW, y-halfH, w, h);
  }
  
  // shoot in direction of player (have variables to control accuracy)
  
  // roam
  
  // 
}
