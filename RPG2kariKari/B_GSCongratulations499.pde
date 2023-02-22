// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】KomaTebeさん
// 【作品名】Wormhole
// https://openprocessing.org/sketch/1591528
//

class GameSceneCongratulations499 extends GameSceneCongratulationsBase {
  float f = 0;
  PGraphics g;
  int w = 512;
  PShape t1;
  @Override void setup() {
    g = createGraphics(w, w);
    //  torus(-400, -300, 32, 64); //170
    t1 = createTorus(-400, -300, 32, 64);
  }
  @Override void draw() {
    push();
    translate(width * 0.5f, height * 0.5f);

    float W = 400;
    f++;
    rotate(PI/2.0f);
    noStroke();
    //  orbitControl();
    background(0);
    g.beginDraw();
    g.background(0);
    g.stroke(W);
    for (int i = 0; i < 1024; i += 10) {
      g.line(-w, 0, w, i - (f) % 10);
      g.line(0, -w, i, w);
    }
    g.endDraw();
    //  [2, 1, -2, -2].map(i => spotLight(W, W, W, i * W, i * W, 0, -i, -i, 0));
    float i;
    i = 2;
    spotLight(W, W, W, i * W, i * W, 0.0f, -i, -i, 0.0f, PI/3.0f, 100.0f);
    i = 1;
    spotLight(W, W, W, i * W, i * W, 0.0f, -i, -i, 0.0f, PI/3.0f, 100.0f);
    i = -2;
    spotLight(W, W, W, i * W, i * W, 0.0f, -i, -i, 0.0f, PI/3.0f, 100.0f);
    i = -2;
    spotLight(W, W, W, i * W, i * W, 0.0f, -i, -i, 0.0f, PI/3.0f, 100.0f);
    push();
    rotate(PI / 2.0f);
    translate(400, 0, 0);
    rotateY(-1);
    translate(-300, 0, 0);
    for (float y = -W; y <= W; y += 100) {
      push();
      translate(0, 0, y - f % 100);
      //torus(abs(y - f % 100) / 2 + 40, (W - abs(y - f % 100)) / 77, 64, 4);
      PShape t0 = createTorus(abs(y - f % 100) / 2.0f + 40, (W - abs(y - f % 100)) / 77.0f, 64, 4);
      shape(t0);
      pop();
    }
    //  texture(g);
    //  torus(-400, -300, 32, 64); //170
    t1.setTexture(g);
    shape(t1);
    pop();
    translate(0, -120 + noise(f/22.0f)*30, 0);
    sphere(50);
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
