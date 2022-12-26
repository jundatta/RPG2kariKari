// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Richard Bourneさん
// 【作品名】3D Galaxy Clock
// https://openprocessing.org/sketch/1370301
//

class GameSceneCongratulations429 extends GameSceneCongratulationsBase {
  PImage img;

  @Override void setup() {
    background(127.5);
    img = loadImage("data/429/galaxy.jpg");
    mouseX = width / 2;
    mouseY = height / 2;
  }
  @Override void draw() {
    push();
    camera(mouseX, mouseY, 400, width / 2, height / 2, 0, 0, 1, 0);
    background(127.5);
    lights();
    pushMatrix();
    noStroke();
    fill(255);
    image(img, width / 2 - 187, height / 2 - 187);
    textSize(30);
    textAlign(CENTER);
    text("12", width / 2, height / 2 - 154, 20);
    text("3", width / 2 + 170, height / 2, 20);
    text("6", width / 2, height / 2 + 170, 20);
    text("9", width / 2 - 154, height / 2, 20);
    popMatrix();

    pushMatrix();       // seconds
    float angle = radians(second() * 6);
    fill(255, 0, 0);
    translate(width / 2 + sin(angle) * (((height + width) / 4) / 3.4), height / 2 - cos(angle) * (((height + width) / 4) / 3.4), 20);
    sphere(5);
    popMatrix();

    pushMatrix();       // minutes
    float angle2 = radians(minute() * 6 + radians(second()) * 6);
    fill(0, 200, 0);
    translate(width / 2 + sin(angle2) * (((height + width) / 4) / 3.8), height / 2 - cos(angle2) * (((height + width) / 4) / 3.8), 20);
    sphere(9);
    popMatrix();

    pushMatrix();       // hours
    float angle3 = radians(hour() * 30 + radians(minute()) * 6);
    fill(60, 60, 255);
    translate(width / 2 + sin(angle3) * (((height + width) / 4) / 4.3), height / 2 - cos(angle3) * (((height + width) / 4) / 4.3), 20);
    sphere(13);
    popMatrix();

    pushMatrix();
    fill(255);
    textSize(20);
    String s;
    String m;
    String h;
    if (second() < 10) {
      s = "0" + str(second());
    } else {
      s = str(second());
    }
    if (minute() < 10) {
      m = "0" + str(minute());
    } else {
      m = str(minute());
    }
    if (hour() < 10) {
      h = str(hour());
    } else {
      h = str(hour());
    }
    text("The Time Is: " + h + ":" + m + ":" + s, width / 2, 220, 20);
    popMatrix();
    pop();

    logoRightLower(#ff0000);
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
