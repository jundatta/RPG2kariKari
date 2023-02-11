// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Numbers on the box. Draw by openFrameworks
// https://junkiyoshi.com/2023/02/07/
//

class GameSceneCongratulations495 extends GameSceneCongratulationsBase {
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
  }

  //--------------------------------------------------------------
  void update() {
    ofSeedRandom(39);
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();

    translate(width * 0.5f, height * 0.5f);
    scale(1.5);

    background(0);
    ofSetLineWidth(2);
    colorMode(HSB, 255, 255, 255, 255);

    ofRotateY(ofGetFrameNum() * 0.333333333333);
    ofRotateX(ofGetFrameNum() * 0.666666666666);

    noFill();
    int len = 200;
    for (int i = 0; i < 8; i++) {
      if (i < 4) {
        ofRotateX(90);
      } else if (i < 5) {
        ofRotateY(90);
      } else {
        ofRotateY(180);
      }

      for (int k = 0; k < 30; k++) {
        ArrayList<ofOutlineCoord> outline = path_list.get(k % path_list.size());

        PVector location = new PVector(random(-len * 0.5, len * 0.5), random(-len * 0.5, len * 0.5), len * 0.5);
        int radius = (int)(random(1000) + ofGetFrameNum()) % 150 - 100;
        color ccc = color(random(255), 180, 255);

        float angle = random(-PI * 2, PI * 2);
        //auto rotation = glm::rotate(glm::mat4(), angle, glm::vec3(0, 0, 1));
        PMatrix3D rotation = new PMatrix3D();
        rotation.rotateZ(angle);

        if (radius > 0) {
          fill(ccc, radius > 25 ? (int)map(radius, 25, 50, 255, 0) : 255);
          stroke(ccc, radius > 25 ? (int)map(radius, 25, 80, 32, 0) : 32);
          beginShape();
          for (int outline_index = 0; outline_index < outline.size(); outline_index++) {
            ArrayList<PVector> vertices = outline.get(outline_index).vertices;
            beginContour();
            for (int vertices_index = 0; vertices_index < vertices.size(); vertices_index++) {
              //glm::vec3 vertex = location + glm::vec4(((vertices[vertices_index] - glm::vec2(25, -25)) / 50) * radius * 2, 0) * rotation;
              PVector v = vertices.get(vertices_index);
              PVector vv = new PVector(v.x - 25, v.y - (-25), v.z);
              vv.div(50);
              vv.mult(radius * 2);
              vv = rotation.mult(vv, null);
              PVector vertex = PVector.add(location, vv);
              vertex.z += k;
              if (vertex.y > len * 0.5) {
                vertex.y = len * 0.5;
              }
              if (vertex.y < -len * 0.5) {
                vertex.y = -len * 0.5;
              }
              if (vertex.x > len * 0.5) {
                vertex.x = len * 0.5;
              }
              if (vertex.x < -len * 0.5) {
                vertex.x = -len * 0.5;
              }
              vertex(vertex.x, vertex.y, vertex.z);
            }
            endContour();
          }
          endShape(CLOSE);
        }
      }

      noStroke();
      fill(0);
      box(len * 0.95);
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
