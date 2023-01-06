// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】はぅ君さん
// 【作品名】Sparkler
// https://twitter.com/Hau_kun/status/1164181159783223296
//

class GameSceneCongratulations470 extends GameSceneCongratulationsBase {
  float r, d, a, b;

  final int OrgWH = 102;
  PGraphics pg;
  @Override void setup() {
    pg = createGraphics(OrgWH, OrgWH);
  }
  @Override void draw() {
    push();
    pg.beginDraw();
    pg.noStroke();
    pg.fill(0, 64);
    pg.rect(0, 0, width, height);
    //pg.background(0, 1);  // なぜかいけるｗ => イケてなかった＼(^_^)／
    pg.stroke(-1);
    pg.line(50, 0, 50, 50);
    r=random(360);
    d=random(30);
    for (int j=0; j<15; j++) {
      a=random(360);
      b=random(20);
      pg.line(cos(r)*d+50, sin(r)*d+50, cos(r)*d+cos(a)*b+50, sin(r)*d+sin(a)*b+50);
    }
    pg.endDraw();
    image(pg, 0, 0, width, height);
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
