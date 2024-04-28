// this class defines a "Title" scene
class SceneTitle {
  float swapCD = .5;
  SceneTitle() {
    swapCD = .5;
  }
  void update() {
    swapCD -= dt;
    if (leftPressed && !pLeftPressed && swapCD <= 0) {
      switchToPlay();
    }
  }
  void draw() {
    background(0);
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Explore the Void", width/2, height/2 - 30);
    textSize(12);
    text("Left Click to play!", width/2, height/2);
  }
}
