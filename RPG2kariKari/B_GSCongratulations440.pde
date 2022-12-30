// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Neill Bogieさん
// 【作品名】Hue clock (example)
// https://openprocessing.org/sketch/1161526
//

class GameSceneCongratulations440 extends GameSceneCongratulationsBase {
  PGraphics pg;

  @Override void setup() {
    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.textFont(gFont);
    pg.strokeCap(SQUARE);
    pg.endDraw();
  }

  final color lightgray = #D3D3D3;
  final color skyblue = #87CEEB;
  final color white = #FFFFFF;
  final color orange = #FFA500;
  final color gray = #808080;
  @Override void draw() {
    push();
    pg.beginDraw();
    setBackgroundHue(pg);

    float hrAngle = map(hour(), 0, 24, 0, 720) - 90;
    float minAngle = map(minute(), 0, 60, 0, 360) - 90;
    float secAngle = map(second(), 0, 60, 0, 360) - 90;
    float radius = min(width, height) * 0.4;

    //make everything relative to centre of canvas, a new (0,0)
    pg.translate(width / 2, height / 2);
    pg.noStroke();
    pg.fill(lightgray);
    pg.circle(0, 0, radius * 2);

    drawNumbers(pg, radius * 0.75);
    drawHand(pg, skyblue, hrAngle, 120, 20);
    drawHand(pg, white, minAngle, 150, 15);
    drawHand(pg, orange, secAngle, 170, 10);

    pg.fill(gray);
    pg.circle(0, 0, 50);
    pg.endDraw();
    image(pg, 0, 0);
    pop();

    logoRightLower(#ff0000);
  }

  void drawHand(PGraphics pg, color colour, float angle, float len, float thickness) {
    pg.push();
    pg.stroke(colour);
    pg.strokeWeight(thickness);
    pg.rotate(radians(angle));
    pg.line(0, 0, len, 0);
    pg.pop();
  }

  void drawNumbers(PGraphics pg, float radius) {
    pg.fill(60);
    pg.textSize(50 * 1.25f);
    pg.textAlign(CENTER, CENTER);
    float angle = -60;
    String[] nums = {"1", "2", "3", "4", "etc."};
    for (String word : nums) {
      float x = radius * cos(radians(angle));
      float y = radius * sin(radians(angle));
      pg.text(word, x, y);
      angle += 30;
    }
  }

  void setBackgroundHue(PGraphics pg) {
    pg.push();
    pg.colorMode(HSB, 360, 100, 100, 1.0f);
    int myHue = second() * 6;
    pg.background(myHue, 50, 100);
    pg.pop();
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
