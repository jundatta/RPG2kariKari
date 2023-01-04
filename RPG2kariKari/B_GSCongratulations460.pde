// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】はぅ君さん
// 【作品名】SpiritFlow
// https://twitter.com/Hau_kun/status/1401187413808979968
//

class GameSceneCongratulations460 extends GameSceneCongratulationsBase {
  float t=0;
  @Override void setup() {
  }
  @Override void draw() {
    push();
    t+=.001;
    colorMode(HSB, 360, 100, 100, 1.0f);
    blendMode(BLEND);
    noStroke();
    //background(0, .1);
    push();
    fill(0, .1);
    rect(0, 0, width, height);
    pop();
    blendMode(ADD);
    for (float r=0; r<6; r+=.005) {
      float T=tan(r*4+t*9)/2.0f;
      fill(r*60, 80, 99, T);
      float R=r*r-t;
      float A=r+t*3+sin(R+t);
      circle(cos(R)*360*sin(A)+(width/2), sin(R)*360*cos(A)+(height/2), 4/T);
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
