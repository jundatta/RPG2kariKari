// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Richard Bourneさん
// 【作品名】Rough Box
// https://openprocessing.org/sketch/1477982
//
// ※リチャードさんのリファレンス(オリジナルのモノクロ版)は以下です
// 【作者】watabo_shiさん
// 【作品名】Rough box
// https://openprocessing.org/sketch/1476080
//

class GameSceneCongratulations405 extends GameSceneCongratulationsBase {
  float vmin, vmax;
  //let gl, glsl;
  PGraphics tex;
  int texSize;
  final float NUM = 5;
  float sz;
  float mx, my, me = 0.01;

  PShape boxShape;

  @Override void setup() {
    pixelDensity(1);
    noStroke();
    //gl = drawingContext;
    vmin = min(width, height);
    vmax = max(width, height);
    mx = width / 2.0f;
    my = height / 2.0f;
    sz = (vmin * 0.7) / NUM;

    /**
     * Reference : https://openprocessing.org/sketch/1375027
     */
    texSize = 256;
    tex = createGraphics(texSize, texSize);
    tex.beginDraw();
    tex.background(0);
    tex.colorMode(HSB, 255, 255, 255);
    tex.noStroke();
    for (int i=0; i<texSize*texSize; i++) {
      float u=random(-1, 1);
      float x=random(2)<1?pow(u, 3):(1-pow(u, 3));
      float v=random(-1, 1);
      float y=random(2)<1?pow(v, 3):(1-pow(v, 3));
      float d=abs(1-u)+abs(1-v);
      tex.fill(d*255%255, 200, 255);
      tex.circle(x*texSize, y*texSize, d * 1.5 + 1);
    }
    tex.endDraw();
    boxShape = createShape(BOX, 1);
    boxShape.setStroke(false);
    boxShape.setTexture(tex);
  }
  @Override void draw() {
    push();
    translate(width/2, height/2);

    float sec = millis() / 1000.0f;
    mx += (mouseX - mx) * me;
    my += (mouseY - my) * me;
    float rx = map(my, 0, width, -1, 1) * PI * -0.5;
    float ry = map(mx, 0, height, -1, 1) * PI * 0.5;

    background(0);

    //gl.enable(gl.DEPTH_TEST);
    //gl.depthFunc(gl.ALWAYS);
    //gl.enable(gl.BLEND);
    //gl.blendFunc(gl.SRC_ALPHA, gl.ONE);
    blendMode(ADD);

    push();
    {
      rotateX(rx);
      rotateY(ry);

      //texture(tex);

      for (float i = 0; i < NUM; i++) {
        float z = (i - NUM / 2.0f + 0.5) * sz;
        for (float j = 0; j < NUM; j++) {
          float y = (j - NUM / 2.0f + 0.5) * sz;
          for (float k = 0; k < NUM; k++) {
            float x = (k - NUM / 2.0f + 0.5) * sz;
            push();
            {
              float d = dist(0, 0, 0, x, y, z);
              float s = map(sin(d / (vmin * 0.7 / 2 * sqrt(2)) * TWO_PI - sec), -1, 1, 1, 0);
              s = floor(s * 6) / 6.0f;
              translate(x, y, z);
              scale(s * sz);

              //box(1);
              shape(boxShape);
            }
            pop();
          }
        }
      }
    }
    pop();
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
