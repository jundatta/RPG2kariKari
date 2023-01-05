// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Sayamaさん
// 【作品名】Rough Clock2
// https://openprocessing.org/sketch/809934
//

class GameSceneCongratulations461 extends GameSceneCongratulationsBase {
  PImage img;
  PFont font;
  float ratio;
  int psec = 0;
  TimeStr strArray;

  final int OrgW = 1112;
  final int OrgH = 834;
  PGraphics pg;

  void preload() {
    img = loadImage("data/461/img_base.png");
    font = createFont("data/461/segfont.otf", 50, true);
  }

  @Override void setup() {
    preload();
    pg = createGraphics(OrgW, OrgH);
    ratio = pg.width/(float)img.width*0.7;
    pg.beginDraw();
    pg.imageMode(CENTER);
    pg.textFont(font);
    pg.endDraw();
    strArray = getTimeArray();
  }
  @Override void draw() {
    push();
    pg.beginDraw();
    pg.background(68, 132, 204);
    pg.fill(0);
    pg.rectMode(CENTER);
    pg.rect(pg.width*0.48, pg.height/2, pg.width * 0.31, pg.width*0.25);

    if (Math.floor(psec/5) != Math.floor(second()/5)) {
      strArray = getTimeArray();
    }

    //pre

    pg.textSize(pg.width*0.035);
    pg.textAlign(LEFT);
    pg.fill(255, 60);
    pg.noStroke();
    pg.text("前前前前前前前", pg.width/2-pg.width*0.14, pg.height/2-pg.width*0.052);
    pg.fill(155, 255, 171);
    pg.stroke(155, 255, 171, 100);
    pg.text(strArray.preStr, pg.width/2-pg.width*0.14, pg.height/2-pg.width*0.052);
    pg.textAlign(RIGHT);
    pg.fill(255, 60);
    pg.noStroke();
    pg.text("前前前前前前前前前前前", pg.width/2+pg.width*0.089, pg.height/2+pg.width*0.07);
    pg.fill(155, 255, 171);
    pg.stroke(155, 255, 171, 100);
    pg.text(strArray.postStr, pg.width/2+pg.width*0.089, pg.height/2+pg.width*0.07);

    //time

    pg.textSize(pg.width*0.078);
    pg.textAlign(LEFT);
    pg.fill(255, 60);
    pg.noStroke();
    pg.text("前前前前前", pg.width/2-pg.width*0.14, pg.height/2+pg.width*0.028);
    pg.fill(155, 255, 171);
    pg.stroke(155, 255, 171, 100);
    pg.text(strArray.h, pg.width/2-pg.width*0.14, pg.height/2+pg.width*0.028);
    String s = "  :";
    if (second()%2 == 0)s = "  ；";
    pg.text(s, pg.width/2-pg.width*0.14, pg.height/2+pg.width*0.028);
    pg.text("   "+strArray.m, pg.width/2-pg.width*0.14, pg.height/2+pg.width*0.028);

    pg.image(img, pg.width/2, pg.height/2, img.width*ratio, img.height * ratio);
    pg.endDraw();
    image(pg, (width - pg.width)/2, (height - pg.height)/2);

    psec  = second();
    pop();

    logoRightLower(#ff0000);
  }

  class TimeStr {
    String preStr;
    String h;
    String m;
    String postStr;
    void setTimeString(String preStr, String h, String m, String postStr) {
      this.preStr = preStr;
      this.h = h;
      this.m = m;
      this.postStr = postStr;
    }
    TimeStr(String preStr, int h, String m, String postStr) {
      String hStr = str(h);
      if (h < 10) {
        hStr = "0" + hStr;
      }
      setTimeString(preStr, hStr, m, postStr);
    }
    TimeStr(String preStr, int h, int m, String postStr) {
      String hStr = str(h);
      if (h < 10) {
        hStr = "0" + hStr;
      }
      String mStr = str(m);
      if (m < 10) {
        mStr = "0" + mStr;
      }
      setTimeString(preStr, hStr, mStr, postStr);
    }
  }

  //時刻の前に入る言葉●
  String[]  preTimeStr = {"たぶん", "だいたい", "およそ"};

  //時刻のあとに入る言葉　　現在時刻の前後で変化する文言は配列の中に配列を入れる●
  String[][] postTimeStr = {{"あたり"}, {"くらい"}, {"らへん"}, {"ちょっとまえ", "ちょっとすぎ"}, {"ちょいまえ", "ちょいすぎ"}};

  //分を省略した時刻のあとに入る言葉 [0] > 0-14分、[1] > 15-29分、[2] > 30-44分、[3] > 45-59分（時間が+1表記に）●
  String[][] postQuarterTimeStr = {{"すぎ", "ごろ", "ちょっとすぎ"}, {"ちょっとまえ", "くらい"}, {"すぎ", "ごろ"}, {"ちょいまえ", "まえ", "ちょっとまえ"}};

  //時刻の前に入る言葉を使用する
  int deletePreTimeStr = 0;//0 : 使う、1 : 使わない

  //時刻文字列の配列生成
  TimeStr getTimeArray() {
    int step = 5;
    int ho = hour();
    int mi = minute();
    float r = random(1);
    TimeStr out;
    //乱数から２つのメソッドどちらかを使用●
    if (r < 0.5)out = gerRoughTime(step, ho, mi);
    else out = getRoughTimeQuarter(ho, mi);
    return out;
  }

  //配列生成（分あり）
  TimeStr gerRoughTime(int step, int ho, int mi) {
    //getime
    int h = ho;
    int minShift = floor(step/2);
    int m = mi + minShift;
    boolean mae = false;
    if (m%step <= minShift) mae = true;
    m -= m%step;
    if (m >= 60) {
      m = m%60;
      h = (h+1)%24;
    }

    String preStr = preTimeStr[floor(random(preTimeStr.length))];
    String[] postArray = postTimeStr[floor(random(postTimeStr.length))];
    String postStr = postArray[0];
    if (1 < postArray.length) {
      if (!mae)postStr = postArray[1];
    }
    TimeStr out = new TimeStr(preStr, h, m, postStr);
    return out;
  }

  //配列生成（分なし）
  TimeStr getRoughTimeQuarter(int ho, int mi) {
    String preStr = preTimeStr[floor(random(preTimeStr.length))];
    int index = floor(mi/15);
    if (index == 3) ho = (ho+1)%24;
    String postStr = postQuarterTimeStr[index][floor(random(postQuarterTimeStr[index].length))];

    TimeStr out;
    if (index == 0 || index == 3) {
      out = new TimeStr(preStr, ho, "ジ", postStr);
    } else {
      out = new TimeStr(preStr, ho, "ハン", postStr);
    }
    return out;
  }

  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
