
SceneTitle sceneTitle;
ScenePlay scenePlay;
SceneGameOver sceneGameOver;

float dt = 0;
float prevTime = 0;
boolean leftPressed, rightPressed, pLeftPressed, pRightPressed;


void setup() {
  size(1280, 720);
  switchToPlay();
}



void draw() {
  // BACKGROUND AND DELTA TIME

  //background(#A29A9A);
  background(0);
  calcDeltaTime();

  if (sceneTitle != null) {
    sceneTitle.update();
    if (sceneTitle != null) sceneTitle.draw(); // this extra if statement exists because the sceneTitle.update() might result in the scene switching...
  } else if (scenePlay != null) {
    scenePlay.update();
    if (scenePlay != null) scenePlay.draw(); // this extra if statement exists because the scenePlay.update() might result in the scene switching...
  } else if (sceneGameOver != null) {
    sceneGameOver.update();
    if (sceneGameOver != null) sceneGameOver.draw(); // this extra if statement exists because the sceneGameOver.update() might result in the scene switching...
  }
}

void calcDeltaTime() {
  float currTime = millis();
  dt = (currTime - prevTime) / 1000.0;
  prevTime = currTime;
}

void mousePressed() {
  if (mouseButton == LEFT) leftPressed = true;
  if (mouseButton == RIGHT) rightPressed = true;
}

void mouseReleased() {
  if (mouseButton == LEFT) leftPressed = false;
  if (mouseButton == RIGHT) rightPressed = false;
}
void keyPressed() {
  Keyboard.handleKeyDown(keyCode);
}

void keyReleased() {
  Keyboard.handleKeyUp(keyCode);
}

void switchToTitle() {
  sceneTitle = new SceneTitle();
  scenePlay = null;
  sceneGameOver = null;
}
void switchToPlay() {
  scenePlay = new ScenePlay();
  sceneTitle = null;
  sceneGameOver = null;
}
void switchToGameOver() {
  sceneGameOver = new SceneGameOver();
  scenePlay = null;
  sceneTitle = null;
}

//void mousePressed() {
//  if (mouseButton == LEFT) {
//    Mouse.handleKeyDown(Mouse.LEFT);
//  }
//}

//void mouseReleased() {
//  if (mouseButton == LEFT) {
//    Mouse.handleKeyUp(Mouse.LEFT);
//  }
//}
