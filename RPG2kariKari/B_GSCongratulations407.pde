// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Loop. Draw by openFrameworks
// https://junkiyoshi.com/2021/09/27/
//

class GameSceneCongratulations407 extends GameSceneCongratulationsBase {
  ofMesh face = new ofMesh();
  ofMesh frame = new ofMesh();
  ArrayList<PVector> base_location_list = new ArrayList();

  //--------------------------------------------------------------
  @Override void setup() {
    for (int z = -400; z <= 400; z += 400) {
      base_location_list.add(new PVector(-400, -400, z));
      base_location_list.add(new PVector(0, -400, z));
      base_location_list.add(new PVector(400, -400, z));

      base_location_list.add(new PVector(-400, 0, z));
      base_location_list.add(new PVector(0, 0, z));
      base_location_list.add(new PVector(400, 0, z));

      base_location_list.add(new PVector(-400, 400, z));
      base_location_list.add(new PVector(0, 400, z));
      base_location_list.add(new PVector(400, 400, z));
    }
  }

  //--------------------------------------------------------------
  void update() {
    ofSeedRandom(39);

    face.clear();
    frame.clear();

    int side = 300;
    float speed = 60;
    for (var base_location : base_location_list) {
      int param_start = (int)random(100);
      int len = (int)random(10, 80);
      int gap = 100 - len;
      for (int i = param_start; i < param_start + len; i += 2) {
        PVector base, next, location;
        base = make_point(side, i);
        next = make_point(side, i + 2);

        //location = base + (next - base) / speed * (ofGetFrameNum() % (int)speed);
        PVector v = PVector.sub(next, base);
        v.div(speed);
        v.mult(ofGetFrameNum() % (int)speed);
        location = PVector.add(base, v);
        location.add(base_location);
        setBoxToMesh(face, frame, location, side / 12.6 * 0.8);
      }

      float p = param_start + len + (gap / speed) * (ofGetFrameNum() % (int)speed);
      PVector location = make_point(side, (int)p);
      location.add(base_location);
      setBoxToMesh(face, frame, location, side / 12.6 * 0.8);
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);
    scale(1, -1, 1);

    background(239);
    noFill();
    rectMode(CENTER);

    ofRotateX(295);

    stroke(139);
    for (PVector base_location : base_location_list) {
      //    ofDrawRectangle(base_location, 300, 300);
      push();
      translate(base_location.x, base_location.y, base_location.z);
      box(300, 300, 0.1f);
      pop();
    }

    // なぜかはわからにゃい＼(^_^)／が、noFill()がPShapeの.setFill()に影響して
    // face.draw(color(39))の.setFill()の設定が効かないので、noFill()状態から
    // fill()の状態に戻すため？にfill(39)を呼んでいる
    fill(39);
    face.draw(color(39));

    frame.drawWireframe(color(239));
    pop();

    logoRightLower(#ff0000);
  }

  //--------------------------------------------------------------
  void setBoxToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float size) {

    setBoxToMesh(face_target, frame_target, location, size, size, size);
  }

