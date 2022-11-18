// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Okazzさん
// 【作品名】拡大解釈
// https://neort.io/art/ccu38jk3p9f4hhftihc0
//

class GameSceneCongratulations410 extends GameSceneCongratulationsBase {
  float minSize = 1;
  color[] colors = {#f71735, #ff9f1c, #067bc2, #ecc30b, #8c7aa9, #444444, #ffffff};
  final long SEED = floor(random(1) * 100000);

  @Override void setup() {
    background(0);
    noStroke();
  }
  @Override void draw() {
    push();
    randomSeed(SEED);
    translate(width/2, height/2);
    scale(0.95);
    translate(-width/2, -height/2);
    tiling();
    pop();

    logoRightLower(#ff0000);
  }

  class RECT {
    float xx, yy, ww, hh;
    RECT(float xx, float yy, float ww, float hh) {
      this.xx = xx;
      this.yy = yy;
      this.ww = ww;
      this.hh = hh;
    }
  }
  void tiling() {
    int gridCountW = 20;
    int gridCountH = 20;
    float gridW = (width) / (float)gridCountW;
    float gridH = (height) / (float)gridCountH;
    float emp = gridCountW * gridCountH;
    ArrayList<boolean[]> grids = new ArrayList();
    ArrayList<RECT> rects = new ArrayList();

    for (int j = 0; j < gridCountW; j++) {
      boolean[] arr = new boolean[gridCountW];
      for (int i = 0; i < gridCountH; i++) {
        arr[i] = false;
      }
      grids.add(arr);
    }

    while (emp > 0) {
      int w = int(random(1, gridCountW/2));
      // let h = int(random(1, gridCountH));
      int h = w;
      int x = int(random(gridCountW - w + 1));
      int y = int(random(gridCountH - h + 1));
      boolean lap = true;
      for (int j = 0; j < h; j++) {
        for (int i = 0; i < w; i++) {
          boolean[] bGrid = grids.get(x + i);
          if (bGrid[y + j]) {
            lap = false;
            break;
          }
        }
      }

      if (lap) {
        for (int j = 0; j < h; j++) {
          for (int i = 0; i < w; i++) {
            boolean[] bGrid = grids.get(x + i);
            bGrid[y + j] = true;
          }
        }
        float xx = x * gridW;
        float yy = y * gridH;
        float ww = w * gridW;
        float hh = h * gridH;
        rects.add(new RECT(xx, yy, ww, hh));
        emp -= w * h;
      }
    }
    for (int i = 0; i < rects.size(); i++) {
      int off = 5;
      fill(P5JS.random(colors));
      RECT r = rects.get(i);
      rect(r.xx + off, r.yy + off, r.ww - off, r.hh - off);
      divideRect(r.xx + off, r.yy + off, r.ww - off, r.hh - off, min(r.ww, r.hh) / random(3, 10));
    }
  }

  class ARR {
    float w1, w2, h1, h2;
    ARR(float w1, float w2, float h1, float h2) {
      this.w1 = w1;
      this.w2 = w2;
      this.h1 = h1;
      this.h2 = h2;
    }
    float minminmin() {
      float m = min(w1, w2);
      m = min(m, h1);
      m = min(m, h2);
      return m;
    }
  }
  void divideRect(float x, float y, float w, float h, float l) {
    int rnd = int(random(2));
    float w1 = random(1) < 0.5 ? l : w - l;
    float w2 = w - w1;
    float h1 = random(1) < 0.5 ? l : h - l;
    float h2 = h - h1;
    ARR arr = new ARR(w1, w2, h1, h2);
    if (arr.minminmin() > minSize) {
      if (rnd == 0) {
        divideRect(x, y, w1, h, l);
        divideRect(x + w1, y, w2, h, l);
      }
      if (rnd == 1) {
        divideRect(x, y, w, h1, l);
        divideRect(x, y + h1, w, h2, l);
      }
    } else {
      float off = 1;
      fill(5, 255 * map(sin(random(0.1) * frameCount), -1, 1, 0, 1));
      rect(x + off, y + off, w - off * 2, h - off * 2);
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
