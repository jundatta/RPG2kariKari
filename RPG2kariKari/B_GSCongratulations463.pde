// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Noisy wall. Draw by openFrameworks
// https://junkiyoshi.com/openframeworks20221204/
//

class GameSceneCongratulations463 extends GameSceneCongratulationsBase {
  ofMesh mesh = new ofMesh();

  //--------------------------------------------------------------
  @Override void setup() {
  }

  //--------------------------------------------------------------
  void update() {
    ofSeedRandom(39);

    mesh.clear();

    int span = 1;    // オリジナルでの値
    //int span = 2;    // ちょっとProcessing javaでは重かったので試してみた値
    for (int i = 0; i < 3; i++) {
      float noise_seed = random(1000);
      for (int x = 0; x < width; x += span) {
        for (int y = 0; y < height; y += span) {
          float noise_value = openFrameworks.ofNoise(noise_seed, x * 0.005, y * 0.005 + ofGetFrameNum() * 0.01, ofGetFrameNum() * 0.005);
          if (noise_value <= 0.45 || noise_value >= 0.55) {
            continue;
          }

          mesh.addVertex(new PVector(x, y, 0));
          mesh.addVertex(new PVector(x + span, y, 0));
          mesh.addVertex(new PVector(x + span, y + span, 0));
          mesh.addVertex(new PVector(x, y + span, 0));

          mesh.addIndex(mesh.getNumVertices() - 1);
          mesh.addIndex(mesh.getNumVertices() - 4);
          mesh.addIndex(mesh.getNumVertices() - 3);
          mesh.addIndex(mesh.getNumVertices() - 1);
          mesh.addIndex(mesh.getNumVertices() - 2);
          mesh.addIndex(mesh.getNumVertices() - 3);

          color col = color(map(i, -1, 2, 255, 0));
          for (int k = 0; k < 4; k++) {
            mesh.addColor(col);
          }
        }
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    //translate(width/2, height/2);

    background(255);

    mesh.draw();
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