  //--------------------------------------------------------------
  PVector addV(PVector loc, float x, float y, float z) {
    return PVector.add(loc, new PVector(x, y, z));
  }
  void setBoxToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float height, float width, float depth) {
    int face_index = face_target.getNumVertices();
    int frame_index = frame_target.getNumVertices();

    face_target.addVertex(addV(location, width * -0.5 * 0.99, height * 0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(addV(location, width * 0.5 * 0.99, height * 0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(addV(location, width * 0.5 * 0.99, height * 0.5 * 0.99, depth * 0.5 * 0.99));
    face_target.addVertex(addV(location, width * -0.5 * 0.99, height * 0.5 * 0.99, depth * 0.5 * 0.99));

    face_target.addVertex(addV(location, width * -0.5 * 0.99, height * -0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(addV(location, width * 0.5 * 0.99, height * -0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(addV(location, width * 0.5 * 0.99, height * -0.5 * 0.99, depth * 0.5 * 0.99));
    face_target.addVertex(addV(location, width * -0.5 * 0.99, height * -0.5 * 0.99, depth * 0.5 * 0.99));

    face_target.addIndex(face_index + 0);
    face_target.addIndex(face_index + 1);
    face_target.addIndex(face_index + 2);
    face_target.addIndex(face_index + 0);
    face_target.addIndex(face_index + 2);
    face_target.addIndex(face_index + 3);

    face_target.addIndex(face_index + 4);
    face_target.addIndex(face_index + 5);
    face_target.addIndex(face_index + 6);
    face_target.addIndex(face_index + 4);
    face_target.addIndex(face_index + 6);
    face_target.addIndex(face_index + 7);

    face_target.addIndex(face_index + 0);
    face_target.addIndex(face_index + 4);
    face_target.addIndex(face_index + 1);
    face_target.addIndex(face_index + 4);
    face_target.addIndex(face_index + 5);
    face_target.addIndex(face_index + 1);

    face_target.addIndex(face_index + 1);
    face_target.addIndex(face_index + 5);
    face_target.addIndex(face_index + 6);
    face_target.addIndex(face_index + 6);
    face_target.addIndex(face_index + 2);
    face_target.addIndex(face_index + 1);

    face_target.addIndex(face_index + 2);
    face_target.addIndex(face_index + 6);
    face_target.addIndex(face_index + 7);
    face_target.addIndex(face_index + 7);
    face_target.addIndex(face_index + 3);
    face_target.addIndex(face_index + 2);

    face_target.addIndex(face_index + 3);
    face_target.addIndex(face_index + 7);
    face_target.addIndex(face_index + 4);
    face_target.addIndex(face_index + 4);
    face_target.addIndex(face_index + 0);
    face_target.addIndex(face_index + 3);

    frame_target.addVertex(addV(location, width * -0.5, height * 0.5, depth * -0.5));
    frame_target.addVertex(addV(location, width * 0.5, height * 0.5, depth * -0.5));
    frame_target.addVertex(addV(location, width * 0.5, height * 0.5, depth * 0.5));
    frame_target.addVertex(addV(location, width * -0.5, height * 0.5, depth * 0.5));

    frame_target.addVertex(addV(location, width * -0.5, height * -0.5, depth * -0.5));
    frame_target.addVertex(addV(location, width * 0.5, height * -0.5, depth * -0.5));
    frame_target.addVertex(addV(location, width * 0.5, height * -0.5, depth * 0.5));
    frame_target.addVertex(addV(location, width * -0.5, height * -0.5, depth * 0.5));

    frame_target.addIndex(frame_index + 0);
    frame_target.addIndex(frame_index + 1);
    frame_target.addIndex(frame_index + 1);
    frame_target.addIndex(frame_index + 2);
    frame_target.addIndex(frame_index + 2);
    frame_target.addIndex(frame_index + 3);
    frame_target.addIndex(frame_index + 3);
    frame_target.addIndex(frame_index + 0);

    frame_target.addIndex(frame_index + 4);
    frame_target.addIndex(frame_index + 5);
    frame_target.addIndex(frame_index + 5);
    frame_target.addIndex(frame_index + 6);
    frame_target.addIndex(frame_index + 6);
    frame_target.addIndex(frame_index + 7);
    frame_target.addIndex(frame_index + 7);
    frame_target.addIndex(frame_index + 4);

    frame_target.addIndex(frame_index + 0);
    frame_target.addIndex(frame_index + 4);
    frame_target.addIndex(frame_index + 1);
    frame_target.addIndex(frame_index + 5);
    frame_target.addIndex(frame_index + 2);
    frame_target.addIndex(frame_index + 6);
    frame_target.addIndex(frame_index + 3);
    frame_target.addIndex(frame_index + 7);
  }

  //--------------------------------------------------------------
  PVector make_point(int len, int param) {
    param = param % 100;
    if (param < 25) {
      return new PVector(map(param, 0, 25, -len * 0.5, len * 0.5), -len * 0.5);
    }
    if (param < 50) {
      return new PVector(len * 0.5, map(param, 25, 50, -len * 0.5, len * 0.5));
    }
    if (param < 75) {
      return new PVector(map(param, 50, 75, len * 0.5, -len * 0.5), len * 0.5);
    }
    return new PVector(-len * 0.5, map(param, 75, 100, len * 0.5, -len * 0.5));
  }
  
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
