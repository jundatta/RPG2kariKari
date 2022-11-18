// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】SamuelYANさん
// 【作品名】MovingArc_3
// https://openprocessing.org/sketch/1471274
//

class GameSceneCongratulations409 extends GameSceneCongratulationsBase {
  // by SamuelYAN
  // more works //
  // https://twitter.com/SamuelAnn0924
  // https://www.instagram.com/samuel_yan_1990/

  int seed;
  float angle_c;
  color[] colors = new color[5];
  color[] colors0 = {#4596c7, #6d8370, #e45240, #21d3a4, #3303f9};
  color[] colors1 = {#cd2220, #173df6, #244ca8, #a00360, #b31016};
  color[] colors2 = {#7382ce, #9fb7f4, #12177d, #9bb5e9, #7486af};
  color[] colors3 = {#82d362, #5c5190, #6c6dd1, #3d6966, #5967ca};
  color[] colors4 = {#8c75ff, #c553d2, #2dfd60, #2788f5, #23054f};
  color[] colors5 = {#f21252, #8834f1, #c4dd92, #184fd3, #f9fee2};
  color[] colors6 = {#2E294E, #541388, #F1E9DA, #FFD400, #D90368};
  color[] colors7 = {#1b1b1b, #292929, #f3f3f3, #222222, #ff0000};
  color[] color_setup;

  PGraphics pg;

  @Override void setup() {
    seed = int(random(1000));
    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.colorMode(HSB, 360, 100, 100, 100);
    pg.background(0, 0, 95);
    pg.endDraw();
    image(pg, 0, 0);
    //color_setup = random([colors0, colors1, colors2, colors3, colors4, colors5, colors6, colors7]);
    ArrayList<color[]> colorArray = new ArrayList();
    colorArray.add(colors0);
    colorArray.add(colors1);
    colorArray.add(colors2);
    colorArray.add(colors3);
    colorArray.add(colors4);
    colorArray.add(colors5);
    colorArray.add(colors6);
    colorArray.add(colors7);
    int idx = (int)random(colorArray.size());
    color_setup = colorArray.get(idx);
    angle_c = 0;
  }
  @Override void draw() {
    push();
    pg.beginDraw();
    randomSeed(seed);
    //background(0, 0, 95, 1);
    pg.noStroke();
    pg.fill(0, 0, 95, 1);
    pg.rect(0, 0, width, height);
    pg.translate(width / 2, height / 2);
    pg.rotate(angle_c);
    for (int i = 0; i < 4; i++) {
      colors[0] = P5JS.random(color_setup);
      colors[1] = P5JS.random(color_setup);
      colors[2] = P5JS.random(color_setup);
      colors[3] = P5JS.random(color_setup);
      colors[4] = P5JS.random(color_setup);
      circleForm(pg, 0, 0, width * 0.5f * (i+1));
    }
    angle_c += TAU/3600.0f/0.5;
    pg.endDraw();
    image(pg, 0, 0);
    pop();

    logoRightLower(#ff0000);
  }

  void circleForm(PGraphics pg, float x, float y, float d) {
    int branch = int(random(30, 15));
    float ang = TAU / (float)branch;
    FloatList angles = new FloatList();
    for (int i = 0; i < branch; i++) {
      angles.append(ang * (i + iteration(0.1, 0.25)));
    }
    for (int i = 0; i < branch; i++) {
      float ang1 = angles.get(i);
      float ang2 = angles.get((i + int(random(6))) % angles.size());
      float dd = d * iteration(0.1, 1);
      pg.noFill();
      // drawingContext.shadowColor = random(colors);
      // drawingContext.shadowOffsetX = 2;
      // drawingContext.shadowOffsetY = 2;
      // drawingContext.shadowBlur = 0;
      pg.stroke(P5JS.random(colors));

      pg.strokeCap(SQUARE);
      pg.strokeWeight(random(5));
      pg.arc(x, y, dd, dd, ang1, ang2);
    }
  }

  float iteration(float s, float e) {
    float t = random(10, 100);
    float v = random(0.001, 0.01);
    return map(cos(t + frameCount * v), -1, 1, s, e);
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
