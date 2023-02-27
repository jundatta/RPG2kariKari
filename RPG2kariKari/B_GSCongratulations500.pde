// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Richard Bourneさん
// 【作品名】Flat Faces Shader with p5.Graphics
// https://openprocessing.org/sketch/1711940
//

class GameSceneCongratulations500 extends GameSceneCongratulationsBase {
  PShader sh;

  @Override void setup() {
    noStroke();

    // 球の分割数をp5.jsに合わせて30から24に変えとく♪
    // （でもなんか違う...orz）
    sphereDetail(24);

    sh = loadShader("data/500/frag.glsl", "data/500/vert.glsl");
  }
  @Override void draw() {
    push();
    translate(width * 0.5f, height * 0.5f);

    background(0);

    ambientLight(80, 80, 80);
    rotateY((millis() / 1000.0f) * (PI / 4.0f));

    shader(sh);

    sphere(320);

    resetShader();
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
