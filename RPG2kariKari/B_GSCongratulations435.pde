// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】kikpondさん
// 【作品名】Night view from the summit #2
// https://openprocessing.org/sketch/1332776
//

class GameSceneCongratulations435 extends GameSceneCongratulationsBase {
  float t;
  float[] mountainHeights;
  color c1, c2;

  PGraphics pg;

  @Override void setup() {
    mountainHeights = new float[width];
    background(0);
    init();

    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.background(0);
    gradationBackground(pg, 0, 0, width, height, c1, c2);
    starLight(pg);
    moon(pg);
    deppMountain(pg);
    townLight(pg, 1000);
    townLightLines(pg, 50);
    mountain(pg);
    pg.endDraw();
  }
  @Override void draw() {
    push();
    image(pg, 0, 0);
    pop();

    logoRightLower(#ff0000);
  }

  void init() {
    t = 0;
    noiseSeed(int(random(5)));
    for (int x = 0; x < width; x++) {
      float n = noise(t);
      t += 0.01;
      mountainHeights[x] = n * 100;
    }
    c1 = color(0);
    c2 = color(0, 102, int(random(100, 255)));
  }

  void gradationBackground(PGraphics pg, float x, float y, float w, float h, color _c1, color _c2) {
    for (float i = y; i <= y + h; i += 1) {
      float inter = map(i, y, y + h, 0, 1);
      //float c = lerpColor(_c1, _c2, inter);  // きゃあ＼(^_^)／
      color c = lerpColor(_c1, _c2, inter);    // うぎゃぁぁあああああああ！！
      pg.stroke(c);
      pg.line(x, i, x + w, i);
    }
  }

  void mountain(PGraphics pg) {
    pg.push();
    pg.stroke(0);
    pg.strokeWeight(5);
    float rand = random(1.1, 1.7);
    for (int x = 0; x < width; x++) {
      pg.line(x, height, x, ((height - rand * 100) - mountainHeights[x]));
    }
    pg.pop();
  }

  void deppMountain(PGraphics pg) {
    pg.push();
    pg.stroke(10);
    pg.strokeWeight(1);
    float rand = random(0.1, 1.3);
    for (int x = width-1; x > 0; x--) {
      pg.line(width - x, height / 2 + 10, width - x, height / 2 - (mountainHeights[x] * rand));
    }
    pg.pop();
  }

  void townLight(PGraphics pg, float num) {
    pg.push();
    pg.noStroke();
    for (int i = 0; i < num; i++) {
      float x = random(0, width);
      float y = random(height / 2, height / 2 + height / 10.0f);
      float r = map(y, height / 2, height, 1, 2);
      pg.fill(255);
      pg.ellipse(x, y, r, r);
    }

    for (int i = 0; i < num * 3; i++) {
      float x = random(0, width);
      float y = random(height / 2, height / 2 + height / 10.0f);
      float r = map(y, height / 2, height, 1, 2);
      int rand = int(random(360));
      //fill('hsla(' + rand + ', 100%, 50%, 0.5)');
      color c = P5JS.hsla2rgba(rand, 100, 50, 0.5f);
      pg.fill(c);
      pg.ellipse(x, y, r, r);
    }

    for (int i = 0; i < num; i++) {
      float x = random(0, width);
      float y = random(height / 2, height);
      float r = map(y, height / 2, height, 1, 10);
      pg.fill(255);
      pg.ellipse(x, y, r, r);
    }

    for (int i = 0; i < num * 2; i++) {
      float x = random(0, width);
      float y = random(height / 2, height);
      float r = map(y, height / 2, height, 1, 10);
      int rand = int(random(100));
      //fill('hsla(' + rand + ', 100%, 80%, 1)');
      color c = P5JS.hsla2rgba(rand, 100, 80, 1.0f);
      pg.fill(c);
      pg.ellipse(x, y, r, r);
    }
    pg.pop();
  }

  void starLight(PGraphics pg) {
    pg.push();
    float rand = random(100, 200);
    for (int i = 0; i < rand; i++) {
      float x = random(0, width);
      float y = random(0, 300);
      pg.noStroke();
      pg.fill(255);
      pg.ellipse(x, y, 1, 1);
    }
    pg.pop();
  }

  void moon(PGraphics pg) {
    pg.push();
    pg.noStroke();
    float moonX = random(100, width - 100);
    float moonY = random(100, height / 2 - 100);
    float diamater = random(20, 80);
    for (int i = 0; i < diamater; i++) {
      int c = int(map(i, 0, 100, 80, 100));
      //fill('hsla(200, 50%,' + c + '%, 0.3)');
      color col = P5JS.hsla2rgba(200, 50, c, 0.3f);
      pg.fill(col);
      pg.ellipse(moonX, moonY, diamater - i, diamater - i);
    }
    pg.pop();
  }

  void townLightLine(PGraphics pg, float x, float y, float x2, float y2, float leng) {
    float angle = atan2(y2 - y, x2 - x);
    int randColor = int(random(100));
    pg.push();
    pg.noStroke();
    // HSLとHSBは違うらしい...orz
    // https://www.peko-step.com/tool/hslrgb.html#ppick1
    //colorMode(HSB, 360, 100, 100, 1.0f);  // きゃあ＼(^_^)／
    for (int i = 0; i < 1000; i += 10) {
      float rand = random(leng);
      float px = x + cos(angle) * rand;
      float py = y + sin(angle) * rand;
      //fill('hsla(' + randColor + ', 100%, 90%, 1)');  // きゃあきゃあきゃあぁあああ＼(^_^)／
      color c = P5JS.hsla2rgba(randColor, 100, 90, 1.0f);
      pg.fill(c);
      pg.ellipse(px, py, py / 150.0f, py / 150.0f);
    }
    pg.pop();
  }

  void townLightLines(PGraphics pg, float num) {
    for (int i = 0; i < num; i++) {
      float x = random(width);
      float y = random(height / 2, height / 2 + 100);
      float x2 = random(x, width);
      float y2 = random(y, height);

      townLightLine(pg, x, y, x2, y2, 400);
    }
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
