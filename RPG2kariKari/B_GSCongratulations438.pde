// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】White to Black. Draw by openFrameworks
// https://junkiyoshi.com/2021/02/28/
//

class GameSceneCongratulations438 extends GameSceneCongratulationsBase {
  ofMesh frame = new ofMesh();
  float noise_param;

  //--------------------------------------------------------------
  @Override void setup() {
  }

  //--------------------------------------------------------------
  void update() {
    ofSeedRandom(39);
    frame.clear();

    for (int len = 100; len <= 350; len += 250) {
      PVector noise_seed = new PVector(random(1000), random(1000), random(1000));
      for (int i = 0; i < 20; i++) {
        float angle_x = map(openFrameworksNoise.ofNoise(noise_seed.x, (ofGetFrameNum() + i) * 0.003), 0, 1, -PI, PI);
        float angle_y = map(openFrameworksNoise.ofNoise(noise_seed.y, (ofGetFrameNum() + i) * 0.003), 0, 1, -PI, PI);
        float angle_z = map(openFrameworksNoise.ofNoise(noise_seed.z, (ofGetFrameNum() + i) * 0.003), 0, 1, -PI, PI);

        PMatrix3D rotation = new PMatrix3D();
        rotation.rotateX(angle_x);
        rotation.rotateY(angle_y);
        rotation.rotateZ(angle_z);

        int index = frame.getNumVertices();
        ArrayList<PVector> vertices = new ArrayList();

        vertices.add(new PVector(len * -0.5, len * 0.5, len * -0.5));
        vertices.add(new PVector(len * 0.5, len * 0.5, len * -0.5));
        vertices.add(new PVector(len * 0.5, len * 0.5, len * 0.5));
        vertices.add(new PVector(len * -0.5, len * 0.5, len * 0.5));

        vertices.add(new PVector(len * -0.5, len * -0.5, len * -0.5));
        vertices.add(new PVector(len * 0.5, len * -0.5, len * -0.5));
        vertices.add(new PVector(len * 0.5, len * -0.5, len * 0.5));
        vertices.add(new PVector(len * -0.5, len * -0.5, len * 0.5));

        // もとは参照型でした。なのでverticesを書き換えるようにコーディングする
        //     for (auto& vertex : vertices) {
        ArrayList<PVector> newV = new ArrayList();
        for (PVector vertex : vertices) {
          //vertex = glm::vec4(vertex, 0) * rotation_z * rotation_y * rotation_x;
          vertex = rotation.mult(vertex, null);
          newV.add(vertex);
          frame.addColor(color(map(i, 0, 20, 39, 239)));
        }
        vertices = newV;

        frame.addVertices(vertices);

        frame.addIndex(index + 0);
        frame.addIndex(index + 1);
        frame.addIndex(index + 1);
        frame.addIndex(index + 2);
        frame.addIndex(index + 2);
        frame.addIndex(index + 3);
        frame.addIndex(index + 3);
        frame.addIndex(index + 0);

        frame.addIndex(index + 4);
        frame.addIndex(index + 5);
        frame.addIndex(index + 5);
        frame.addIndex(index + 6);
        frame.addIndex(index + 6);
        frame.addIndex(index + 7);
        frame.addIndex(index + 7);
        frame.addIndex(index + 4);

        frame.addIndex(index + 0);
        frame.addIndex(index + 4);
        frame.addIndex(index + 1);
        frame.addIndex(index + 5);
        frame.addIndex(index + 2);
        frame.addIndex(index + 6);
        frame.addIndex(index + 3);
        frame.addIndex(index + 7);
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);

    background(139);
    stroke(39);
    strokeWeight(3);

    frame.drawWireframe();
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
