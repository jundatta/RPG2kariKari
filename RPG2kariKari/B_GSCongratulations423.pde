// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Endless collapse. Draw by openFrameworks
// https://github.com/junkiyoshi/Insta20210903
//

class GameSceneCongratulations423 extends GameSceneCongratulationsBase {
  ofMesh face;
  ofMesh frame;

  //--------------------------------------------------------------
  @Override void setup() {
    face = new ofMesh();
    frame = new ofMesh();
  }

  //--------------------------------------------------------------
  void update() {
    face.clear();
    frame.clear();

    int span = 15;
    int len = 300;
    for (int x = (int)(len * -0.5); x <= len * 0.5; x += span) {
      for (int y = len * -2; y <= len * 0.5; y += span) {
        for (int z = (int)(len * -0.5); z <= len * 0.5; z += span) {
          float noise_value = openFrameworksNoise.ofNoise(x * 0.01, z * 0.01, y * 0.01 + ofGetFrameNum() * 0.08);
          if (y > len * 0.35) {
            noise_value += map(y, len * 0.35, len, 0.25, 1);
          } else if (y < len * 0.15) {
            noise_value += map(y, len * -2, len * 0.15, -0.65, 0);
          }

          if (noise_value > 0.35) {
            //int color_value = y < len * 0.35 ? y > -len * 0.75 ? map(y, len * 0.35, -len * 0.75, 39, 128) : map(y, -len * 0.75, len * -2, 128, 239) : 39;
            int color_value = 39;
            if (y < len * 0.35) {
              if (y > -len * 0.75) {
                color_value = (int)map(y, len * 0.35, -len * 0.75, 39, 128);
              } else {
                color_value = (int)map(y, -len * 0.75, len * -2, 128, 239);
              }
            }
            setBoxToMesh(face, frame, new PVector(x, y, z), span, color(color_value), color(239));
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
    //  scale(1, -1, 1);

    // よくわかりゃん＼(^_^)／適当ｗ
    camera(0, 250, -750, 0, -100, 0, 0, -1, 0);

    background(239);

    ofRotateY(ofGetFrameNum() * 0.5);

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
  PVector makePoint(PVector location, float x, float y, float z) {
    PVector p = new PVector(x, y, z);
    p.add(location);
    return p;
  }
  void setBoxToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float hh, float ww, float depth, color face_color, color frame_color) {
    int index = face_target.getVertices().size();

    face_target.addVertex(makePoint(location, ww * -0.5 * 0.99, hh * 0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(makePoint(location, ww * 0.5 * 0.99, hh * 0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(makePoint(location, ww * 0.5 * 0.99, hh * 0.5 * 0.99, depth * 0.5 * 0.99));
    face_target.addVertex(makePoint(location, ww * -0.5 * 0.99, hh * 0.5 * 0.99, depth * 0.5 * 0.99));

    face_target.addVertex(makePoint(location, ww * -0.5 * 0.99, hh * -0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(makePoint(location, ww * 0.5 * 0.99, hh * -0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(makePoint(location, ww * 0.5 * 0.99, hh * -0.5 * 0.99, depth * 0.5 * 0.99));
    face_target.addVertex(makePoint(location, ww * -0.5 * 0.99, hh * -0.5 * 0.99, depth * 0.5 * 0.99));

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

    frame_target.addVertex(makePoint(location, ww * -0.5, hh * 0.5, depth * -0.5));
    frame_target.addVertex(makePoint(location, ww * 0.5, hh * 0.5, depth * -0.5));
    frame_target.addVertex(makePoint(location, ww * 0.5, hh * 0.5, depth * 0.5));
    frame_target.addVertex(makePoint(location, ww * -0.5, hh * 0.5, depth * 0.5));

    frame_target.addVertex(makePoint(location, ww * -0.5, hh * -0.5, depth * -0.5));
    frame_target.addVertex(makePoint(location, ww * 0.5, hh * -0.5, depth * -0.5));
    frame_target.addVertex(makePoint(location, ww * 0.5, hh * -0.5, depth * 0.5));
    frame_target.addVertex(makePoint(location, ww * -0.5, hh * -0.5, depth * 0.5));

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
