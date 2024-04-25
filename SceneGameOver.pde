// this class defines a "Game Over" scene
class SceneGameOver {

  SceneGameOver() {
  }
  void update() {
    if (Mouse.onDown(Mouse.LEFT)) {
      switchToTitle();
    }
  }
  void draw() {
    background(255, 0, 0);
    textAlign(LEFT, TOP);
    text("Left Click to return to the main menu", 10, 20);
    textAlign(CENTER, CENTER);
    text("You Lost", width/2, height/2);
  }
}
