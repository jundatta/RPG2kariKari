// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Richard Bourneさん
// 【作品名】Cat on a Cool Tile Roof
// https://openprocessing.org/sketch/1586945
//

class GameSceneCongratulations490 extends GameSceneCongratulationsBase {
  PGraphics pg;
  // オリジナルはflameRate(5)なので1/5秒で描画したい
  final int DRAW_TIMMING = (int)(1.0f/5.0f * 1000.0f);  // 単位[ms]
  int drawingTime = millis();

  float Width=600;
  float Height=450;
  float pixel=1;

  int Y_AXIS = 1;
  int X_AXIS = 2;

  float skyHeight=190;
  float wall_Width=600;
  float wall_Height=300;
  float wuyan_width=120;
  float wuyan_height=20;
  float quad_width=70;
  float quad_height=30;
  float center_x=500;
  float center_y=115;
  float cat_scale=111;
  float easing=1;
  float Time;

  @Override void setup() {
    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.background(0);
    pg.endDraw();
  }
  @Override void draw() {
    // 1/5秒（frameRate(5)）で描画する
    int now = millis();
    if (now < drawingTime + DRAW_TIMMING) {
      return;
    }
    drawingTime = now;

    push();
    pg.beginDraw();
    drawwall(pg);
    drawsky(pg);
    pg.push();
    pg.translate(10, -5);
    YinxingTree(pg);
    pg.pop();

    draw_wallshadow(pg);

    if (center_x<-10)
      center_x=650;
    center_x-=15*easing;
    drawcat(pg, cat_scale, center_x, center_y);

    pg.translate(10, -25);
    pg.noStroke();
    pg.fill(30);
    pg.rect(Width-10, 0, 200, Height);

    pg.push();
    YinxingTree(pg);
    pg.pop();
    pg.endDraw();
    image(pg, 0, 0);
    pop();

    logoRightLower(#ff0000);
  }

  void drawcat(PGraphics pg, float cat_scale, float center_x, float center_y)
  {
    pg.stroke(200, 200, 240);
    pg.noStroke();
    //肚子
    float pos1_x=center_x-(cat_scale)/3.0f;
    float pos1_y=center_y+(cat_scale)*2/5-5;

    float pos2_x=center_x+(cat_scale*1/3.0f);
    float pos2_y=center_y+(cat_scale)*2/5.0f;

    //前体
    float pos3_x=pos1_x-(cat_scale/5.0f);
    float pos3_y=center_y+(cat_scale)*2/5.0f;

    float pos4_x=pos1_x-(cat_scale/8.0f);
    float pos4_y=center_y+(cat_scale)/15.0f;

    float pos5_x=pos4_x-(cat_scale/8.0f);
    float pos5_y=pos4_y-(cat_scale)/20.0f;

    //头
    float pos6_x=pos5_x-(cat_scale/4.0f);
    float pos6_y=pos5_y-(cat_scale)/6.0f;

    float pos7_x=pos5_x-(cat_scale/6.0f);
    float pos7_y=pos5_y-(cat_scale)/30.0f;

    float pos8_x=pos5_x-(cat_scale)*3/8.0f;
    float pos8_y=pos5_y+(cat_scale)/8.0f;

    float pos9_x=pos8_x+(cat_scale)/5.0f;
    float pos9_y=pos8_y+(cat_scale)/5.0f;

    //屁股
    float pos10_x=pos2_x-(cat_scale/4)*0;
    float pos10_y=pos2_y-(cat_scale)*1/3.0f;

    float pos11_x=pos10_x+(cat_scale*1/8.0f);
    float pos11_y=pos10_y+(cat_scale)/10.0f;

    pg.fill(150, 70, 10);
    pg.triangle(center_x, center_y, pos1_x, pos1_y, pos2_x, pos2_y-6);
    pg.triangle(center_x, center_y, pos1_x, pos1_y, pos3_x, pos3_y);

    pg.fill(220, 200, 180);
    pg.triangle(center_x, center_y+32, pos1_x, pos1_y, pos2_x, pos2_y);

    pg.fill(150, 70, 10);
    pg.triangle(center_x, center_y, pos3_x, pos3_y, pos4_x, pos4_y);
    pg.triangle(pos3_x, pos3_y, pos4_x, pos4_y, pos5_x, pos5_y);
    pg.triangle(pos3_x, pos3_y, pos5_x, pos5_y, pos6_x, pos6_y);

    pg.fill(150, 70, 10);
    pg.triangle(pos3_x, pos3_y, pos7_x, pos7_y, pos8_x, pos8_y);
    pg.triangle(pos8_x+4, pos8_y+10, pos9_x, pos9_y-8, pos5_x, pos5_y);
    pg.triangle(pos8_x+4, pos8_y+10, pos8_x, pos8_y, pos5_x, pos5_y);

    pg.fill(150, 70, 10);
    pg.triangle(center_x, center_y, pos2_x, pos2_y, pos10_x, pos10_y);
    pg.triangle(pos2_x, pos2_y, pos10_x, pos10_y, pos11_x, pos11_y);

    pg.fill(180);
    feetControl(pg, pos1_x-10, pos1_y);
    feetControl(pg, pos2_x+3, pos2_y-4);

    pg.noFill();
    weiba(pg, pos11_x, pos11_y);
  }

  void weiba(PGraphics pg, float x, float y)
  {
    pg.push();
    pg.strokeWeight(10);
    pg.stroke(150, 70, 10);
    float x1=x-20;
    float y1=y;

    float x2=x+20;
    float y2=y-20;

    float x3=x+25;
    float y3=y+5;

    float x4=x+55;
    float y4=y-20;

    pg.bezier(x1, y1, x2, y2, x3, y3, x4, y4);
    pg.noStroke();
    pg.pop();
  }

  void feetControl(PGraphics pg, float x, float y)
  {
    pg.fill(150, 70, 10);
    if (x%2==0)
    {
      pg.rect(x-(cat_scale)/10.0f, y-8, (cat_scale)/10.0f, (cat_scale)*1/3.0f+8, 5, 5, 5, 5);
    } else
    {
      pg.quad(x, y-10,
        x-(cat_scale)/10.0f, y-10,
        x-(cat_scale)/10.0f+(cat_scale/10.0f), y+(cat_scale)*1/3.0f,
        x+(cat_scale/10.0f), y+(cat_scale)*1/3.0f);

      pg.quad(x, y-15,
        x-(cat_scale)/10.0f, y-15,
        x-(cat_scale)/10.0f-(cat_scale/5.0f), y+(cat_scale)*1/3.0f,
        x-(cat_scale/5.0f), y+(cat_scale)*1/3.0f);
    }
  }

  void draw_wallshadow(PGraphics pg)
  {
    pg.noStroke();
    color c1=color(160, 10, 0);
    color c2=color(80, 10, 80);
    setGradient(pg, 0, 450, Width, 150, c1, c2, 1);

    pg.noStroke();
    pg.fill(160, 10, 0);
    for (float i=0; i<Width; i++)
    {
      pg.arc(i, 600, 50, 15, PI, 0);
      i=i+80;
    }
  }

  void drawwall(PGraphics pg)
  {
    pg.noStroke();
    pg.fill(100, 10, 0);
    pg.rect(0, 0, Width, Height);

    pg.fill(190, 70, 20);
    pg.rect(0, Height/2.0f-wall_Height, wall_Width, wall_Height);

    drawWuYan1(pg);
    drawWuYan2(pg);
    drawWuYan3(pg);
    drawWuYan4();
  }

  void drawWuYan1(PGraphics pg)
  {
    pg.stroke(20);
    pg.fill(190, 100, 10);
    for (float i=0; i<Width; i++)
    {
      pg.rect(i-5, wall_Height+70, wuyan_width, wuyan_height);
      i=i+wuyan_width;
    }
  }

  void drawWuYan2(PGraphics pg)
  {
    color cwu2_1=color(50, 120, 30);
    color cwu2_2=color(60, 10, 0);

    for (float j=0; j<Width+80; j++)
    {
      setGradient(pg, j-65, wall_Height+35,
        wuyan_width, wuyan_height+10,
        cwu2_1, cwu2_2, 1);
      pg.stroke(180, 130, 20);
      pg.rect(j-65, wall_Height+36,
        wuyan_width, wuyan_height+10);
      j=j+wuyan_width;
    }

    color cwu3_1=color(10, 20, 10);
    color cwu3_2=color(80, 100, 20);
    fill(50, 120, 30);
    setGradient(pg, 0, wall_Height-15,
      Width, 50, cwu3_1, cwu3_2, 1);
  }

  void drawWuYan3(PGraphics pg)
  {
    pg.noStroke();
    pg.fill(190, 150, 90);
    for (float k=0; k<Width; k++)
    {
      pg.rect(k, skyHeight, wuyan_width, 10);
      k=k+wuyan_width;
    }

    pg.fill(190, 100, 10);
    pg.rect(0, skyHeight+15, Width, 12);
    pg.fill(190, 110, 30);
    pg.rect(0, skyHeight+35, Width, 35);
  }

  void drawPIdwon(PGraphics pg, float x_trans)
  {
    pg.stroke(90, 50, 50);
    pg.push();
    pg.translate(x_trans, skyHeight+100);
    pg.rotate(0.0);
    pg.fill(140, 100, 50);
    pg.arc(0, 0, quad_width, quad_width-15, 0, PI);
    pg.pop();
  }

  void drawPIdwon_shadow(PGraphics pg, float x_trans, float shadow)
  {
    pg.noStroke();
    pg.push();
    pg.translate(x_trans, skyHeight+100);
    pg.rotate(0.0);
    pg.fill(10, 20, 10);
    pg.arc(0, 0, quad_width+shadow, quad_width+shadow, 0, PI);
    pg.pop();
  }

  void drawquad(float i, float j, float x_trans)
  {
    color c1=color(90, 50, 50);
    color c2=color(180, 90, 50);
    setGradient(pg, x_trans-(quad_width/2)+i,
      skyHeight+93-j,
      quad_width, 5, c1, c2, 2);
  }


  void drawCicle(PGraphics pg, float x_trans, float angle, int c1, int c2, int c3, float i)
  {
    pg.push();
    pg.noStroke();
    pg.fill(c1, c2, c3);
    pg.translate(x_trans-i+7, skyHeight+70+i*3);
    pg.rotate(angle);
    pg.arc(0, 0, 50, 50, 0, PI/2.0f);
    pg.pop();
  }

  void drawCicle_all(PGraphics pg, float x_trans)
  {
    for (float i=0; i<8; i++)
    {
      drawCicle(pg, x_trans+quad_width-8, 24.5, 100, 10, 10, i);
      drawCicle(pg, x_trans+quad_width-8, -2.2, 130, 110, 90, i);
      drawCicle(pg, x_trans+quad_width-8, 1, 70, 20, 10, i);
      drawCicle(pg, x_trans+quad_width-8, -3.5, 200, 160, 80, i);
    }
    pg.stroke(50, 10, 10);
    pg.fill(140, 100, 50);
    pg.ellipse(x_trans+60, skyHeight+95, 50, 50);
    pg.fill(80, 60, 20);
    pg.ellipse(x_trans+60, skyHeight+95, 35, 35);
  }

  void drawWuYan4()
  {
    for (float x_trans=50; x_trans<Width; x_trans++)
    {
      drawPIdwon_shadow(pg, x_trans+10, 10);
      drawPIdwon(pg, x_trans);
      for (float i=0; i<5; i++)
      {
        float yp=i*5;
        drawquad(i, yp, x_trans);
      }
      drawCicle_all(pg, x_trans);
      x_trans=x_trans+120;
    }
  }

  void YinxingTree(PGraphics pg)
  {
    pg.push();
    drawtree(pg, 220, 180, 0, -20, 20, random(0.6));
    drawtree(pg, 120, 60, 0, -100, 100, random(0.01));
    drawtree(pg, 120, 60, 0, -50, 160, random(0.01));
    drawtree(pg, 180, 160, 0, 40, 160, random(0.05));
    drawtree(pg, 200, 100, 0, -20, 100, random(1));
    drawtree(pg, 200, 160, 0, 0, 120, random(0.5));
    drawtree(pg, 220, 160, 0, 55, 160, random(0.1));
    drawtree(pg, 240, 200, 0, 50, 100, random(0.3));
    drawtree(pg, 240, 200, 0, 50, 180, random(0.3));
    drawtree(pg, 240, 200, 0, 80, 190, random(1));
    drawtree(pg, 220, 180, 0, -50, 80, random(0.1));
    pg.translate(150, 90);
    drawtree(pg, 220, 180, 0, -50, 150, random(0.5));
    pg.translate(-100, -150);
    drawtree(pg, 240, 200, 120, -100, 100, random(0.01));
    pg.pop();
  }

  void drawtree(PGraphics pg, int c1, int c2, int c3, float pos_x, float pos_y, float pos_angle)
  {
    pg.push();
    pg.rotate(pos_angle);
    float trans_x;
    float trans_y;
    float trans_angle;

    pg.fill(c1, c2, c3);
    for (int i=0; i<20; i++)
    {
      trans_x=random(50);
      trans_y=random(20);
      trans_angle=random(-0.5);
      pg.push();
      pg.translate(trans_x, trans_y);
      pg.rotate(trans_angle);
      drawYinXing(pg, pos_x, pos_y);
      pg.pop();
    }
    pg.pop();
  }

  void drawYinXing(PGraphics pg, float pos_x, float pos_y)
  {
    pg.stroke(200, 150, 60);
    pg.push();
    pg.translate(pos_x, pos_y);
    pg.rotate(0.0);
    pg.arc(0, 0, 30, 30, 0, PI/2);
    pg.pop();
  }

  void drawsky(PGraphics pg)
  {
    color c1 = color(90, 150, 205);
    color c2 = color(190, 200, 220);
    pg.noStroke();
    setGradient(pg, 0, 0, Width, skyHeight, c1, c2, 1);
  }

  void setGradient(PGraphics pg, float x, float y, float w, float h, color c1, color c2, int axis)
  {
    pg.noFill();
    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (float i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        pg.stroke(c);
        pg.line(x, i, x+w, i);
      }
    } else if (axis == X_AXIS) {  // Left to right gradient
      for (float k = x; k <= x+w; k++) {
        float interk = map(k, x, x+w, 0, 1);
        color ck = lerpColor(c1, c2, interk);
        pg.stroke(ck);
        pg.line(k, y, k, y+h);
      }
    }
  }

  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
