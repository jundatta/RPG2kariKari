// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Noisy crown. openFrameworks
// https://junkiyoshi.com/openframeworks20191204/
//

class GameSceneCongratulations459 extends GameSceneCongratulationsBase {
  ArrayList<ofMesh> face_list = new ArrayList();
  ArrayList<ofMesh> frame_list = new ArrayList();

  //--------------------------------------------------------------
  @Override void setup() {
  }

  //--------------------------------------------------------------
  void update() {
    face_list.clear();
    frame_list.clear();

    for (int radius = 50; radius < 350; radius += 30) {
      ofMesh face = new ofMesh();
      ofMesh frame = new ofMesh();

      for (int deg = 0; deg <= 360; deg += 1) {
        int index = face.getNumVertices() - 2;

        PVector location = new PVector(radius * cos(deg * DEG_TO_RAD), radius * sin(deg * DEG_TO_RAD));
        //int z = ofMap(ofNoise(glm::vec3(location * 0.005, ofGetFrameNum() * 0.005)), 0, 1, 0, radius);
        PVector noiseSource = new PVector(location.x * 0.005, location.y * 0.005, ofGetFrameNum() * 0.005);
        int z = (int)map(openFrameworksNoise.ofNoise(noiseSource.x, noiseSource.y, noiseSource.z), 0, 1, 0, radius);

        face.addVertex(new PVector(location.x, location.y, 0));
        face.addVertex(new PVector(location.x, location.y, z));

        frame.addVertex(new PVector(location.x, location.y, 0));
        frame.addVertex(new PVector(location.x, location.y, z));

        if (index > -1) {
          face.addIndex(index);
          face.addIndex(index + 1);
          face.addIndex(index + 3);
          face.addIndex(index);
          face.addIndex(index + 2);
          face.addIndex(index + 3);

          frame.addIndex(index);
          frame.addIndex(index + 2);
          frame.addIndex(index + 1);
          frame.addIndex(index + 3);
        }
      }

      face_list.add(face);
      frame_list.add(frame);
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);

    // いい感じに感じる適当な（カメラじゃなくてゴメン）
    translate(0, (height/2) * 0.1, 0);
    ofRotateX(60);

    background(239);
    for (int i = 0; i < face_list.size(); i++) {
      face_list.get(i).draw(color(39));
      frame_list.get(i).drawWireframe(color(239));
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
