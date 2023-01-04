// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Sayamaさん
// 【作品名】200621
// https://openprocessing.org/sketch/919601
//

class GameSceneCongratulations456 extends GameSceneCongratulationsBase {
  color[][] palette = {
    {#0e6245, #f9e54d, #18302b},
    {#b10b0b, #fc995f, #3f1732},
    {#393232, #f3e4af, #000000}
  };
  int UNIT = 10;
  color bgCol, lineCol, holeCol;

  PGraphics pg;

  @Override void setup() {
    //noLoop();
    bgCol = P5JS.random(palette[0]);
    lineCol = P5JS.random(palette[1]);
    holeCol = P5JS.random(palette[2]);

    background(bgCol);

    pg = createGraphics(width, height);
    pg.beginDraw();
    drawOffscreen(pg);
    pg.endDraw();
  }

  void drawOffscreen(PGraphics pg) {
    pg.background(bgCol);
    float noff = random(100);
    float sw = UNIT/5.0f;
    float miconSpan = UNIT*20;

    PGraphics holerGra = createGraphics(width, height);
    PGraphics partsGra = createGraphics(width, height);

    holerGra.beginDraw();
    partsGra.beginDraw();

    //line
    for (float i = 0; i < 30; i++) drawLine(pg, unitNum(random(width)), unitNum(random(height)), noff, sw*2, holerGra);

    //parts
    for (float y = 0; y < height; y += miconSpan) {
      for (float x = 0; x < width; x += miconSpan) {
        int cx = unitNum(x + random(miconSpan*0.3));
        int cy = unitNum(y + random(miconSpan*0.3));
        if (random(1) > 0.2)micon(pg, partsGra, cx, cy, int(random(1, 15)), noff, sw, holerGra);
        else {
          drawLine(pg, cx, cy, noff, sw, holerGra);
          drawLine(pg, cx, cy + UNIT, noff, sw, holerGra);
          partsGra.noStroke();
          partsGra.fill(holeCol);
          int wh = int(random(1, 5))*UNIT;
          partsGra.ellipse(cx, cy, wh, wh);
        }
      }
    }

    //line
    //  for (int i = 0; i < 1000; i++) drawLine(pg, unitNum(random(width)), unitNum(random(height)), noff, sw, holerGra);
    for (int i = 0; i < (int)(1000 * 0.1f); i++) drawLine(pg, unitNum(random(width)), unitNum(random(height)), noff, sw, holerGra);

    holerGra.endDraw();
    partsGra.endDraw();

    //layer
    pg.image(holerGra, 0, 0);
    pg.image(partsGra, 0, 0);

    //noise
    pg.noStroke();
    pg.fill(255, 20);
    //for (float i = 0; i < width*height; i++) {
    for (float i = 0; i < width*height * 0.1f; i++) {
      float x = random(width);
      float y = random(height);
      float s = noise(x*0.01, y*0.01)*1 + 0.5;
      pg.rect(x, y, s, s);
    }
  }

  @Override void draw() {
    push();
    image(pg, 0, 0);
    pop();

    logoRightLower(#ff0000);
  }

  /////////////

  int unitNum(float num) {
    return floor(num/UNIT)*UNIT;
  }

  /////////////

  void drawLine(PGraphics pg, int x, int y, float noiseoff, float w, PGraphics holerGra) {
    color col = getGraphics().get(x, y);
    if (abs(brightness(col) - brightness(lineCol)) < 5)return;
    //setting
    float c = 50;
    float px = x;
    float py = y;
    float t = random(1);
    boolean reverse = random(1) > 0.5 ? true : false;
    float scl = 0.01;
    pg.stroke(lineCol);
    pg.strokeWeight(w);
    pg.noFill();
    //draw
    hole(holerGra, x, y, UNIT*0.8);
    for (float i = 0; i < c; i++)
    {
      float angle = P5JS.map(int(noise(x* scl +noiseoff, y * scl + noiseoff, t)*9), 0, 8, 0, TAU, true);
      if (reverse)angle  = PI-angle;
      pg.line(x, y, px, py);
      px = x;
      py = y;
      x += round(cos(angle)) * UNIT;
      y += round(sin(angle)) * UNIT;
      //線に当たったら終了
      col = getGraphics().get(x, y);
      if (abs(brightness(col) - brightness(lineCol)) < 5) {
        pg.line(x, y, px, py);
        pg.circle(x, y, UNIT*0.2);
        break;
      }
      //最後までいったら
      if (i == c-1)hole(holerGra, px, py, UNIT*0.8);
    }
  }

  void micon(PGraphics pg, PGraphics partsGra, float cox, float coy, int pinNum, float noff, float sw,
    PGraphics holerGra)
  {
    boolean rot = random(1) > 0.5 ? true : false;
    int x = unitNum(cox);
    int y = unitNum(coy);
    int h = pinNum * UNIT;
    int w = max(UNIT, unitNum(h * random(0.2, 0.6)));

    if (rot ==false) {
      for (int p = y; p <= y + h; p += UNIT) {
        drawLine(pg, x, p, noff, sw, holerGra);
        hole(holerGra, x, p, UNIT*0.8);
        drawLine(pg, x + w, p, noff, sw, holerGra);
        hole(holerGra, x + w, p, UNIT*0.8);
      }
      partsGra.noStroke();
      partsGra.fill(holeCol);
      partsGra.rect(x + UNIT*0.1, y, w-UNIT*0.2, h);
    } else {
      for (int p = x; p <= x + h; p += UNIT) {
        drawLine(pg, p, y, noff, sw, holerGra);
        hole(holerGra, p, y, UNIT*0.8);
        drawLine(pg, p, y+w, noff, sw, holerGra);
        hole(holerGra, p, y+w, UNIT*0.8);
      }
      partsGra.noStroke();
      partsGra.fill(holeCol);
      partsGra.rect(x, y + UNIT*0.1, h, w-UNIT*0.2);
    }
  }

  void hole(PGraphics holerGra, float x, float y, float dia) {
    holerGra.noStroke();
    holerGra.fill(lineCol);
    holerGra.circle(x, y, dia);
    holerGra.fill(holeCol);
    holerGra.circle(x, y, dia-UNIT*0.4);
  }

  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
