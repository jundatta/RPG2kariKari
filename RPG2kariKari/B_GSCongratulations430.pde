// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】はぅ君さん
// 【作品名】（午前11:39 · 2021年1月1日のツイート）
// https://haukun.projectroom.jp/archives/1661
// （Processingとの2021年の歩み）
//

class GameSceneCongratulations430 extends GameSceneCongratulationsBase {
  float t=0;
  @Override void setup() {
    colorMode(HSB, 360);
  }
  @Override void draw() {
    push();
    t+=.005;
    blendMode(BLEND);
    //background(0, 9);
    noStroke();
    fill(0, 9);
    rect(0, 0, width, height);
    blendMode(ADD);
    float T, N;
    for (float r=0; r<TAU; r+=.03) {
      fill(r*57, 180, T=300-(sq(tan(t+r*4))*99)%360, 360-T);
//      circle(cos(r+(N=noise(r, t)-.5))*T+360, sin(r+N)*T+360, 999/T);
      circle(cos(r+(N=noise(r, t)-.5))*T+(width/2), sin(r+N)*T+(height/2), 999/T);
    }
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
