// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Generating numbers. Draw by openFrameworks
// https://junkiyoshi.com/2023/02/01/
//

class GameSceneCongratulations493 extends GameSceneCongratulationsBase {
  FloatList radius_list = new FloatList();
  FloatList speed_list = new FloatList();
  ArrayList<PVector> rotation_list = new ArrayList();
  IntList index_list = new IntList();

  ArrayList<ArrayList<ofOutlineCoord>> path_list = new ArrayList();

  //--------------------------------------------------------------
  @Override void setup() {
    ArrayList<ofOutline> outlineWords = openFrameworksOutline.ofOutline();
    String word = "0123456789";
    char[] charArray = word.toCharArray();
    for (char c : charArray) {
      for (ofOutline out : outlineWords) {
        if (c == out.code) {
          path_list.add(out.coord);
          break;
        }
      }
    }

    for (int i = 0; i < 300; i++) {
      radius_list.append(random(50, 300));
      speed_list.append(random(3, 7));
      rotation_list.add(new PVector(random(360), random(360), random(360)));
      index_list.append((int)random(word.length()));
    }
  }

  //--------------------------------------------------------------
  void update() {
    for (int i = 0; i < radius_list.size(); i++) {
      int r = (int)(radius_list.get(i) + speed_list.get(i)) % 300;
      radius_list.set(i, r);
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();

    translate(width * 0.5f, height * 0.5f);

    background(0);
    ofSetLineWidth(2);

    ofRotateY(ofGetFrameNum() * 0.7);
    ofRotateX(ofGetFrameNum() * 1.2);

    for (int i = 0; i < radius_list.size(); i++) {
      ofRotateZ(rotation_list.get(i).z);
      ofRotateY(rotation_list.get(i).y);
      ofRotateX(rotation_list.get(i).x);

      pushMatrix();

      translate(-8, 15, radius_list.get(i) + 35);

      ArrayList<ofOutlineCoord> outline = path_list.get(index_list.get(i));

      int alpha = radius_list.get(i) < 200 ? 100 : (int)map(radius_list.get(i), 200, 330, 100, 0);

      noStroke();
      fill(255, alpha);
      beginShape();
      for (int outline_index = 0; outline_index < outline.size(); outline_index++) {
        beginContour();
        ArrayList<PVector> vertices = outline.get(outline_index).vertices;
        for (PVector v : vertices) {
          vertex(v.x, v.y, v.z);
        }
        endContour();
      }
      endShape(CLOSE);

      alpha = radius_list.get(i) < 200 ? 255 : (int)map(radius_list.get(i), 200, 330, 255, 0);

      noFill();
      stroke(255, alpha);
      beginShape();
      for (int outline_index = 0; outline_index < outline.size(); outline_index++) {
        beginContour();
        ArrayList<PVector> vertices = outline.get(outline_index).vertices;
        for (PVector v : vertices) {
          vertex(v.x, v.y, v.z);
        }
        endContour();
      }
      endShape(CLOSE);

      popMatrix();
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
