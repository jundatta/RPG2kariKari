// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Kyle Stewartさん
// 【作品名】Clock
// https://openprocessing.org/sketch/1361228
//

class GameSceneCongratulations425 extends GameSceneCongratulationsBase {
  @Override void setup() {
    //angleMode(DEGREES);
    textAlign(CENTER, CENTER);
    textSize(32);
  }
  @Override void draw() {
    push();
    background(100);
    float x = width / 2;
    float y = height / 2;
    float r = min(x, y);

    float weight = 5*1.5f;
    strokeWeight(weight);
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

    circle(x, y, 2 * r);
    line(x, y, x + r_h * cos(hourAngle), y + r_h * sin(hourAngle));
    line(x, y, x + r_m * cos(minuteAngle), y + r_m * sin(minuteAngle));

    strokeWeight(1);
    line(x, y, x + r_m * cos(secondAngle), y + r_m * sin(secondAngle));

    for (int i = 1; i <= 60; i++) {
      float angle = radians(map(i, 0, 60, -90, 270));

      if (i % 5 == 0) {
        int idx = i / 5 - 1;
        push();
        fill(0);
        text(numerals[idx], x + r_num * cos(angle), y + r_num * sin(angle));
        pop();
        strokeWeight(5);
      } else strokeWeight(1);
      line( x + r_inner * cos(angle), y + r_inner * sin(angle), x + r * cos(angle), y + r * sin(angle));
    }
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
