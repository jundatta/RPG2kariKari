// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】はぅ君さん
// 【作品名】DailyCodingChallenge_Sky
// https://twitter.com/Hau_kun/status/1361310464114712591
//

class GameSceneCongratulations465 extends GameSceneCongratulationsBase {
  float t=0;
  float W;
  @Override void setup() {
    W = width;
    noStroke();
  }
  @Override void draw() {
    push();
    for (int y=0; y<height; y+=9) {
      float Y=y/6.0f;
      fill(Y, Y, y/2.0f);
      rect(0, y, W, 9);
    }
    t+=.01;
    for (int i=0; i<999; i++) {
      float T=tan(t+(int(i/99))*.3)*30;
      fill(W, T);
      circle(sin(t)*50+cos(noise(i)*9)*T*9+(width/2), sin(t*2)*50+sin(noise(i/9.0f))*T*5+(height/2), T*2);
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
