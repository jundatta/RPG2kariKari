// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Richard Bourneさん
// 【作品名】Ice Planet
// https://openprocessing.org/sketch/1417946
//

class GameSceneCongratulations413 extends GameSceneCongratulationsBase {
  PShader theShader;

  void preload() {
    theShader = loadShader("data/413/frag.glsl", "data/413/vert.glsl");
  }
  @Override void setup() {
    preload();
    noStroke();
  }
  @Override void draw() {
    push();
    translate(width/2, height/2);

    background(0);
    shader(theShader);

    // ※frameCountが(int)で落ちるので(float)のキャストをつける
    theShader.set("uFrameCount", (float)frameCount);

    rotateX(radians(frameCount * 0.002));
    rotateY(radians(frameCount * 0.001));

    sphere(height / 2.8);
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
