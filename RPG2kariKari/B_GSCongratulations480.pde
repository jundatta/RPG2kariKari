// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Kamoshikaさん
// 【作品名】午後2:56 2021年5月16日のツイート
// https://twitter.com/kamoshika_vrc/status/1393807644037578754
//
// ※つぶやきGLSLの詳細はこちら
// 「GLSL最短チャレンジ #つぶやきGLSL」
// https://zenn.dev/yuji_ap/articles/7f7f0cfd589bad
//

class GameSceneCongratulations480 extends GameSceneCongratulationsBase {
  PShader s;
  int startMillis;

  @Override void setup() {
    noStroke();
    s = loadShader("data/480/twigl.glsl");
    s.set("resolution", width, height);
    // 最初のミリ秒を取り込んでおく
    startMillis = millis();
  }
  @Override void draw() {
    push();
    s.set("backbuffer", getGraphics());
    s.set("time", (millis() - startMillis) / 1000.0f);
    s.set("mouse", (float)mouseX / (float)width, (float)mouseY / (float)height);
    shader(s);
    rect(0, 0, width, height);
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
