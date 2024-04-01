class AABB {
  float x, y, w, h; // Location and Size of each AABB object.
  float halfW, halfH;
  float angle;
  float playerAngle;

  float edgeL;
  float edgeR;
  float edgeT;
  float edgeB;

  PVector velocity = new PVector();
  boolean isDead = false;

  AABB() {
    // All child classes of AABB must call the setSize() function
    // in their constructors.
  }

  void update() {
    calcAABB();
  }

  void draw() {
  }

  void setSize(float w, float h) {
    this.w = w;
    this.h = h;
    halfW = w/2;
    halfH = h/2;
  }

  void calcAABB() {
    edgeL = x - halfW;
    edgeR = x + halfW;
    edgeT = y - halfH;
    edgeB = y + halfH;
  }

  void calcAngleToMouse() {
    float dx = camera.x + mouseX - x;
    float dy = camera.y + mouseY - y;
    angle = atan2(dy, dx);
  }

  void calcAngleToPlayer() {
    float dx = camera.x + player.x - x;
    float dy = camera.y + player.y - y;
    playerAngle = atan2(dy, dx);
  }

  boolean checkCollision(AABB other) {
    if (edgeR < other.edgeL) return false;
    if (edgeL > other.edgeR) return false;
    if (edgeB < other.edgeT) return false;
    if (edgeT > other.edgeB) return false;
    return true;
  }

  public void fixOverlap(AABB other) {
    float pushUp = edgeB - other.edgeT;
    float pushLeft = edgeR - other.edgeL;

    if (pushUp <= pushLeft) setBottomEdge(other.edgeT);
    else setRightEdge(other.edgeL);
  }
  public void setBottomEdge(float Y) {
    y = Y - halfH;
    velocity.y = 0;
    calcAABB();
  }
  public void setRightEdge(float X) {
    x = X - halfW;
    velocity.x = 0;
    calcAABB();
  }
  /**
   * This method finds the best solution for moving (this) AABB out from an (other)
   * AABB object. The method compares four possible solutions: moving (this) box
   * left, right, up, or down. We only want to choose one of those four solutions.
   * The BEST solution is whichever one is the smallest. So after finding the four
   * solutions, we compare their absolute values to discover the smallest.
   * We then return a vector of how far to move (this) AABB.
   * NOTE: you should first verify that (this) and (other) are overlapping before
   * calling this method.
   * @param  other  The (other) AABB object that (this) AABB is overlapping with.
   * @return  The vector that respresents how far (and in which direction) to move (this) AABB.
   */
  public PVector findOverlapFix(AABB other) {

    float moveL = other.edgeL - edgeR; // how far to move this box so it's to the LEFT of the other box.
    float moveR = other.edgeR - edgeL; // how far to move this box so it's to the RIGHT of the other box.
    float moveU = other.edgeT - edgeB; // how far to move this box so it's to the TOP of the other box.
    float moveD = other.edgeB - edgeT; // how far to move this box so it's to the BOTTOM of the other box.

    // The above values are potentially negative numbers; the sign indicates what direction to move.
    // But we want to find out which ABSOLUTE value is smallest, so we get a non-signed version of each.

    float absMoveL = abs(moveL);
    float absMoveR = abs(moveR);
    float absMoveU = abs(moveU);
    float absMoveD = abs(moveD);

    PVector result = new PVector();

    result.x = (absMoveL < absMoveR) ? moveL : moveR; // store the smaller horizontal value.
    result.y = (absMoveU < absMoveD) ? moveU : moveD; // store the smaller vertical value.

    if (abs(result.y) <= abs(result.x)) {
      // If the vertical value is smaller, set horizontal to zero.
      result.x = 0;
    } else {
      // If the horizontal value is smaller, set vertical to zero.
      result.y = 0;
    }

    return result;
  }



  void applyFix(PVector fix) {
    x += fix.x;
    y += fix.y;
    if (fix.x != 0) {
      // If we move the player left or right, the player must have hit a wall, so we set horizontal velocity to zero.
      velocity.x = 0;
    }
    if (fix.y != 0) {
      // If we move the player up or down, the player must have hit a floor or ceiling, so we set vertical velocity to zero.
      velocity.y = 0;
      if (fix.y < 0) {
        // If we move the player up, we must have hit a floor.
      }
      if (fix.y > 0) {
        // If we move the player down, we must have hit our head on a ceiling.
      }
    }
    // recalculate AABB (since we moved the object AND we might have other collisions to fix yet this frame):
    calcAABB();
  }
}
