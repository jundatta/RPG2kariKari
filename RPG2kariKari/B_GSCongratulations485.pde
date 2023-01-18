// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】はぅ君さん
// 【作品名】午前0:14 2023年1月17日のツイート
// https://twitter.com/Hau_kun/status/1615004669029543941
//

class GameSceneCongratulations485 extends GameSceneCongratulationsBase {
  PGraphics pg;
  @Override void setup() {
    int W = width;
    int H = height;
    pg = createGraphics(W, H);
    pg.beginDraw();
    pg.background(255);
    pg.strokeWeight(3);
    pg.rectMode(CENTER);
    pg.fill(0, 255, 0);  // 線を消してるところを見てみたいｗ
    for (int y=0; y<=H; y+=20) {
      for (int x=(y/20%2)*20; x<=W; x+=40) {
        pg.noStroke();
        // (0|random(9))でfloor(random(9))なのかな。。。？
        //circle(x+cos(R=(0|random(9))*PI/2.0f)*20, y+sin(R)*20, 9);
        float R=(int)random(9)*PI/2.0f;
        pg.circle(x+cos(R)*20, y+sin(R)*20, 9);
        pg.stroke(255, 0, 0);
        pg.line(x, y, x+cos(R)*33, y+sin(R)*33);
        pg.rect(x, y, R>9?9:13, R>9?9:13, R);
      }
    }
    pg.endDraw();
  }
  @Override void draw() {
    push();
    image(pg, 0, 0);
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
