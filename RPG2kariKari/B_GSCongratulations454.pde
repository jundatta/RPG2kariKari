// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Last day of 2022. Draw by openFrameworks
// https://junkiyoshi.com/openframeworks20221231
//

class GameSceneCongratulations454 extends GameSceneCongratulationsBase {
  ofMesh mesh = new ofMesh();

  //--------------------------------------------------------------
  @Override void setup() {
  }

  //--------------------------------------------------------------
  void update() {
    ofSeedRandom(39);

    mesh.clear();

    int span = 1;
    int len = 150;

    float angle;
    PMatrix3D rotation = new PMatrix3D();
    for (int i = 0; i <= 6; i++) {
      for (int x = (int)(len * -0.5); x < len * 0.5; x += span) {
        for (int y = (int)(len * -0.5); y < len * 0.5; y += span) {
          if (i <= 4) {
            angle = PI * 0.5 * i;
            //rotation = glm::rotate(glm::mat4(), angle, glm::vec3(0, 1, 0));
            rotation.rotateY(angle);
          }

          if (i == 5) {
            angle = PI * 0.5;
            //rotation = glm::rotate(glm::mat4(), angle, glm::vec3(1, 0, 0));
            rotation.rotateX(angle);
          }

          if (i == 6) {
            angle = PI * 0.5 * 3;
            //rotation = glm::rotate(glm::mat4(), angle, glm::vec3(1, 0, 0));
            rotation.rotateX(angle);
          }

          //glm::vec3 noise_location = glm::vec4(x, y, len * 0.5, 0) * rotation;
          PVector noise_location = rotation.mult(new PVector(x, y, len * 0.5), null);
          int noise_value = (int)map(openFrameworksNoise.ofNoise(noise_location.x * 0.025, noise_location.y * 0.025, noise_location.z * 0.025, ofGetFrameNum() * 0.03), 0, 1, 0, 10);
          if (noise_value % 2 == 0) {
            continue;
          }

          ArrayList<PVector> vertices = new ArrayList();
          //vertices.push_back(glm::vec4(x, y, len * 0.5, 0) * rotation);
          //vertices.push_back(glm::vec4(x + span, y, len * 0.5, 0) * rotation);
          //vertices.push_back(glm::vec4(x + span, y + span, len * 0.5, 0) * rotation);
          //vertices.push_back(glm::vec4(x, y + span, len * 0.5, 0) * rotation);
          vertices.add(rotation.mult(new PVector(x, y, len * 0.5), null));
          vertices.add(rotation.mult(new PVector(x + span, y, len * 0.5), null));
          vertices.add(rotation.mult(new PVector(x + span, y + span, len * 0.5), null));
          vertices.add(rotation.mult(new PVector(x, y + span, len * 0.5), null));
          mesh.addVertices(vertices);

          mesh.addIndex(mesh.getNumVertices() - 1);
          mesh.addIndex(mesh.getNumVertices() - 4);
          mesh.addIndex(mesh.getNumVertices() - 3);
          mesh.addIndex(mesh.getNumVertices() - 1);
          mesh.addIndex(mesh.getNumVertices() - 2);
          mesh.addIndex(mesh.getNumVertices() - 3);
        }
      }
    }
  }

  //--------------------------------------------------------------
  // なんか違う＼(^_^)／。。。まぁいいよん♪
  // （妥協も大事ｗ深追いはせんｗ正月だしｗ（誰かわかったら教えてくれｗ））
  @Override void draw() {
    push();
    update();
    // z軸は適当ないい感じ？に感じた値。「「特に意味はない」」
    //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0) -800, 0, 0, 0, 0, 1, 0);
    translate(width/2, height/2, +400);

    background(255);

    ofRotateY(ofGetFrameNum());
    ofRotateX(ofGetFrameNum() * 1.5);

    mesh.draw(color(0));

    noStroke();
    fill(255);
    box(120);
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
