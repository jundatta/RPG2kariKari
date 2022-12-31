// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】camp fire. Draw by openFrameworks
// https://junkiyoshi.com/openframeworks20221222/
//

class GameSceneCongratulations449 extends GameSceneCongratulationsBase {
  ofMesh face = new ofMesh();
  ofMesh frame = new ofMesh();

  //--------------------------------------------------------------
  @Override void setup() {
  }

  //--------------------------------------------------------------
  void update() {
    face.clear();
    frame.clear();

    int span = 10;
    int len = 300;
    color col;
    for (int x = (int)(len * -0.5); x <= len * 0.5; x += span) {
      for (int y = len * -2; y <= len * 0; y += span) {
        for (int z = (int)(len * -0.5); z <= len * 0.5; z += span) {
          float noise_value = openFrameworks.ofNoise(x * 0.01, z * 0.01, y * 0.01 + ofGetFrameNum() * 0.08);
          PVector loc = new PVector(x, y, z);
          float length = loc.mag();

          if (y > len * 0.35) {
            noise_value += map(y, len * 0.35, len, 0.25, 1);
          } else if (y < len * 0.15) {
            noise_value += map(y, len * -2, len * 0.15, -0.65, 0);
          }

          if (noise_value > 0.35) {
            //color.setHsb(0, ofMap(length, 0, len, 0, 255), ofMap(length, 0, len, 0, 255));
            push();
            colorMode(HSB, 255, 255, 255, 255);
            col = color(0, map(length, 0, len, 0, 255), map(length, 0, len, 0, 255));
            pop();
            int alpha = y > len * 0 ? 255 : (int)map(y, len * -2, len * 0, 0, 255);
            color face_color = color(red(col), green(col), blue(col), alpha);
            color frame_color = color(255, alpha);
            setBoxToMesh(face, frame, loc, span, face_color, frame_color);
          }
        }
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);

    scale(1, -1, 1);
    translate(0, -(height * 0.3f), 0);

    background(0);

    ofRotateX(180);
    ofRotateY(ofGetFrameNum() * 0.3333333333);

    face.draw();
    frame.drawWireframe();
    pop();

    logoRightLower(#ff0000);
  }

  //--------------------------------------------------------------
  void setBoxToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float size, color face_color, color frame_color) {
    setBoxToMesh(face_target, frame_target, location, size, size, size, face_color, frame_color);
  }

  //--------------------------------------------------------------
  PVector makeLocation(PVector loc, float x, float y, float z) {
    return new PVector(loc.x + x, loc.y + y, loc.z + z);
  }
  void setBoxToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float height, float width, float depth, color face_color, color frame_color) {
    int index = face_target.getVertices().size();

    face_target.addVertex(makeLocation(location, width * -0.5 * 0.99, height * 0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(makeLocation(location, width * 0.5 * 0.99, height * 0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(makeLocation(location, width * 0.5 * 0.99, height * 0.5 * 0.99, depth * 0.5 * 0.99));
    face_target.addVertex(makeLocation(location, width * -0.5 * 0.99, height * 0.5 * 0.99, depth * 0.5 * 0.99));

    face_target.addVertex(makeLocation(location, width * -0.5 * 0.99, height * -0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(makeLocation(location, width * 0.5 * 0.99, height * -0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(makeLocation(location, width * 0.5 * 0.99, height * -0.5 * 0.99, depth * 0.5 * 0.99));
    face_target.addVertex(makeLocation(location, width * -0.5 * 0.99, height * -0.5 * 0.99, depth * 0.5 * 0.99));

    face_target.addIndex(index + 0);
    face_target.addIndex(index + 1);
    face_target.addIndex(index + 2);
    face_target.addIndex(index + 0);
    face_target.addIndex(index + 2);
    face_target.addIndex(index + 3);

    face_target.addIndex(index + 4);
    face_target.addIndex(index + 5);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 7);

    face_target.addIndex(index + 0);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 1);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 5);
    face_target.addIndex(index + 1);

    face_target.addIndex(index + 1);
    face_target.addIndex(index + 5);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 2);
    face_target.addIndex(index + 1);

    face_target.addIndex(index + 2);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 7);
    face_target.addIndex(index + 7);
    face_target.addIndex(index + 3);
    face_target.addIndex(index + 2);

    face_target.addIndex(index + 3);
    face_target.addIndex(index + 7);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 0);
    face_target.addIndex(index + 3);

    frame_target.addVertex(makeLocation(location, width * -0.5, height * 0.5, depth * -0.5));
    frame_target.addVertex(makeLocation(location, width * 0.5, height * 0.5, depth * -0.5));
    frame_target.addVertex(makeLocation(location, width * 0.5, height * 0.5, depth * 0.5));
    frame_target.addVertex(makeLocation(location, width * -0.5, height * 0.5, depth * 0.5));

    frame_target.addVertex(makeLocation(location, width * -0.5, height * -0.5, depth * -0.5));
    frame_target.addVertex(makeLocation(location, width * 0.5, height * -0.5, depth * -0.5));
    frame_target.addVertex(makeLocation(location, width * 0.5, height * -0.5, depth * 0.5));
    frame_target.addVertex(makeLocation(location, width * -0.5, height * -0.5, depth * 0.5));

    frame_target.addIndex(index + 0);
    frame_target.addIndex(index + 1);
    frame_target.addIndex(index + 1);
    frame_target.addIndex(index + 2);
    frame_target.addIndex(index + 2);
    frame_target.addIndex(index + 3);
    frame_target.addIndex(index + 3);
    frame_target.addIndex(index + 0);

    frame_target.addIndex(index + 4);
    frame_target.addIndex(index + 5);
    frame_target.addIndex(index + 5);
    frame_target.addIndex(index + 6);
    frame_target.addIndex(index + 6);
    frame_target.addIndex(index + 7);
    frame_target.addIndex(index + 7);
    frame_target.addIndex(index + 4);

    frame_target.addIndex(index + 0);
    frame_target.addIndex(index + 4);
    frame_target.addIndex(index + 1);
    frame_target.addIndex(index + 5);
    frame_target.addIndex(index + 2);
    frame_target.addIndex(index + 6);
    frame_target.addIndex(index + 3);
    frame_target.addIndex(index + 7);

    for (int i = 0; i < 8; i++) {
      face_target.addColor(face_color);
      frame_target.addColor(frame_color);
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
