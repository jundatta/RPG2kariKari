// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】KKeethさん
// 【作品名】My Fun Art of Yayoi Kusama
// https://neort.io/art/cfblhmsn70rvflp1k0a0
//

class GameSceneCongratulations497 extends GameSceneCongratulationsBase {
  float r = 10;
  float inc = 0.01;
  float start = 0;
  float level = 3;
  boolean isDark = true;

  @Override void setup() {
  }
  @Override void draw() {
    push();
    noStroke();
    if (isDark) {
      background(0);
    } else {
      fill(#FFD700);
      rect(0, 0, width, height / 2.0f);
      fill(#c70067);
      rect(0, height / 2.0f, width, height / 2.0f);
    }

    float xoff = start;

    for (float x = 0; x < width; x += r) {
      float y = noise(xoff) * height;

      if (isDark) fill(#FFD700);
      else fill(0);

      if (isDark && y > height / 2.0f) fill(#c70067);
      ellipse(x * 1.2, y, r, r);

      if (isDark && (y + 1.25 * r + 0.5 * r) > height / 2.0f) fill(#c70067);
      if (x % 20 == 0) ellipse(x * 1.2, y + 1.25 * r + 0.5 * r, 1.5 * r, 1.5 * r);

      if (isDark && (y + 3 * r + r) > height / 2) fill(#c70067);
      if (x % 30 == 0) ellipse(x * 1.2, y + 3 * r + r, 2 * r, 2 * r);

      if (isDark && (y + 6 * r + 1.5 * r) > height / 2.0f) fill(#c70067);
      if (x % 40 == 0) ellipse(x * 1.2, y + 6 * r + 1.5 * r, 4 * r, 4 * r);

      if (isDark && (y + 9 * r + 2 * r) > height / 2.0f) fill(#c70067);
      if (x % 30 == 0) ellipse(x * 1.2, y + 9 * r + 2 * r, 2 * r, 2 * r);

      if (isDark && (y + 10.75 * r + 2.5 * r) > height / 2.0f) fill(#c70067);
      if (x % 20 == 0) ellipse(x * 1.2, y + 10.75 * r + 2.5 * r, 1.5 * r, 1.5 * r);

      if (isDark && (y + 12 * r + 3 * r) > height / 2.0f) fill(#c70067);
      ellipse(x * 1.2, y + 12 * r + 3 * r, r, r);

      xoff += inc;
    }

    start += inc;
    pop();

    logoRightLower(#ff0000);
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    if (key == 'c') isDark = !isDark;
  }
}
