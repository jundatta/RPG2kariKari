// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】はぅ君さん
// 【作品名】Shining floor
// https://openprocessing.org/sketch/1771165
//

class GameSceneCongratulations422 extends GameSceneCongratulationsBase {
  final int PIXEL_SIZE = 10;

  int[][] a;
  float vmax = 0.0f;
  Mode mode;
  float t = 0.0f;

  class Mode {
    void draw(int x, int y) {
      println("これは呼ばれないでねw" + "(" + x + "," + y + ")");
    }
    void judgeReStart() {
      // 遷移しない
    }
  }
  class Mode1 extends Mode {
    Mode1() {
      a = new int[width/PIXEL_SIZE+1][];
      t=0;
      for (int x=0; x<a.length; x++) {
        a[x]= new int[height/PIXEL_SIZE+1];
        for (int y=0; y<a[x].length; y++) {
          a[x][y]=0;
        }
      }

      int tx = int(random(a.length));
      int ty = int(random(a[0].length));
      a[tx][ty]=1;

      while (!fillCell())
      {
        // 何もしない
      }
      for (int x=0; x<a.length; x++) {
        for (int y=0; y<a[x].length; y++) {
          a[x][y]=abs(a[x][y]);
        }
      }
    }
    void draw(int x, int y) {
      if (a[x][y]<t) {
        float s = min(t-a[x][y], 20);
        float r=noise(x, y)*9*TAU;
        fill(a[x][y]/vmax*360.0f, 80, 100, tan(s/20.0f));
        square(x*10+tan((s-20)/500.0f)*cos(r), y*10+tan((s-20)/500.0f)*sin(r), 15/tan(s/20.0f));
      }
      if ((t-vmax)>10) {
        mode = new Mode2();
      }
    }
  }
  class Mode2 extends Mode {
    void draw(int x, int y) {
      if (a[x][y]<t) {
        float s = min(t-a[x][y], 20);
        fill(a[x][y]/vmax*360.0f, 80, 150-(t-vmax)*2, tan(s/20.0f));
        square(x*10, y*10, 15/tan(s/20.0f));
      }
    }
    void judgeReStart() {
      if (t-vmax>100) {
        mode = new Mode1();
      }
    }
  }

  boolean fillCell() {
    boolean allFill = true;
    vmax=0;
    for (int x=0; x<a.length; x++) {
      for (int y=0; y<a[x].length; y++) {
        if (a[x][y]==0) {
          allFill = false;
          break;
        }
        vmax = max(vmax, a[x][y]);
      }
    }
    if (allFill) {
      return true;
    }

    for (int x=0; x<a.length; x++) {
      for (int y=0; y<a[x].length; y++) {
        if (a[x][y]>0) {
          int v=int(random(1)*2)*2-1;
          int va=random(1)>.5?v:0;
          int vb=(va==0)?v:0;
          int tx = x + va;
          int ty = y + vb;

          if (tx>=0 && ty >= 0 && tx < a.length && ty < a[x].length) {
            if (a[tx][ty]==0) {
              a[tx][ty]=a[x][y]+1;
              a[x][y]*=-1;
            }
          }
        } else if (random(1)<.001) {
          a[x][y]*=-1;
        }
      }
    }
    return false;
  }

  @Override void setup() {
    mode = new Mode1();
  }
  @Override void draw() {
    push();
    rectMode(CENTER);
    colorMode(HSB, 360, 100, 100, 1.0f);
    noStroke();

    blendMode(BLEND);
    background(0);
    blendMode(ADD);
    t+=.5;
    for (int x=0; x<a.length; x++) {
      for (int y=0; y<a[x].length; y++) {
        mode.draw(x, y);
      }
    }
    mode.judgeReStart();
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
