// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Richard Bourneさん
// 【作品名】Candles
// https://openprocessing.org/sketch/1777807
//

class GameSceneCongratulations466 extends GameSceneCongratulationsBase {
  float lightA;
  float lightB;
  float lightC;
  float lightD;

  int OrgW = 700;
  int OrgH = 700;
  PGraphics pg;

  @Override void setup() {
    lightA = 0;
    lightB = 0;
    lightC = 0;
    lightD = 0;

    pg = createGraphics(OrgW, OrgH);
  }
  @Override void draw() {
    push();
    background(0);
    pg.beginDraw();
    pg.background(0, 0, 0);
    pg.translate(0, -270);
    pg.scale(1.9);
    pg.noStroke();
    pg.rectMode(CORNERS);
    pg.ellipseMode(RADIUS);
    pg.smooth(4);
    pg.translate(-5, 0);

    ////////////////////////////////////////////*left*/
    pg.translate(0, -5);
    pg.fill(200, 80, 38, 30);  /*bot glow*/
    pg.ellipse(98, 251, 55, 55);
    pg.translate(0, 5);

    pg.fill(255, 113, 13);  /*base*/

    pg.rect(40, 280, 160, 500);
    pg.fill(158, 45, 3, 70);
    pg.quad(40, 280, 80, 280, 130, 500, 40, 500);
    pg.quad(40, 310, 60, 310, 120, 500, 40, 500);
    pg.fill(255, 173, 55, 70);
    pg.quad(160, 280, 100, 280, 130, 400, 160, 400);

    pg.fill(230, 92, 9);  /*bronze*/
    pg.ellipse(100, 278, 60, 15);

    pg.fill(255, 167, 73, 120); /*90*/
    pg.ellipse(100, 275, 55, 12);

    pg.fill(255, 216, 61, 150); /*70*/
    pg.ellipse(100, 272, 48, 7);

    pg.fill(253, 229, 77, 150); /*50*/
    pg.ellipse(100, 270, 25, 4);

    /*line*/
    pg.strokeWeight(3);
    pg.stroke(89, 36, 27); /*black red*/
    pg.line(98, 265, 98, 270);

    pg.noStroke(); /*reflection*/
    pg.fill(252, 255, 59, 100);
    pg.ellipse(lightB+130, lightB+305, 1.75, 10);
    pg.ellipse(lightB+130, lightB+330, 1.2, 5);

    /*------------------LIGHT*/
    pg.translate(0, -5);
    pg.fill(200, 80, 38, 50);  /*bot glow*/
    pg.ellipse(98, 251, 35, 35);
    pg.fill(255, 125, 80, 80);  /*bot glow top*/
    pg.ellipse(98, 251, 25, 25);

    pg.fill(224, 148, 0, 140); /*mid glow*/
    pg.ellipse(lightC+98, 251, 12, 15);

    pg.fill(255, 237, 151, 200); /*main*/
    pg.ellipse(98, lightA+251, 7, 20);
    pg.fill(255, 255, 218, 140); /*mainsmall*/
    pg.ellipse(98, lightA+254, 2, 10);

    pg.fill(251, 243, 228, 80); /*top red*/
    pg.ellipse(lightB+98, 251, 18, 17);
    pg.translate(0, +5);

    pg.fill(252, 255, 212, 180);   /*le moving shinez*/
    pg.ellipse(lightB+101, 278, 11, 3);
    /*------------------ END LIGHT*/

    /////////////////////////////////////////////*right*/
    pg.noStroke();
    pg.fill(200, 80, 38, 30);  /*bot glow*/
    pg.ellipse(270, 205, 60, 60);

    pg.fill(216, 92, 0); /*base*/
    pg.rect(204, 240, 336, 500);
    pg.fill(158, 45, 3, 70); /*shadowz*/
    pg.quad(336, 240, 300, 240, 280, 500, 336, 500);
    pg.quad(336, 280, 320, 280, 300, 500, 336, 500);
    pg.fill(255, 152, 28, 90); /*highlight*/
    pg.quad(204, 240, 260, 240, 240, 400, 204, 400);

    pg.fill(216, 92, 0);
    pg.ellipse(270, 240, 66, 17);
    pg.fill(158, 45, 3, 70);/*shadbronze*/
    pg.ellipse(270, 241, 65, 16);

    pg.fill(255, 175, 73, 120); /*90*/
    pg.ellipse(270, 235, 59, 11);
    pg.fill(255, 217, 61, 150); /*70*/
    pg.ellipse(270, 233, 50, 8);
    pg.fill(253, 230, 77, 150); /*50*/
    pg.ellipse(270, 230, 28, 5);

    /*line*/
    pg.strokeWeight(3);
    pg.stroke(89, 36, 27); /*black red*/
    pg.line(270, 225, 270, 230);

    pg.noStroke(); /*reflection*/
    pg.fill(252, 255, 164, 80);
    pg.ellipse(lightC+215, lightC+270, 1.55, 10);
    pg.ellipse(lightB+230, lightB+303, 1.75, 14);

    pg.fill(252, 255, 212, 180);   /*le moving shinez*/
    pg.ellipse(lightB+270, 240, 12, 3);

    /*------------------LIGHT*/
    pg.noStroke();
    pg.fill(200, 80, 38, 50);  /*bot glow*/
    pg.ellipse(270, 205, 35, 35);
    pg.fill(255, 125, 80, 80);  /*bot glow top*/
    pg.ellipse(270, 205, 25, 25);

    pg.fill(224, 148, 0, 140);  /*mid glow*/
    pg.ellipse(lightB+270, 205, 12, 16);

    pg.fill(255, 237, 151, 200); /*main*/
    pg.ellipse(270, lightA+203, 7, 23);
    pg.fill(255, 255, 218, 140); /*mainsmall*/
    pg.ellipse(270, lightA+206, 2, 13);
    pg.fill(251, 243, 228, 80); /*top red*/
    pg.ellipse(lightC+270, 205, 18, 17);
    /*------------------ END LIGHT*/

    //////////////////////////////////////////////*middle*/
    pg.fill(255, 132, 0); /*base*/
    pg.rect(140, 340, 260, 500);
    pg.fill(158, 45, 3, 40); /*shadowz*/
    pg.rect(140, 340, 260, 500);
    pg.rect(140, 365, 260, 500);
    pg.rect(140, 385, 260, 500);
    pg.fill(255, 132, 0); /*base*/
    pg.ellipse(200, 340, 60, 14);

    pg.fill(255, 152, 5, 180);
    pg.ellipse(201, 337, 55, 12);

    pg.fill(255, 216, 61, 150); /*70*/
    pg.ellipse(198, 335, 45, 7);
    pg.fill(253, 229, 77, 150); /*50*/
    pg.ellipse(198, 335, 25, 4);
    pg.strokeWeight(3);
    pg.stroke(89, 36, 27); /*black red*/
    pg.line(198, 331, 198, 336);

    /*------------------LIGHT*/

    pg.noStroke();
    pg.fill(200, 80, 38, 50);  /*bot glow*/
    pg.ellipse(198, 312, 35, 35);
    pg.fill(255, 125, 80, 80);  /*bot glow top*/
    pg.ellipse(198, 312, 25, 25);

    pg.fill(224, 148, 0, 170);  /*mid yellow*/
    pg.ellipse(lightB+198, 312, 12, 17);
    pg.fill(255, 237, 151, 200); /*main*/
    pg.ellipse(198, lightA+312, 7, 20);
    pg.fill(255, 255, 218, 140); /*mainsmall*/
    pg.ellipse(198, lightA+315, 2, 13);
    pg.fill(251, 243, 228, 80); /*top red*/
    pg.ellipse(lightC+198, 312, 18, 17);

    pg.noStroke();
    pg.fill(252, 255, 212, 180);   /*le moving shinez*/
    pg.ellipse(lightB+198, 346, 10, 2);
    /*------------------ END LIGHT*/

    pg.fill(0, 0, 0, 50);
    pg.rect(40, 400, 350, 501);  // よくわかりゃんが500+1した
    pg.fill(0, 0, 0, 100);
    pg.rect(40, 430, 350, 501);  // よくわかりゃんが500+1した
    pg.rect(40, 460, 350, 501);  // よくわかりゃんが500+1した
    pg.rect(40, 480, 350, 501);  // よくわかりゃんが500+1した

    lightA = lightA + random(-0.07, 0.07);
    lightB = lightB + random(-0.2, 0.2);
    lightC = lightC + random(-0.2, 0.2);
    lightD = lightD + random(-0.15, 0.15);

    pg.endDraw();
    image(pg, (width - OrgW)/2, (height - OrgH)/2);
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
