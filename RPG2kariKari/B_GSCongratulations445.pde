// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Triangle Box. Draw by openFrameworks
// https://junkiyoshi.com/openframeworks20221221/
//

class GameSceneCongratulations445 extends GameSceneCongratulationsBase {
  @Override void setup() {
  }

  //--------------------------------------------------------------
  void update() {
    ofSeedRandom(39);
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);

    background(0);
    noFill();
    blendMode(ADD);

    ofRotateY(ofGetFrameNum() * 2);

    color col;
    for (int len = 300; len <= 300; len += 100) {
      for (int i = 0; i < 6; i++) {
        if (i < 4) {
          ofRotateX(90);
        } else if (i < 5) {
          ofRotateY(90);
        } else {
          ofRotateY(180);
        }

        for (int k = 0; k < 12; k++) {
          PVector location = new PVector(random(-len * 0.5, len * 0.5), random(-len * 0.5, len * 0.5), len * 0.5);
          int radius = (int)(random(200) + ofGetFrameNum() * 3) % 100;

          int alpha = 255;
          if (radius > 80) {
            alpha = (int)map(radius, 80, 100, 255, 128);
          }

          push();
          colorMode(HSB, 255, 255, 255, 255);
          col = color(random(255), 200, 255, alpha);
          pop();
          stroke(col);

          int deg_start = (int)random(360);
          noFill();
          beginShape();
          for (int deg = deg_start; deg < deg_start + 360; deg += 120) {
            //auto point = location + glm::vec2(radius * cos(deg * DEG_TO_RAD), radius * sin(deg * DEG_TO_RAD));
            PVector point = new PVector(
              location.x + radius * cos(deg * DEG_TO_RAD),
              location.y + radius * sin(deg * DEG_TO_RAD),
              location.z);
            if (point.y > len * 0.5) {
              point.y = len * 0.5;
            }
            if (point.y < -len * 0.5) {
              point.y = -len * 0.5;
            }
            if (point.x > len * 0.5) {
              point.x = len * 0.5;
            }
            if (point.x < -len * 0.5) {
              point.x = -len * 0.5;
            }
            vertex(point.x, point.y, point.z);
          }
          endShape(CLOSE);

          alpha = 128;
          if (radius > 80) {
            alpha = (int)map(radius, 80, 100, 128, 0);
          }

          col = color(red(col), green(col), blue(col), alpha);
          fill(col);
          beginShape();
          for (int deg = deg_start; deg < deg_start + 360; deg += 120) {
            //auto point = location + glm::vec2(radius * cos(deg * DEG_TO_RAD), radius * sin(deg * DEG_TO_RAD));
            PVector point = new PVector(
              location.x + radius * cos(deg * DEG_TO_RAD),
              location.y + radius * sin(deg * DEG_TO_RAD),
              location.z);
            if (point.y > len * 0.5) {
              point.y = len * 0.5;
            }
            if (point.y < -len * 0.5) {
              point.y = -len * 0.5;
            }
            if (point.x > len * 0.5) {
              point.x = len * 0.5;
            }
            if (point.x < -len * 0.5) {
              point.x = -len * 0.5;
            }
            vertex(point.x, point.y, point.z);
          }
          endShape(CLOSE);
        }
      }
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
