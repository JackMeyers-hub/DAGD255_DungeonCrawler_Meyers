class HUD {

  ArrayList<Button> buttons = new ArrayList();

  float invItem;


  HUD() {
    Button pause = new Button(width - 175, 75, "PAUSE");
    buttons.add(pause);
  }

  void update() {

    invItem = scenePlay.player.invItem;
    for (int i = 0; i < buttons.size(); i++) {
      Button b = buttons.get(i);
      b.update();

      if (b.isClicked()) {
        b.currentColor = b.pressedColor;
        switch(b.buttonName) {
        case "PAUSE":
          // do something...
          break;
        case "SKILL1":
          // do something
          break;
        default:

          break;
        }
      }
    }
  }

  void draw() {
    for (int i = 0; i < buttons.size(); i++) {
      Button b = buttons.get(i);
      b.draw();
    }
  }
}

class Hotbar {
  int invItem;

  final int PISTOL = 0;
  final int SHOTGUN = 1;
  final int RIFLE = 2;

  Hotbar() {
  }

  void update() {
    invItem = scenePlay.player.invItem;
  }

  void draw() {
    stroke(00000);
    strokeWeight(5);
    fill(#676767);
    // FINISH BY HAVING CHECKS TO SEE IF PLAYER HAS ITEMS THEN SWAP BACK TO PISTOL IF DONT!!!!

    switch(invItem) {
    case PISTOL:
      //SHOTGUN
      pushMatrix();
      rect(150, height - 250, 100, 100);
      textSize(25);
      fill(0);
      text("Shotgun", 200, height - 200);
      fill(#676767);
      popMatrix();
      //RIFLE
      pushMatrix();
      rect(250, height - 250, 100, 100);
      textSize(25);
      fill(0);
      text("Rifle", 300, height - 200);
      fill(#676767);
      popMatrix();
      //PISTOL
      pushMatrix();
      scale(1.2);
      rect(25, height - 400, 100, 100);
      textSize(35);
      fill(0);
      text("Pistol", 75, height - 355);
      popMatrix();
      break;
    case SHOTGUN:

      //PISTOL
      pushMatrix();
      rect(50, height - 250, 100, 100);
      textSize(25);
      fill(0);
      text("Pistol", 100, height - 200);
      fill(#676767);
      popMatrix();
      //RIFLE
      pushMatrix();
      rect(250, height - 250, 100, 100);
      textSize(25);
      fill(0);
      text("Rifle", 300, height - 200);
      fill(#676767);
      popMatrix();
      //SHOTGUN
      pushMatrix();
      scale(1.2);
      rect(115, height - 400, 100, 100);
      textSize(25);
      fill(0);
      text("Shotgun", 165, height - 350);

      popMatrix();

      break;
    case RIFLE:

      //PISTOL
      pushMatrix();
      rect(50, height - 250, 100, 100);
      textSize(25);
      fill(0);
      text("Pistol", 100, height - 200);
      fill(#676767);
      popMatrix();
      //SHOTGUN
      pushMatrix();
      rect(150, height - 250, 100, 100);
      textSize(25);
      fill(0);
      text("Shotgun", 200, height - 200);
      fill(#676767);
      popMatrix();
      //RIFLE
      pushMatrix();
      scale(1.2);
      rect(210, height - 400, 100, 100);
      textSize(35);
      fill(0);
      text("Rifle", 260, height - 350);
      fill(#676767);
      popMatrix();
      break;
    }
  }
}





class HealthBar extends AABB {
  float health;
  float barLength;

  HealthBar(float x, float y) {
    this.x = x;
    this.y = y;
    setSize(50, 200);
  }

  void update() {
    health = scenePlay.player.playerHealth;
    barLength = map(health, 0, 100, 0, 290);
  }


  void draw() {
    fill(0);
    rect(50, height - 100, 300, 70);
    fill(255, 0, 0);
    rect(55, height - 95, barLength, 60);
  }
}






class Button {
  float x, y, w = 150, h = 50;
  String buttonName;
  color normalColor = 25, hoveredColor = 200, pressedColor = 60;
  color currentColor;
  boolean isHovered;

  Button(float x, float y, String name) {
    this.x = x;
    this.y = y;
    buttonName = name;
    currentColor = normalColor;
  }

  void update() {
    if (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) {
      isHovered = true;
      currentColor = hoveredColor;
    } else {
      isHovered = false;
      currentColor = normalColor;
    }
  }
  void draw() {
    stroke(255);
    strokeWeight(2);
    //println(currentColor);
    fill(currentColor);
    rect(x-w/2, y-h/2, w, h);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(18);
    text(buttonName, x, y);
    noStroke();
  }

  boolean isClicked() {
    if (isHovered) {
      if (leftPressed && !pLeftPressed) {
        currentColor = pressedColor;
        return true;
      }
    }
    return false;
  }
}
