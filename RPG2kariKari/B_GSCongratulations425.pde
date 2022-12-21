// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Kyle Stewartさん
// 【作品名】Clock
// https://openprocessing.org/sketch/1361228
//

class GameSceneCongratulations425 extends GameSceneCongratulationsBase {
  PGraphics pg;

  @Override void setup() {
    //angleMode(DEGREES);
    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.textAlign(CENTER, CENTER);
    pg.textSize(32 * 1.5f);
    pg.strokeCap(ROUND);
    pg.background(100);
    pg.endDraw();
  }
  @Override void draw() {
    push();
    pg.beginDraw();
    float x = width / 2;
    float y = height / 2;
    float r = min(x, y);

    float weight = 5*1.5f;
    pg.strokeWeight(weight);
    r -= weight/2.0f;

    float r_m = r * 2 / 3.0f;
    float r_h = r * 1 / 3.0f;
    float r_num = r * 4/5.0f;
    float r_inner = r * 19/20.0f;

    String[] numerals = {"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII"};

    float hour = hour();
    float minute = minute();
    float second = second();
    //float millis = d.getMilliseconds();
    float millis = 0;

    float hourAngle = radians(map(hour + minute/60.0f, 0, 12, -90, 270));
    float minuteAngle = radians(map(minute + second/60.0f, 0, 60, -90, 270));
    float secondAngle = radians(map(second + millis/1000.0f, 0, 60, -90, 270));

    pg.circle(x, y, 2 * r);
    pg.line(x, y, x + r_h * cos(hourAngle), y + r_h * sin(hourAngle));
    pg.line(x, y, x + r_m * cos(minuteAngle), y + r_m * sin(minuteAngle));

    pg.strokeWeight(1);
    pg.line(x, y, x + r_m * cos(secondAngle), y + r_m * sin(secondAngle));

    for (int i = 1; i <= 60; i++) {
      float angle = radians(map(i, 0, 60, -90, 270));

      if (i % 5 == 0) {
        int idx = i / 5 - 1;
        pg.push();
        pg.fill(0);
        pg.text(numerals[idx], x + r_num * cos(angle), y + r_num * sin(angle));
        pg.pop();
        pg.strokeWeight(5);
      } else pg.strokeWeight(1);
      pg.line( x + r_inner * cos(angle), y + r_inner * sin(angle), x + r * cos(angle), y + r * sin(angle));
    }
    pg.endDraw();
    image(pg, 0, 0);
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
