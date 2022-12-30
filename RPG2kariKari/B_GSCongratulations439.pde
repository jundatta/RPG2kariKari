// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】はぅ君さん
// 【作品名】trophy
// https://twitter.com/Hau_kun/status/1420362864888475653
//

class GameSceneCongratulations439 extends GameSceneCongratulationsBase {
  float t=0;
  @Override void setup() {
  }
  @Override void draw() {
    push();
    t+=.01;
    colorMode(HSB, 360, 100, 100, 1.0f);
    blendMode(BLEND);
    background(0);
    blendMode(ADD);
    strokeWeight(5);
    for (float r = 0; r<TAU; r+=.01) {
      stroke((r*60+t*99)%360, 100, 100, .1);
      line(cos(r*6-t)*360+width/2, atan(9)*360+height/2, atan(cos(r+t))*360+width/2, atan(sin(r+t))*360+height/2);
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
