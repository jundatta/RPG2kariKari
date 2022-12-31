// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】はぅ君さん
// 【作品名】2022年2月12日 午後3:52 ツイートの「つぶやきProcessing」
// はぅ君プロジェクト＼(^_^)／「型くりこ／Tangent Cross/タンジェントクロス」
// https://twitter.com/Hau_kun/status/1492391109422575621
//

class GameSceneCongratulations450 extends GameSceneCongratulationsBase {
  float t=0;
  float W = 720;

  @Override void setup() {
  }
  @Override void draw() {
    push();
    t+=.02;
    colorMode(HSB, 360, 100, 100, 1.0f);
    blendMode(BLEND);
    push();
    noStroke();
    fill(0, .1);
    rect(0, 0, width, height);
    pop();
    blendMode(ADD);
    for (int i=48; i-- != 0; ) {
      beginShape();
      for (float r=0; r<1; r+=.2) {
        float R=r+i/4.0f+t;
        fill(R*60%360, 80, W, .1);
        float D=i%6*60;
        vertex(cos(R+i)*D+(width/2), tan(-R)*D+(height/2));
      }
      endShape();
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
